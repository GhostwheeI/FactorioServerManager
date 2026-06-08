@echo off
:: Factorio Dedicated Server Manager Batch Script
:: By: Ghostwheel
:: Last Updated: Space Age Release
:: Version 1.1
:: -----------------------------------------------
:: This script validates, manages, and runs a Factorio Dedicated Server
:: with support for save files, server settings, and elevated privileges.

:: Variables
set "BaseDir=%~dp0"
set "FactorioExe=%~dp0Factorio\bin\x64\factorio.exe"
set "ExampleSettings=%~dp0Factorio\data\server-settings.example.json"
set "SettingsFile=%~dp0server-settings.json"
set "AdminListFile=%~dp0server-adminlist.json"
set "SavesDir=%APPDATA%\Factorio\saves"
set "MenuChoice="

:: Build Launch Arguments
set "LaunchArgs="
if exist "%SettingsFile%" set "LaunchArgs=--server-settings "%SettingsFile%""
if exist "%AdminListFile%" set "LaunchArgs=%LaunchArgs% --server-adminlist "%AdminListFile%""

:: Ensure Factorio executable exists
if not exist "%FactorioExe%" (
    echo [WARN] Factorio executable not found at "%FactorioExe%".
    echo Please run the PowerShell script first or use the Install option to download it.
    pause
)

:: Ensure server-settings.json exists, create it if necessary
if not exist "%SettingsFile%" (
    if exist "%ExampleSettings%" (
        echo Creating server-settings.json from server-settings.example.json...
        copy "%ExampleSettings%" "%SettingsFile%" >nul
        echo server-settings.json created successfully.
    ) else (
        echo [WARN] server-settings.example.json not found. Settings file not created.
    )
)

:: Ensure Saves directory exists
if not exist "%SavesDir%" (
    echo Creating Saves directory...
    mkdir "%SavesDir%"
    echo Saves directory created successfully.
)

:: Main Menu
:MainMenu
cls
echo =====================================================
echo       Factorio Dedicated Server Manager (Batch)
echo =====================================================
echo [1] Load Latest Save
echo [2] Load Specific Save (Manual)
echo [3] Open server-settings.json for Editing
echo [4] Create New Save ^& Launch Server
echo [5] Exit
echo =====================================================
set /p "MenuChoice=Please enter your choice (1-5): "

if "%MenuChoice%"=="1" goto :LoadLatestSave
if "%MenuChoice%"=="2" goto :LoadSpecificSave
if "%MenuChoice%"=="3" goto :EditSettings
if "%MenuChoice%"=="4" goto :CreateSave
if "%MenuChoice%"=="5" goto :ExitScript

:: Invalid input handling
echo Invalid option! Please select a valid option.
pause
goto :MainMenu

:LoadLatestSave
cls
echo =====================================================
echo Loading the latest save file...
echo =====================================================
for /f "delims=" %%a in ('dir "%SavesDir%\*.zip" /b /o-d /tw 2^>nul') do (
    set "LatestSave=%%a"
    goto :LaunchLatest
)
echo ERROR: No save files found in %SavesDir%.
pause
goto :MainMenu

:LaunchLatest
echo Launching with %LatestSave%
"%FactorioExe%" --start-server "%SavesDir%\%LatestSave%" %LaunchArgs%
pause
goto :MainMenu

:LoadSpecificSave
cls
echo =====================================================
echo Enter the EXACT name of the save file (including .zip)
echo =====================================================
dir "%SavesDir%\*.zip" /b
echo.
set /p "SaveChoice=Save file name: "
if exist "%SavesDir%\%SaveChoice%" (
    "%FactorioExe%" --start-server "%SavesDir%\%SaveChoice%" %LaunchArgs%
) else (
    echo ERROR: Save file not found.
)
pause
goto :MainMenu

:EditSettings
cls
if exist "%SettingsFile%" (
    notepad "%SettingsFile%"
) else (
    echo ERROR: Settings file not found.
    pause
)
goto :MainMenu

:CreateSave
cls
echo =====================================================
echo Create a new save
echo =====================================================
set /p "NewSaveName=Enter name for new save (without .zip): "
if "%NewSaveName%"=="" goto :MainMenu

set "NewSavePath=%SavesDir%\%NewSaveName%.zip"
"%FactorioExe%" --create "%NewSavePath%"
if exist "%NewSavePath%" (
    echo Starting server with new save...
    "%FactorioExe%" --start-server "%NewSavePath%" %LaunchArgs%
) else (
    echo ERROR: Failed to create save.
)
pause
goto :MainMenu

:ExitScript
goto :EOF
