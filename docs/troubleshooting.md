# Troubleshooting Guide

A complete guide to every issue students commonly run into. Organized by category with exact symptoms and fixes.

---

## Table of Contents

- [Python Issues](#python-issues)
- [Git Issues](#git-issues)
- [Setup Script Issues](#setup-script-issues)
- [Dependency / pip Issues](#dependency--pip-issues)
- [.env & Credential Issues](#env--credential-issues)
- [Azure API Errors](#azure-api-errors)
- [Jupyter Issues](#jupyter-issues)
- [Network / Firewall Issues](#network--firewall-issues)
- [macOS-Specific Issues](#macos-specific-issues)
- [Still Stuck?](#still-stuck)

---

## Python Issues

### Issue: `'python' is not recognized` (Windows)

**Symptom:** Running `python` or `python --version` gives an error.

**Fixes (try in order):**
1. **Close and reopen your terminal** — PATH changes need a new terminal window
2. **Try `py --version` instead** — Windows sometimes uses `py` as the command
3. **Reinstall Python from the Microsoft Store** — this automatically adds it to PATH
4. **If you installed from python.org:** Reinstall and check **"Add Python to PATH"** at the bottom of the installer

### Issue: `python3` command not found (Windows)

**Symptom:** `python3 --version` doesn't work on Windows.

**Fix:** On Windows, the command is `python` (not `python3`). Use `setup.bat` (not `setup.sh`).

### Issue: Python version is too old (3.9 or older)

**Symptom:** `setup.bat` says "Python 3.8 or higher is required" or Azure packages fail to install.

**Fix:**
1. Check your version: `python --version`
2. Install Python 3.11:
   - **Windows:** Microsoft Store → search "Python 3.11" → Install
   - **macOS:** `brew install python@3.11`
3. If you have multiple versions, see the setup guides for how to select the right one

### Issue: Python 3.14+ doesn't work with Azure SDKs

**Symptom:** `pip install` fails with errors like `No matching distribution found` or C compilation errors.

**Why:** Azure SDKs take time to support brand-new Python versions. Python 3.14 may not have compatible binary wheels yet.

**Fix — Install Python 3.11 side-by-side:**

**Windows:**
1. Download Python 3.11 from [python.org/downloads](https://www.python.org/downloads/release/python-3119/)
2. Install it (uncheck "Add to PATH" to avoid conflicts)
3. Use the `py` launcher to create the venv:
   ```powershell
   py -3.11 -m venv .venv
   .\.venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   ```

**macOS:**
```bash
brew install python@3.11
python3.11 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

**Don't want multiple versions?** See the full uninstall/install instructions in:
- [Windows setup guide](02_local_setup_windows.md#step-2-handle-wrong-python-version)
- [macOS setup guide](03_local_setup_mac.md#step-2-handle-wrong-python-version)

### Issue: Multiple Python versions causing confusion

**Symptom:** You installed 3.11 but commands still use an older/newer version.

**Check what you have:**

Windows:
```powershell
py --list
```

macOS:
```bash
which -a python3
ls /opt/homebrew/bin/python3*
```

**Fix:** Always use the virtual environment. Once `.venv` is created with the right Python, it locks in that version:
```
# Check what the venv uses
.venv\Scripts\python --version    # Windows
.venv/bin/python --version        # macOS
```

---

## Git Issues

### Issue: `'git' is not recognized`

**Fix:**
- **Windows:** Download from [git-scm.com/download/win](https://git-scm.com/download/win), install with defaults, reopen terminal
- **macOS:** Run `git --version` — macOS will prompt to install Command Line Tools. Click "Install"

### Issue: `git clone` fails with SSH errors

**Fix:** Use the HTTPS URL instead:
```
git clone https://github.com/EricKart/ai900-azure-foundry.git
```

---

## Setup Script Issues

### Issue: `'setup.bat' is not recognized` (PowerShell)

**Fix:** PowerShell requires `.\` prefix for local scripts:
```powershell
.\setup.bat
```

### Issue: `setup.bat` crashes with "was unexpected at this time"

**Fix:** This was a known bug that has been fixed. Pull the latest version:
```
git pull
.\setup.bat
```

### Issue: `Permission denied` when running `setup.sh` (macOS/Linux)

**Fix:**
```bash
chmod +x setup.sh
./setup.sh
```

### Issue: `setup.bat` or `setup.sh` can't create the virtual environment

**Possible causes and fixes:**
1. **Antivirus blocking:** Temporarily disable your antivirus, run setup, re-enable
2. **No disk space:** Free up at least 2 GB
3. **Python installed without venv:** Install the `python3-venv` package (Linux) or reinstall Python (Windows/macOS)

---

## Dependency / pip Issues

### Issue: `pip install` fails with permission errors

**Symptom:** `Permission denied` during `pip install -r requirements.txt`

**Fix:** Make sure you activated the virtual environment FIRST:
```
# Windows
.\.venv\Scripts\Activate.ps1

# macOS/Linux
source .venv/bin/activate
```

Your prompt should show `(.venv)` at the beginning. **Never use `sudo pip install`.**

### Issue: `No module named 'dotenv'` (or any other module)

**Symptom:** Running a notebook gives `ModuleNotFoundError`

**Fixes:**
1. Make sure you ran the setup script
2. Make sure the virtual environment is activated
3. Check that Jupyter is using the right kernel:
   - In Jupyter, go to **Kernel → Change Kernel** → select the `.venv` kernel
4. Re-install manually:
   ```
   pip install -r requirements.txt
   ```

### Issue: `error: externally-managed-environment` (macOS)

**Fix:** This is a macOS safety feature. Always install inside a virtual environment:
```bash
source .venv/bin/activate    # Activate first!
pip install -r requirements.txt
```

### Issue: Package compilation errors during install

**Symptom:** Errors mentioning `gcc`, `cl.exe`, or `Microsoft Visual C++`

**Fix:**
1. First, try Python 3.11 — it has the most pre-built binary wheels
2. **Windows:** Install [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
3. **macOS:** Run `xcode-select --install`

---

## .env & Credential Issues

### Issue: `.env` file not being loaded

**Symptom:** Variables show as empty even though `.env` has values

**Fixes:**
1. The `.env` file must be in the **project root** (same folder as `README.md`), NOT in `notebooks/`
2. No quotes around values:
   - ✅ Correct: `AZURE_AI_KEY=abc123`
   - ❌ Wrong: `AZURE_AI_KEY="abc123"`
3. No spaces around `=`:
   - ✅ Correct: `AZURE_AI_KEY=abc123`
   - ❌ Wrong: `AZURE_AI_KEY = abc123`
4. No trailing spaces after the key value
5. **Restart the Jupyter kernel** after changing `.env` (Kernel → Restart)

### Issue: `.env` file doesn't exist

**Fix:** Copy the template:
```
# Windows
copy .env.example .env

# macOS/Linux
cp .env.example .env
```

Then fill in your Azure keys.

### Issue: Not sure where to find Azure keys

**Fix:** Follow [01_azure_portal_setup.md](01_azure_portal_setup.md) — it has exact click-by-click instructions for:
- **Azure AI Services keys** → Azure Portal → your resource → "Keys and Endpoint"
- **Azure OpenAI keys** → Azure Portal → your OpenAI resource → "Keys and Endpoint"
- **Deployment name** → Azure AI Foundry portal → Deployments

---

## Azure API Errors

### Issue: 401 Unauthorized / Access denied

**Fixes:**
1. Check `.env` — make sure keys are pasted correctly with no extra spaces or characters
2. Check the endpoint URL starts with `https://` and ends with `/`
3. Re-copy the key from Azure Portal → your resource → "Keys and Endpoint" → KEY 1
4. Make sure you're using the **right key for the right service:**
   - Azure AI Services key → `AZURE_AI_KEY`, `AZURE_SPEECH_KEY`, `AZURE_DOC_INTEL_KEY`
   - Azure OpenAI key → `AZURE_OPENAI_KEY` (different resource!)
5. **Restart Jupyter kernel** after changing `.env`

### Issue: 404 Resource not found

**Fixes:**
1. **For Azure OpenAI:** Make sure you deployed a model named `gpt-4o-mini` in [Azure AI Foundry](https://ai.azure.com)
2. **Check deployment name** in `.env`: `AZURE_OPENAI_DEPLOYMENT=gpt-4o-mini`
3. **Check the endpoint URL** matches YOUR resource (not someone else's example)

### Issue: 429 Too Many Requests / Rate limit

**Fix:** Wait 60 seconds and re-run the cell. The free tier has rate limits. If it persists, wait a few minutes between notebook runs.

### Issue: Azure OpenAI resource can't be created

**Fixes:**
1. [Request access](https://aka.ms/oai/access) if you see "not registered" (may take 1-2 business days)
2. Most **Azure for Students** accounts have access by default
3. Try a different region: `East US`, `Sweden Central`, `West US 2`

### Issue: Azure AI Services returns "Resource not found" or "InvalidResourceType"

**Fix:** Make sure you created an **Azure AI services multi-service account** (not just a single-service resource like "Computer Vision"). The multi-service resource gives access to Vision, Language, Content Safety, Speech, and Document Intelligence with one key.

---

## Jupyter Issues

### Issue: `jupyter notebook` won't start

**Fixes:**
1. Make sure the virtual environment is activated (you should see `(.venv)` in your prompt)
2. Try reinstalling: `pip install --force-reinstall jupyter notebook`
3. Try: `python -m jupyter notebook` instead

### Issue: Kernel keeps dying / "Kernel Restarting" errors

**Fixes:**
1. Check disk space (need at least 1 GB free)
2. Check RAM usage — close other apps
3. Make sure you're using the `.venv` kernel, not the system Python
4. In Codespaces: Click "Restart" and try again — first run sometimes takes a moment

### Issue: "Select Kernel" or "No kernel found"

**Fix:**
1. In VS Code: Click **"Select Kernel"** → **"Python Environments"** → pick the `.venv` one
2. In Jupyter browser: **Kernel → Change Kernel** → select `.venv`
3. If `.venv` doesn't appear, install the kernel:
   ```
   pip install ipykernel
   python -m ipykernel install --user --name=ai900-lab
   ```

### Issue: Notebook cells output is too long / scrolling

**Fix:** In Jupyter, right-click on the output → **"Enable Scrolling for Outputs"**

---

## Network / Firewall Issues

### Issue: Timeouts or connection refused when calling Azure

**Fixes (try in order):**
1. **Test your internet:** Can you open [portal.azure.com](https://portal.azure.com) in your browser?
2. **Try GitHub Codespaces** — it bypasses local network restrictions: [04_codespaces_setup.md](04_codespaces_setup.md)
3. **Disconnect VPN** if you're on one
4. **Try a different network** (e.g., mobile hotspot) to test if it's a firewall
5. **Ask IT to allowlist** these domains:
   - `*.cognitiveservices.azure.com`
   - `*.openai.azure.com`
   - `*.api.cognitive.microsoft.com`
   - `*.tts.speech.microsoft.com`
   - `*.stt.speech.microsoft.com`

### Issue: SSL certificate errors

**Symptom:** `SSL: CERTIFICATE_VERIFY_FAILED` or similar

**Fixes:**
1. **macOS:** Run `Install Certificates.command` from your Python install:
   ```bash
   /Applications/Python\ 3.11/Install\ Certificates.command
   ```
2. **Corporate network:** Your IT may be inspecting SSL traffic. Use Codespaces instead.
3. Update certifi: `pip install --upgrade certifi`

---

## macOS-Specific Issues

### Issue: Azure Speech SDK fails to import

**Symptom:** `import azure.cognitiveservices.speech` fails

**Fixes:**
1. Install the required system library:
   ```bash
   brew install openssl@1.1
   ```
2. The Speech notebook uses the **REST API as a fallback** — it should still work
3. **All other notebooks are unaffected** by this issue

### Issue: Apple Silicon (M1/M2/M3/M4) compatibility

Most packages work natively. If one fails:
```bash
# Force x86 mode for a specific package
arch -x86_64 pip install azure-cognitiveservices-speech
```

### Issue: `brew` command not found

Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

For Apple Silicon, also run:
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

---

## Still Stuck?

1. **Run the diagnostics:**
   ```
   python scripts/check_env.py
   ```
   This tells you exactly which services are configured and which are missing.

2. **Run the connection test notebook:** `notebooks/00_connection_test.ipynb` — it tests each service individually.

3. **Try Codespaces:** If local setup isn't working, [GitHub Codespaces](04_codespaces_setup.md) gives you a pre-configured environment in 2 minutes. Zero installation needed.

4. **Re-read the Azure guide:** [01_azure_portal_setup.md](01_azure_portal_setup.md) — double check you didn't miss a step.

5. **Ask your instructor** with the specific error message you're seeing. A screenshot of the error helps a lot!
