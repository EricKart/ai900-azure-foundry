# Local Setup — Windows (Complete End-to-End Guide)

This guide takes you from **zero to running notebooks** on Windows. Every step has checks so you know you're on the right track.

**Time required:** ~15 minutes  
**Difficulty:** Easy (no coding experience needed)

---

## Table of Contents

1. [Pre-Flight Checklist](#pre-flight-checklist)
2. [Step 1: Check & Install Python](#step-1-check--install-python)
3. [Step 2: Handle Wrong Python Version](#step-2-handle-wrong-python-version)
4. [Step 3: Check & Install Git](#step-3-check--install-git)
5. [Step 4: Clone the Repository](#step-4-clone-the-repository)
6. [Step 5: Run the Setup Script](#step-5-run-the-setup-script)
7. [Step 6: Add Azure Credentials](#step-6-add-azure-credentials)
8. [Step 7: Verify Everything Works](#step-7-verify-everything-works)
9. [Step 8: Start Jupyter & Run Notebooks](#step-8-start-jupyter--run-notebooks)
10. [Returning After a Break](#returning-after-a-break)
11. [Quick Reference Card](#quick-reference-card)

---

## Pre-Flight Checklist

Before you begin, make sure you have:

| Requirement | How to Check | Status |
|-------------|-------------|--------|
| Windows 10 or 11 | `winver` in Run dialog | Required |
| Internet connection | Open any website | Required |
| Azure credentials | Completed [01_azure_portal_setup.md](01_azure_portal_setup.md) | Required |
| ~2 GB free disk space | Check in File Explorer | Required |
| Admin access (for installs) | Can install apps from Microsoft Store | Required |

> **Haven't set up Azure yet?** Stop here and complete [01_azure_portal_setup.md](01_azure_portal_setup.md) first. You need your Azure keys before running any notebook.

---

## Step 1: Check & Install Python

### 1a. Check if Python is already installed

Open **PowerShell** (press `Win + X` → "Windows PowerShell") and run:

```powershell
python --version
```

**What you might see:**

| Output | What It Means | Next Step |
|--------|--------------|-----------|
| `Python 3.10.x` | Good version, works | Skip to [Step 3](#step-3-check--install-git) |
| `Python 3.11.x` | Recommended version | Skip to [Step 3](#step-3-check--install-git) |
| `Python 3.12.x` | Good version, works | Skip to [Step 3](#step-3-check--install-git) |
| `Python 3.13.x` | Works, fully tested | Skip to [Step 3](#step-3-check--install-git) |
| `Python 3.14.x` or newer | **Too new — may not work** | Go to [Step 2](#step-2-handle-wrong-python-version) |
| `Python 3.7.x` or older | **Too old** | Go to [Step 2](#step-2-handle-wrong-python-version) |
| `Python 2.x.x` | Way too old | Go to [Step 2](#step-2-handle-wrong-python-version) |
| `'python' is not recognized` | Python not installed | Install below |
| Opens Microsoft Store | Python not installed | Close the store, install below |

### Supported Python Versions

| Version | Status | Notes |
|---------|--------|-------|
| 3.10 | ✅ Supported | Works fine |
| 3.11 | ✅ Recommended | Best compatibility with all Azure SDKs |
| 3.12 | ✅ Supported | Works fine |
| 3.13 | ✅ Supported | Tested and working |
| 3.14+ | ⚠️ May not work | Azure SDKs may not support it yet. Use 3.11 instead |
| 3.9 or older | ❌ Not supported | Missing required features |

### 1b. Install Python 3.11 (If Needed)

**Option A — Microsoft Store (Easiest, recommended for students):**

1. Press **Win** key, type **"Microsoft Store"**, open it
2. Search for **"Python 3.11"**
3. Click **"Get"** → **"Install"**
4. Wait for installation to complete
5. **Close and reopen PowerShell**
6. Verify: `python --version` → should show `Python 3.11.x`

**Option B — python.org (More control):**

1. Go to [https://www.python.org/downloads/](https://www.python.org/downloads/)
2. Click **"Download Python 3.11.x"** (scroll down if you see 3.14 at the top — you want 3.11)
3. Run the installer
4. **⚠️ CRITICAL: Check the box "Add python.exe to PATH"** at the bottom of the first screen
5. Click **"Install Now"**
6. **Close and reopen PowerShell**
7. Verify: `python --version` → should show `Python 3.11.x`

> **Still seeing "not recognized"?** Try `py --version` instead. Windows sometimes uses `py` as the command. If that works, use `py` instead of `python` for all commands below.

---

## Step 2: Handle Wrong Python Version

### If You Have Python 3.14+ (Too New)

Some Azure SDKs don't work with the very latest Python. You need to install 3.11 alongside it.

**Option A — Install 3.11 side-by-side (safe, keeps your existing version):**

1. Download Python 3.11 from [https://www.python.org/downloads/release/python-3119/](https://www.python.org/downloads/release/python-3119/)
2. Run the installer
3. **⚠️ Uncheck "Add to PATH"** (so it doesn't conflict with your existing version)
4. Click **"Install Now"**
5. Now use the `py` launcher to pick the version:
   ```powershell
   py -3.11 --version
   ```
   Should show `Python 3.11.x`
6. When you reach Step 5, create the virtual environment with:
   ```powershell
   py -3.11 -m venv .venv
   ```

**Option B — Uninstall 3.14 and install 3.11 (clean approach):**

1. Open **Settings** → **Apps** → **Installed apps**
2. Search for **"Python 3.14"**
3. Click the **"..."** menu → **"Uninstall"**
4. Confirm and wait for removal
5. **Also remove** any "Python Launcher" entries if present
6. **Close and reopen PowerShell**
7. Verify it's gone: `python --version` → should show "not recognized"
8. Now install Python 3.11 using [Step 1b](#1b-install-python-311-if-needed) above

### If You Have Python 3.7 or Older (Too Old)

1. Uninstall the old version: **Settings** → **Apps** → search "Python" → **Uninstall**
2. Install Python 3.11 using [Step 1b](#1b-install-python-311-if-needed) above

### How to Check All Python Versions Installed

Run this to see every Python version on your machine:

```powershell
py --list
```

Example output:
```
 -V:3.14          Python 3.14 (64-bit)
 -V:3.11          Python 3.11 (64-bit)
```

You can use `py -3.11` to specifically run Python 3.11 even if 3.14 is the default.

---

## Step 3: Check & Install Git

### 3a. Check if Git is installed

```powershell
git --version
```

If you see `git version 2.x.x` → Skip to [Step 4](#step-4-clone-the-repository).

### 3b. Install Git (if missing)

1. Go to [https://git-scm.com/download/win](https://git-scm.com/download/win)
2. Download the 64-bit installer
3. Run the installer → **use all default settings** (just click "Next" through everything)
4. **Close and reopen PowerShell**
5. Verify: `git --version`

---

## Step 4: Clone the Repository

```powershell
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
```

**Verify:** You should see the project files:
```powershell
dir
```

Expected output includes: `README.md`, `requirements.txt`, `setup.bat`, `notebooks/`, `docs/`

> **Where to clone?** Your home directory, Desktop, or Documents are all fine. Just remember the location.

---

## Step 5: Run the Setup Script

**In PowerShell:**
```powershell
.\setup.bat
```

**In Command Prompt:**
```cmd
setup.bat
```

### What This Script Does

| Step | What It Does | Expected Output |
|------|-------------|----------------|
| 1 | Checks Python is available | `[OK] Python found: Python 3.11.x` |
| 2 | Checks Python version ≥ 3.8 | (no error) |
| 3 | Creates virtual environment `.venv/` | `[OK] Virtual environment created` |
| 4 | Installs all pip packages (~90 packages) | `[OK] All dependencies installed` |
| 5 | Creates `.env` from template | `[OK] Created .env file from template` |
| 6 | Runs environment check | Shows which Azure services need keys |

### If the Script Fails

| Error | Cause | Fix |
|-------|-------|-----|
| `'setup.bat' is not recognized` | PowerShell needs `.\` prefix | Run `.\setup.bat` |
| `Python is not installed` | Python not in PATH | Reinstall from Microsoft Store |
| `Python 3.8 or higher is required` | Old Python | Follow [Step 2](#step-2-handle-wrong-python-version) |
| `Failed to create virtual environment` | Antivirus blocking | Temporarily disable antivirus, retry |
| `Failed to install dependencies` | Network issue or incompatible Python | Check internet; try Python 3.11 |
| `pip` timeout errors | Slow internet | Run manually: `.venv\Scripts\activate` then `pip install -r requirements.txt` |

### Manual Setup (If setup.bat Doesn't Work)

If the script fails for any reason, run each step manually:

```powershell
# 1. Create virtual environment
python -m venv .venv

# 2. Activate it (your prompt should show (.venv) after this)
.\.venv\Scripts\Activate.ps1

# 3. Upgrade pip
python -m pip install --upgrade pip

# 4. Install dependencies
pip install -r requirements.txt

# 5. Create .env file
Copy-Item .env.example .env
```

### Verify Dependencies are Installed

After setup, check that key packages are installed:

```powershell
.\.venv\Scripts\Activate.ps1
pip list | Select-String "azure|openai|jupyter|dotenv"
```

You should see these packages (versions may vary slightly):

```
azure-ai-contentsafety         1.0.0
azure-ai-documentintelligence  1.0.0
azure-ai-textanalytics         5.3.0
azure-ai-vision-imageanalysis  1.0.0
azure-cognitiveservices-speech  1.40.0
azure-identity                 1.17.1
jupyter                        1.0.0
openai                         1.40.0
python-dotenv                  1.0.1
```

If any are missing, run: `pip install -r requirements.txt`

---

## Step 6: Add Azure Credentials

> **Prerequisite:** You must have completed [01_azure_portal_setup.md](01_azure_portal_setup.md) first.

1. Open the `.env` file in any editor:
   - **VS Code:** `code .env`
   - **Notepad:** `notepad .env`
   - Or open it from File Explorer

2. Replace the placeholder values with your real keys:

```ini
# Azure AI Services (from Step 3 of Azure Portal guide)
AZURE_AI_ENDPOINT=https://YOUR-RESOURCE-NAME.cognitiveservices.azure.com/
AZURE_AI_KEY=paste-your-key-1-here

# Azure OpenAI (from Step 4-5 of Azure Portal guide)
AZURE_OPENAI_ENDPOINT=https://YOUR-RESOURCE-NAME.openai.azure.com/
AZURE_OPENAI_KEY=paste-your-openai-key-here
AZURE_OPENAI_DEPLOYMENT=gpt-4o-mini

# Azure Speech (same key as AI Services if using multi-service)
AZURE_SPEECH_KEY=paste-your-key-1-here
AZURE_SPEECH_REGION=eastus

# Azure Document Intelligence (same key as AI Services if using multi-service)
AZURE_DOC_INTEL_ENDPOINT=https://YOUR-RESOURCE-NAME.cognitiveservices.azure.com/
AZURE_DOC_INTEL_KEY=paste-your-key-1-here
```

3. **Save the file** (`Ctrl+S`)

### Common .env Mistakes

| Mistake | Example | Fix |
|---------|---------|-----|
| Extra spaces around `=` | `AZURE_AI_KEY = abc123` | `AZURE_AI_KEY=abc123` |
| Quotes around values | `AZURE_AI_KEY="abc123"` | `AZURE_AI_KEY=abc123` |
| Trailing spaces after key | `AZURE_AI_KEY=abc123   ` | Remove trailing spaces |
| Left placeholder text | `https://YOUR-RESOURCE...` | Replace with your actual URL |
| Wrong key for wrong service | OpenAI key in AI_KEY field | Check [01_azure_portal_setup.md](01_azure_portal_setup.md) |

---

## Step 7: Verify Everything Works

Run the environment checker to validate your setup:

```powershell
.\.venv\Scripts\Activate.ps1
python scripts\check_env.py
```

### Reading the Output

- **`[PASS]`** = That service is configured correctly
- **`[FAIL]`** = Missing or invalid key — check your `.env` file

You need at least one `[PASS]` to start running notebooks. Ideally all four services should pass.

### Quick Fix Checklist

If a service shows `[FAIL]`:

1. Open `.env` and check the variable name matches exactly
2. Make sure you copied the full key (no missing characters)
3. Make sure the endpoint URL starts with `https://` and ends with `/`
4. Save the `.env` file and run `check_env.py` again

---

## Step 8: Start Jupyter & Run Notebooks

```powershell
.\.venv\Scripts\Activate.ps1
jupyter notebook
```

This opens Jupyter in your browser at `http://localhost:8888`.

### Run Notebooks in This Order

1. Click on `notebooks/` folder
2. Open and run each notebook with **Cell → Run All** (or `Shift+Enter` per cell):

| Order | Notebook | Must-run? | Purpose |
|:-----:|----------|:---------:|---------|
| 1st | `00_connection_test.ipynb` | **Yes** | Confirms Azure keys work |
| 2nd | `01_responsible_ai.ipynb` | Yes | AI ethics + Content Safety API |
| 3rd | `02_computer_vision.ipynb` | Yes | Image analysis, OCR |
| 4th | `03_natural_language.ipynb` | Yes | Sentiment, NER, translation |
| 5th | `04_speech_ai.ipynb` | Optional | Text-to-Speech, Speech-to-Text |
| 6th | `05_generative_ai.ipynb` | Yes | GPT chat, prompt engineering |
| 7th | `06_document_intelligence.ipynb` | Yes | Document parsing |

> **Tip:** If a notebook cell shows an error, the error message usually tells you exactly what's wrong. Check [troubleshooting.md](troubleshooting.md) for common fixes.

---

## Returning After a Break

Every time you open a new terminal to continue working:

```powershell
cd ai900-azure-foundry
.\.venv\Scripts\Activate.ps1
jupyter notebook
```

Your `.env` file and all notebook outputs are saved. You can pick up where you left off.

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────┐
│ AI-900 Lab — Windows Quick Reference                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  First time setup:                                      │
│    git clone https://github.com/EricKart/               │
│      ai900-azure-foundry.git                            │
│    cd ai900-azure-foundry                               │
│    .\setup.bat                                          │
│    # Edit .env with your Azure keys                     │
│    .\.venv\Scripts\Activate.ps1                         │
│    jupyter notebook                                     │
│                                                         │
│  Returning:                                             │
│    cd ai900-azure-foundry                               │
│    .\.venv\Scripts\Activate.ps1                         │
│    jupyter notebook                                     │
│                                                         │
│  Check environment:                                     │
│    python scripts\check_env.py                          │
│                                                         │
│  Reinstall packages:                                    │
│    pip install -r requirements.txt                      │
│                                                         │
│  Python versions: 3.10–3.13 ✅  |  3.14+ ⚠️           │
│  Recommended: Python 3.11                               │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## Need More Help?

- **Environment issues:** [troubleshooting.md](troubleshooting.md)
- **Azure setup:** [01_azure_portal_setup.md](01_azure_portal_setup.md)
- **Use Codespaces instead:** [04_codespaces_setup.md](04_codespaces_setup.md) (zero install, runs in browser)
