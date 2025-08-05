<#!
.SYNOPSIS
  Factorio Dedicated Server Manager (PowerShell Edition)
.DESCRIPTION
  Launches and manages a local Factorio server with credential-verified downloads.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

$scriptRoot = $PSScriptRoot
$InstallDir = Join-Path $scriptRoot "Factorio"
$SavesDir   = Join-Path $env:APPDATA "Factorio\saves"
$LogDir     = Join-Path $scriptRoot "logs"
$startupLog = Join-Path $LogDir "startup.log"
if (!(Test-Path $LogDir)) { [System.IO.Directory]::CreateDirectory($LogDir) | Out-Null }
Add-Content -Path $startupLog -Value "[INIT] Script launched at $(Get-Date)"

$windowsIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
$windowsPrincipal = New-Object Security.Principal.WindowsPrincipal($windowsIdentity)
$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
if (-not $windowsPrincipal.IsInRole($adminRole)) {
    Add-Content -Path $startupLog -Value "[INFO] Relaunching with elevated privileges."
    Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$logFile = Join-Path $LogDir ("session_" + (Get-Date -Format "yyyyMMdd_HHmmss") + ".log")
Start-Transcript -Path $logFile -Append -Force

function Request-FactorioToken {
    do {
        $username = Read-Host "Enter your Factorio.com username"
        $password = Read-Host -AsSecureString "Enter your Factorio.com password"
        $plainPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
        $postBody = @{ username = $username; password = $plainPass; api_version = 6 } | ConvertTo-Json

        try {
            $response = Invoke-RestMethod -Method Post -Uri "https://auth.factorio.com/api-login" -Body $postBody -ContentType 'application/json'
            if ($response.token) {
                return @{ username = $username; token = $response.token }
            } else {
                Write-Warning "[ERROR] Login failed: No token returned"
            }
        } catch {
            Write-Warning "[ERROR] Login failed: $($_.Exception.Message)"
        }
    } while ($true)
}

function Ensure-FactorioInstalled {
    Write-Verbose "Checking if Factorio is installed."
    $exePath = Join-Path $InstallDir 'bin\x64\factorio.exe'
    if (!(Test-Path $exePath)) {
        Write-Host "[INFO] Validating credentials for Factorio download..."
        $creds = Request-FactorioToken
        $zipUrl = "https://factorio.com/get-download/stable/headless/windows64?username=$($creds.username)&token=$($creds.token)"
        $zipFile = Join-Path $env:TEMP "factorio_server.zip"
        Invoke-WebRequest -Uri $zipUrl -OutFile $zipFile -UseBasicParsing
        Expand-Archive -Path $zipFile -DestinationPath $InstallDir -Force
        Remove-Item $zipFile
        Write-Host "[INFO] Factorio installed to $InstallDir"
    }
    return $exePath
}

function Ensure-SettingsFile {
    $template = Join-Path $InstallDir 'data\server-settings.example.json'
    $settings = Join-Path $InstallDir 'data\server-settings.json'
    if (!(Test-Path $settings) -and (Test-Path $template)) {
        Copy-Item $template $settings
        Write-Host "[INFO] server-settings.json created."
    }
}

function Show-MainMenu {
    Clear-Host
    Write-Host "=== Factorio Server Manager ==="
    Write-Host "1. Load latest save"
    Write-Host "2. Choose save manually"
    Write-Host "3. Edit server settings"
    Write-Host "4. Launch blank server"
    Write-Host "5. Exit"
    return Read-Host "Select option (1-5)"
}

function Launch-Server {
    param (
        [string]$Exe,
        [string]$SaveFile = $null
    )
    $args = if ($SaveFile) { @('--start-server', $SaveFile) } else { @('--start-server') }
    Write-Host "[INFO] Starting Factorio server..."
    Start-Process -FilePath $Exe -ArgumentList $args -NoNewWindow -Wait
}

try {
    $factorioExe = Ensure-FactorioInstalled
    Ensure-SettingsFile
    if (!(Test-Path $SavesDir)) { New-Item -Path $SavesDir -ItemType Directory -Force | Out-Null }

    while ($true) {
        $choice = Show-MainMenu
        switch ($choice) {
            '1' {
                $latest = Get-ChildItem -Path $SavesDir -Filter "*.zip" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
                if ($latest) {
                    Launch-Server -Exe $factorioExe -SaveFile $latest.FullName
                } else {
                    Write-Host "[WARN] No save files found."
                }
            }
            '2' {
                $selection = Get-ChildItem -Path $SavesDir -Filter "*.zip" | Out-GridView -Title "Select Save File" -PassThru
                if ($selection) {
                    Launch-Server -Exe $factorioExe -SaveFile $selection.FullName
                }
            }
            '3' {
                notepad (Join-Path $InstallDir 'data\server-settings.json')
            }
            '4' {
                Launch-Server -Exe $factorioExe
            }
            '5' {
                break
            }
            default {
                Write-Warning "Invalid input."
            }
        }
    }
} catch {
    Write-Error "[FATAL] $($_.Exception.Message)"
    Add-Content -Path $startupLog -Value "[FATAL] Exception: $($_.Exception.Message)"
} finally {
    Stop-Transcript
    Add-Content -Path $startupLog -Value "[END] Script ended at $(Get-Date)"
}