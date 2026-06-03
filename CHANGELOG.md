# Changelog

## v1.1.0 - 2026-06-03

### Changed
- Shifted configuration files (`server-settings.json` and `server-adminlist.json`) to the root of the repository to prevent them from being lost if the Factorio directory is updated or deleted.

### Added
- Added support for `server-adminlist.json`.
- Added a new main menu option to easily edit the admin list through the GUI.
- Added dynamic launch arguments so configuration files are only passed to the server if they exist.

## v1.0.0 - 2026-05-17

Initial formal release of Factorio Server Manager.

### Included

- PowerShell-based GUI manager for Windows Factorio dedicated servers.
- Automatic Factorio dedicated server download and update flow.
- Save file loading from the latest available save.
- Manual save file selection through a GUI picker.
- New save creation and launch support.
- Server settings editing through Notepad.
- Force update option for re-downloading the Factorio server executable.
- Alternative batch script for users who prefer CMD/batch workflows.
- README hero image and cleaned project presentation.

### Requirements

- Windows 10 or Windows 11.
- PowerShell 5.1 or newer.
- Internet access for first-run setup and downloads.
