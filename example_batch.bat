@echo off
:: Factorio Dedicated Server Manager Batch Script
:: By: Ghostwheel
:: Last Updated: Space Age Release
:: Version 1.0
:: -----------------------------------------------
:: This script validates, manages, and runs a Factorio Dedicated Server
:: with support for save files, server settings, and elevated privileges.

:: Variables
set "BaseDir=%~dp0"
set "FactorioExe=%~dp0steamapps\common\Factorio\bin\x64\factorio.exe"
set "ExampleSettings=%~dp0steamapps\common\Factorio\data\server-settings.example.json"
set "SettingsFile=%~dp0steamapps\common\Factorio\data\server-settings.json"
set "SavesDir=%APPDATA%\Factorio\saves"
set "MenuChoice="

:: Ensure Factorio executable exists
if not exist "%FactorioExe%" (
    echo ERROR: Factorio executable not found at "%FactorioExe%".
    echo Please ensure Factorio is installed in the expected location.
    pause
    goto :ExitScript
)

:: Ensure server-settings.json exists, create it if necessary
if not exist "%SettingsFile%" (
    if exist "%ExampleSettings%" (
        echo Creating server-settings.json from server-settings.example.json...
        copy "%ExampleSettings%" "%SettingsFile%" >nul
        echo server-settings.json created successfully.
    ) else (
        echo ERROR: server-settings.example.json not found at "%ExampleSettings%".
        echo Cannot create server-settings.json. Please verify the installation.
        pause
        goto :ExitScript
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
echo Factorio Dedicated Server Manager
echo =====================================================
echo [1] Load Latest Save
echo [2] Load Specific Save
echo [3] Open server-settings.json for Editing
echo [4] Install Factorio Dedicated Server
echo [5] Exit Factorio Dedicated Server Manager
echo =====================================================
set /p "MenuChoice=Please enter your choice (1-5): "

if "%MenuChoice%"=="1" goto :LoadLatestSave
if "%MenuChoice%"=="2" goto :LoadSpecificSave
if "%MenuChoice%"=="3" goto :EditSettings
if "%MenuChoice%"=="4" goto :Install
if "%MenuChoice%"=="5" goto :ExitScript

:: Invalid input handling
echo Invalid option! Please select a valid option.
pause
goto :MainMenu

:: Load the latest save
:LoadLatestSave
cls
echo =====================================================
echo Loading the latest save file...
echo ================================
