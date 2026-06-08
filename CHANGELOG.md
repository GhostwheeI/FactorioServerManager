# Changelog

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
- Server configuration files (`server-settings.json` and `server-adminlist.json`) have been moved to the root directory, and are dynamically included as arguments when launching the server.

### Requirements

- Windows 10 or Windows 11.
- PowerShell 5.1 or newer.
- Internet access for first-run setup and downloads.
