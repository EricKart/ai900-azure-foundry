# Local Setup -- Windows

**Time:** ~10 minutes | **Difficulty:** Easy

---

## Prerequisites

- Windows 10 or 11
- Internet connection
- Azure credentials from [01_azure_portal_setup.md](01_azure_portal_setup.md)

---

## Step 1: Install Python 3.11

> Already have Python 3.10-3.13? Skip to Step 2.

1. Open **Microsoft Store** (press Win key, type "Store")
2. Search **"Python 3.11"**
3. Click **Get** / **Install**
4. Wait for it to finish
5. **Close and reopen your terminal**

Verify:
```powershell
python --version
```
You should see `Python 3.11.x`. If you see `Python 3.14+` or nothing, see [Troubleshooting](troubleshooting.md#python-version-issues).

---

## Step 2: Install Git

```powershell
git --version
```

If it shows a version, skip to Step 3. Otherwise:

1. Download from [git-scm.com/download/win](https://git-scm.com/download/win)
2. Run installer with **all default settings** (just click Next)
3. **Close and reopen your terminal**

---

## Step 3: Clone and Run Setup

Open **PowerShell** or **Command Prompt** and run:

```powershell
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
.\setup.bat
```

The script automatically:
- Sets PowerShell execution policy (so `.ps1` scripts work)
- Enables long file paths (prevents Jupyter install errors)
- Creates and activates a virtual environment
- Installs all Python packages
- Creates your `.env` file

You should see all `[OK]` messages. The `[FAIL]` messages about Azure keys are normal at this point -- you will add those next.

---

## Step 4: Add Azure Credentials

Open `.env` in any editor and paste your Azure keys from [01_azure_portal_setup.md](01_azure_portal_setup.md):

```powershell
notepad .env
```

Replace all `YOUR-RESOURCE-NAME` and `paste-your-key-here` values. Save the file.

---

## Step 5: Verify and Start

```powershell
.venv\Scripts\activate.bat
python scripts\check_env.py
jupyter notebook
```

All services should show `[PASS]`. Jupyter opens in your browser. Open notebooks in order starting from `00_connection_test.ipynb`.

---

## Returning After a Break

Every time you come back:

```powershell
cd ai900-azure-foundry
.venv\Scripts\activate.bat
jupyter notebook
```

---

## Common Issues

| Problem | Fix |
|---------|-----|
| `python` not recognized | Install from Microsoft Store, reopen terminal |
| `.\setup.bat` not recognized | You are in PowerShell -- the `.\` prefix is correct. Make sure you are in the right folder |
| `was unexpected at this time` | Pull latest: `git pull` then `.\setup.bat` |
| Long path error during install | Run as Admin: `reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f` |
| Cannot delete `.venv` | Close VS Code, open plain Command Prompt, run `rmdir /s /q .venv` then `setup.bat` |
| Execution policy error | The setup script handles this automatically. If it persists: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` |

For more issues see [troubleshooting.md](troubleshooting.md).
