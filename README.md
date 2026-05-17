<div align="center">
  <h1>⚙️ Factorio Server Manager</h1>
  <p><em>A lightweight, elegant PowerShell-based GUI script to manage your Factorio Dedicated Server on Windows.</em></p>

  [![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-blue?logo=windows)](#)
  [![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue?logo=powershell)](#)
  [![Factorio](https://img.shields.io/badge/Factorio-Dedicated%20Server-orange?logo=factorio)](#)
</div>

---

## 📖 Table of Contents
- [✨ Features](#-features)
- [🚀 Quick Start](#-quick-start)
- [🛠️ Usage \& Options](#️-usage--options)
- [📦 Requirements](#-requirements)
- [🦇 Alternative: Batch Script](#-alternative-batch-script)

---

## ✨ Features

- 📥 **Auto-install/update:** Effortlessly downloads and extracts the latest Factorio server binary.
- 💾 **Save File Management:** Launch your server using the latest save file, or manually pick one via a GUI window.
- ⚙️ **Easy Configuration:** Edit `server-settings.json` directly with Notepad through the manager.
- 🪶 **Zero Dependencies:** Requires nothing more than PowerShell and internet access!

---

## 🚀 Quick Start

1. **Clone or Download** this repository to your preferred location.
2. **Open PowerShell** in the directory.
3. **Run the script:**

   ```powershell
   ./FactorioServerManager.ps1
   ```

> **Note on First Run:**
> The script will automatically download and extract the latest Factorio server to `./Factorio/`. It will also create a config directory and generate default settings if they are missing.

---

## 🛠️ Usage & Options

Upon launching the script, you will be presented with a menu:

1. **Load latest save:** Automatically loads the most recent save file from `%APPDATA%\Factorio\saves`.
2. **Pick a save via GUI:** Opens a window to manually select the save file you want to load.
3. **Edit server settings JSON:** Opens your server settings in Notepad for quick modifications.
4. **Launch empty server:** Starts the server without loading any existing save files.
5. **Exit:** Closes the manager.

---

## 📦 Requirements

To run this manager smoothly, ensure your system meets the following criteria:

- 🪟 **OS:** Windows 10 or Windows 11
- 💻 **Shell:** PowerShell 5.1 or newer
- 🌐 **Network:** Internet access (required for the first-time setup and downloads)

---

## 🦇 Alternative: Batch Script

If you prefer using a standard Windows Batch script instead of PowerShell, an alternative is provided!

Simply run:
```cmd
example_batch.bat
```
This script offers similar functionality, including save file management and settings configuration, tailored for a batch environment.

---

<div align="center">
  <p>Built with ❤️ for Factorio server admins.</p>
  <p>GitHub: <a href="https://github.com/GhostwheeI/FactorioServerManager">GhostwheeI/FactorioServerManager</a></p>
</div>
