# Local Setup — macOS (Complete End-to-End Guide)

This guide takes you from **zero to running notebooks** on macOS. Every step has checks so you know you're on the right track.

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
10. [macOS-Specific Notes](#macos-specific-notes)
11. [Returning After a Break](#returning-after-a-break)
12. [Quick Reference Card](#quick-reference-card)

---

## Pre-Flight Checklist

Before you begin, make sure you have:

| Requirement | How to Check | Status |
|-------------|-------------|--------|
| macOS 11 (Big Sur) or newer | Apple menu → About This Mac | Required |
| Internet connection | Open any website | Required |
| Azure credentials | Completed [01_azure_portal_setup.md](01_azure_portal_setup.md) | Required |
| ~2 GB free disk space | Apple menu → About This Mac → Storage | Required |

> **Haven't set up Azure yet?** Stop here and complete [01_azure_portal_setup.md](01_azure_portal_setup.md) first.

---

## Step 1: Check & Install Python

### 1a. Check if Python is already installed

Open **Terminal** (press `Cmd + Space`, type "Terminal", press Enter) and run:

```bash
python3 --version
```

> **Important:** On macOS, always use `python3`, not `python`.

**What you might see:**

| Output | What It Means | Next Step |
|--------|--------------|-----------|
| `Python 3.10.x` | Good version, works | Skip to [Step 3](#step-3-check--install-git) |
| `Python 3.11.x` | Recommended version | Skip to [Step 3](#step-3-check--install-git) |
| `Python 3.12.x` | Good version, works | Skip to [Step 3](#step-3-check--install-git) |
| `Python 3.13.x` | Works, fully tested | Skip to [Step 3](#step-3-check--install-git) |
| `Python 3.14.x` or newer | **Too new — may not work** | Go to [Step 2](#step-2-handle-wrong-python-version) |
| `Python 3.9.x` or older | **Too old** | Install 3.11 below |
| `command not found` | Python not installed | Install below |
| Prompts to install Xcode tools | Python not installed | Click "Install", then try again |

### Supported Python Versions

| Version | Status | Notes |
|---------|--------|-------|
| 3.10 | ✅ Supported | Works fine |
| 3.11 | ✅ Recommended | Best compatibility with all Azure SDKs |
| 3.12 | ✅ Supported | Works fine |
| 3.13 | ✅ Supported | Tested and working |
| 3.14+ | ⚠️ May not work | Azure SDKs may not support it yet |
| 3.9 or older | ❌ Not supported | Missing required features |

### 1b. Install Python 3.11 (If Needed)

**Option A — Homebrew (Recommended):**

If you already have Homebrew:
```bash
brew install python@3.11
```

If you don't have Homebrew yet:
```bash
# Install Homebrew first (paste this entire line)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then install Python
brew install python@3.11
```

After installation, verify:
```bash
python3 --version
```

If it still shows an old version, try:
```bash
# Check where Homebrew installed it
brew info python@3.11

# You may need to add it to your PATH
echo 'export PATH="/opt/homebrew/opt/python@3.11/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
python3 --version
```

**Option B — python.org installer:**

1. Go to [https://www.python.org/downloads/](https://www.python.org/downloads/)
2. Click **"Download Python 3.11.x"** (scroll down if 3.14 shows at the top)
3. Open the `.pkg` file and follow the installer
4. Verify: `python3 --version`

---

## Step 2: Handle Wrong Python Version

### If You Have Python 3.14+ (Too New)

**Option A — Install 3.11 side-by-side with Homebrew (safe):**

```bash
brew install python@3.11
```

Check both versions exist:
```bash
python3 --version          # Your default (might be 3.14)
python3.11 --version       # The one we installed
```

When creating the virtual environment in Step 5, use:
```bash
python3.11 -m venv .venv
```

**Option B — Make 3.11 the default:**

```bash
brew unlink python@3.14
brew link python@3.11 --force
python3 --version  # Should now show 3.11.x
```

### If You Have Python 3.9 or Older

```bash
# Install 3.11 (doesn't remove the old one)
brew install python@3.11

# Use python3.11 explicitly
python3.11 --version
```

### Check All Python Versions Installed

```bash
# See all Python versions on your system
ls /opt/homebrew/bin/python3*    # Apple Silicon Mac
ls /usr/local/bin/python3*       # Intel Mac
which -a python3                  # All python3 locations
```

---

## Step 3: Check & Install Git

### 3a. Check if Git is installed

```bash
git --version
```

macOS usually comes with Git. If you see a version number → skip to [Step 4](#step-4-clone-the-repository).

### 3b. Install Git (if missing)

If macOS prompts you to install **Command Line Developer Tools**, click **"Install"** and wait.

Or install via Homebrew:
```bash
brew install git
```

Verify: `git --version`

---

## Step 4: Clone the Repository

```bash
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
```

**Verify:** You should see the project files:
```bash
ls
```

Expected output includes: `README.md`, `requirements.txt`, `setup.sh`, `notebooks/`, `docs/`

---

## Step 5: Run the Setup Script

```bash
chmod +x setup.sh
./setup.sh
```

### What This Script Does

| Step | What It Does | Expected Output |
|------|-------------|----------------|
| 1 | Checks Python is available | `[OK] Python found: Python 3.11.x` |
| 2 | Creates virtual environment `.venv/` | `[OK] Virtual environment created` |
| 3 | Installs all pip packages (~90 packages) | `[OK] All dependencies installed` |
| 4 | Creates `.env` from template | `[OK] Created .env file from template` |

### If the Script Fails

| Error | Cause | Fix |
|-------|-------|-----|
| `Permission denied` | Script not executable | Run `chmod +x setup.sh` first |
| `python3: command not found` | Python not installed | Follow [Step 1](#step-1-check--install-python) |
| `Failed to install dependencies` | Wrong Python version or no internet | Try `python3.11 -m venv .venv` |
| `error: externally-managed-environment` | Newer macOS Python restriction | That's why we use a virtual environment — the setup script handles this |

### Manual Setup (If setup.sh Doesn't Work)

```bash
# 1. Create virtual environment (use python3.11 if you have multiple versions)
python3 -m venv .venv

# 2. Activate it (your prompt should show (.venv) after this)
source .venv/bin/activate

# 3. Upgrade pip
python -m pip install --upgrade pip

# 4. Install dependencies
pip install -r requirements.txt

# 5. Create .env file
cp .env.example .env
```

### Verify Dependencies are Installed

```bash
source .venv/bin/activate
pip list | grep -iE "azure|openai|jupyter|dotenv"
```

You should see these packages:

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

---

## Step 6: Add Azure Credentials

> **Prerequisite:** You must have completed [01_azure_portal_setup.md](01_azure_portal_setup.md) first.

1. Open the `.env` file:
   ```bash
   open -e .env          # Opens in TextEdit
   # or
   code .env             # Opens in VS Code (if installed)
   # or
   nano .env             # Opens in terminal editor
   ```

2. Replace the placeholder values with your real keys (see [01_azure_portal_setup.md](01_azure_portal_setup.md) for where to find them)

3. **Save the file** (`Cmd+S`)

### Common .env Mistakes

| Mistake | Example | Fix |
|---------|---------|-----|
| Extra spaces around `=` | `AZURE_AI_KEY = abc123` | `AZURE_AI_KEY=abc123` |
| Quotes around values | `AZURE_AI_KEY="abc123"` | `AZURE_AI_KEY=abc123` |
| Left placeholder text | `https://YOUR-RESOURCE...` | Replace with your actual URL |

---

## Step 7: Verify Everything Works

```bash
source .venv/bin/activate
python scripts/check_env.py
```

- **`[PASS]`** = Service is configured correctly
- **`[FAIL]`** = Missing or invalid key — check your `.env` file

You need at least one `[PASS]` to start. Ideally all four should pass.

---

## Step 8: Start Jupyter & Run Notebooks

```bash
source .venv/bin/activate
jupyter notebook
```

This opens Jupyter in your browser at `http://localhost:8888`.

### Run Notebooks in This Order

| Order | Notebook | Must-run? | Purpose |
|:-----:|----------|:---------:|---------|
| 1st | `00_connection_test.ipynb` | **Yes** | Confirms Azure keys work |
| 2nd | `01_responsible_ai.ipynb` | Yes | AI ethics + Content Safety API |
| 3rd | `02_computer_vision.ipynb` | Yes | Image analysis, OCR |
| 4th | `03_natural_language.ipynb` | Yes | Sentiment, NER, translation |
| 5th | `04_speech_ai.ipynb` | Optional | Text-to-Speech, Speech-to-Text |
| 6th | `05_generative_ai.ipynb` | Yes | GPT chat, prompt engineering |
| 7th | `06_document_intelligence.ipynb` | Yes | Document parsing |

---

## macOS-Specific Notes

### Azure Speech SDK on macOS

The Speech notebook (`04_speech_ai.ipynb`) uses the Azure Speech SDK, which may need extra setup on macOS:

```bash
brew install openssl@1.1
```

If the Speech SDK still doesn't load, the notebook has a **REST API fallback** — you'll still be able to hear generated audio. All other notebooks are unaffected.

### Apple Silicon (M1/M2/M3/M4) Macs

Most packages work natively on Apple Silicon. If you hit issues:

```bash
# Force Rosetta for a specific install
arch -x86_64 pip install azure-cognitiveservices-speech
```

### "externally-managed-environment" Error

If you see this error when running `pip install` outside a virtual environment:
```
error: externally-managed-environment
```

This is a macOS safety feature. **Always** use the virtual environment:
```bash
source .venv/bin/activate    # Activate first!
pip install -r requirements.txt
```

---

## Returning After a Break

```bash
cd ai900-azure-foundry
source .venv/bin/activate
jupyter notebook
```

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────┐
│ AI-900 Lab — macOS Quick Reference                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  First time setup:                                      │
│    git clone https://github.com/EricKart/               │
│      ai900-azure-foundry.git                            │
│    cd ai900-azure-foundry                               │
│    chmod +x setup.sh && ./setup.sh                      │
│    # Edit .env with your Azure keys                     │
│    source .venv/bin/activate                             │
│    jupyter notebook                                     │
│                                                         │
│  Returning:                                             │
│    cd ai900-azure-foundry                               │
│    source .venv/bin/activate                             │
│    jupyter notebook                                     │
│                                                         │
│  Check environment:                                     │
│    python scripts/check_env.py                          │
│                                                         │
│  Python versions: 3.10–3.13 ✅  |  3.14+ ⚠️           │
│  Recommended: Python 3.11                               │
│  Command: python3 (not python)                          │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## Need More Help?

- **Environment issues:** [troubleshooting.md](troubleshooting.md)
- **Azure setup:** [01_azure_portal_setup.md](01_azure_portal_setup.md)
- **Use Codespaces instead:** [04_codespaces_setup.md](04_codespaces_setup.md) (zero install, runs in browser)

Each time you open a new terminal session:
```bash
cd ai900-azure-foundry
source .venv/bin/activate
jupyter notebook
```

---

## Need Help?

See [troubleshooting.md](troubleshooting.md) for common issues and fixes.
