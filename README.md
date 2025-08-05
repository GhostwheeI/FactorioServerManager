# Factorio Server Manager (PowerShell Edition)

A lightweight PowerShell-based GUI script to manage your Factorio Dedicated Server on Windows.

## Features

- Auto-install/update of the Factorio server binary
- Launch with latest or specific save file
- Edit `server-settings.json` with Notepad
- No dependencies besides PowerShell and internet access

## Usage

```powershell
./FactorioServerManager.ps1
```

On first run:
- Downloads and extracts the latest Factorio server to `./Factorio/`
- Creates config directory and default settings if missing

## Options

1. Load latest save file (from `%APPDATA%\Factorio\saves`)
2. Pick a save via GUI
3. Edit server settings JSON
4. Launch empty server
5. Exit

## Requirements

- Windows 10/11
- PowerShell 5.1+
- Internet access for first-time setup

---

GitHub: [GhostwheeI/FactorioServerManager](https://github.com/GhostwheeI/FactorioServerManager)