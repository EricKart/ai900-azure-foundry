# Troubleshooting Guide

Common issues students encounter and how to fix them.

---

## Issue 1: "python is not recognized" (Windows)

**Symptom:** Running `python` or `python --version` gives an error.

**Fixes:**
1. **Close and reopen your terminal** - PATH changes need a new terminal window
2. **Reinstall Python from the Microsoft Store** - this automatically adds Python to PATH
3. **If you installed from python.org:** Reinstall and make sure to check **"Add Python to PATH"**
4. **Try `py` instead of `python`** - Windows sometimes uses `py` as the command:
   ```
   py --version
   py -m venv .venv
   ```

---

## Issue 2: "python3 is not recognized" (Windows)

**Symptom:** The setup script fails because `python3` doesn't work on Windows.

**Fix:** On Windows, the command is `python`, not `python3`. Use `setup.bat` (not `setup.sh`).

---

## Issue 3: Python version is too old

**Symptom:** `setup.bat` says "Python 3.8 or higher is required"

**Fix:**
1. Check your version: `python --version`
2. Install Python 3.11 from the Microsoft Store or [python.org](https://www.python.org/downloads/)
3. If you have multiple Python versions, make sure 3.11 is first in your PATH

---

## Issue 4: "pip install" fails with permission errors

**Symptom:** `pip install -r requirements.txt` fails with "Permission denied"

**Fixes:**
1. **Make sure you activated the virtual environment first:**
   - Windows: `.venv\Scripts\activate`
   - macOS: `source .venv/bin/activate`
2. Your prompt should show `(.venv)` at the beginning when the venv is active
3. **Never use `sudo pip install`** - always use a virtual environment

---

## Issue 5: "No module named 'dotenv'" or similar import errors

**Symptom:** Running a notebook gives `ModuleNotFoundError`

**Fixes:**
1. Make sure you ran the setup script (`setup.bat` or `setup.sh`)
2. Check that the Jupyter kernel is using the virtual environment:
   - In Jupyter, go to Kernel → Change Kernel → select the `.venv` kernel
3. Re-install manually:
   ```
   .venv\Scripts\activate  (or source .venv/bin/activate on Mac)
   pip install -r requirements.txt
   ```

---

## Issue 6: 401 Unauthorized errors from Azure

**Symptom:** Notebooks give `401 Unauthorized` or `Access denied` errors

**Fixes:**
1. **Check your `.env` file** - make sure keys are pasted correctly with no extra spaces
2. **Check the endpoint URL** - it should start with `https://` and end with `/`
3. **Verify in the Azure Portal:**
   - Go to your resource → "Keys and Endpoint"
   - Copy the key again (use KEY 1)
4. **Make sure you're using the right key for the right service:**
   - Azure AI Services key → `AZURE_AI_KEY`, `AZURE_SPEECH_KEY`, `AZURE_DOC_INTEL_KEY`
   - Azure OpenAI key → `AZURE_OPENAI_KEY` (this is a different resource!)
5. **After changing `.env`, restart your Jupyter kernel** (Kernel → Restart)

---

## Issue 7: "Resource not found" (404) errors

**Symptom:** API calls return 404 errors

**Fixes:**
1. **For Azure OpenAI:** Make sure you deployed a model named `gpt-4o-mini` in the Azure AI Foundry portal
2. **Check the deployment name** in `.env` matches exactly: `AZURE_OPENAI_DEPLOYMENT=gpt-4o-mini`
3. **Check the endpoint URL** matches your resource (not someone else's)

---

## Issue 8: Azure Speech SDK fails on macOS

**Symptom:** `import azure.cognitiveservices.speech` fails or Speech notebook doesn't work

**Fixes:**
1. Install the required system library:
   ```bash
   brew install openssl@1.1
   ```
2. If that doesn't work, the Speech notebook uses the **REST API** as a fallback, which doesn't need the SDK
3. **All other notebooks will work fine** even if Speech has issues

---

## Issue 9: Jupyter won't start or kernel keeps dying

**Symptom:** `jupyter notebook` fails or notebooks show "Kernel died" errors

**Fixes:**
1. **Make sure the virtual environment is activated** before running `jupyter notebook`
2. **Check you have enough disk space** (at least 1 GB free)
3. **Try reinstalling Jupyter:**
   ```
   pip install --force-reinstall jupyter notebook
   ```
4. **In Codespaces:** If the kernel dies, click "Restart" and try again. The first run sometimes takes a moment to initialize.

---

## Issue 10: Corporate/university firewall blocks Azure

**Symptom:** Timeouts, connection refused, or SSL errors when calling Azure services

**Fixes:**
1. **Try using GitHub Codespaces** - it bypasses local network restrictions
2. **Connect to a different network** (e.g., mobile hotspot) to test if it's a firewall issue
3. **If on a corporate VPN**, try disconnecting the VPN
4. **Ask your IT department** to allowlist these domains:
   - `*.cognitiveservices.azure.com`
   - `*.openai.azure.com`
   - `*.api.cognitive.microsoft.com`
   - `*.tts.speech.microsoft.com`
   - `*.stt.speech.microsoft.com`

---

## Issue 11: "Azure OpenAI is not available" or can't create the resource

**Symptom:** Can't find Azure OpenAI in the portal or get "not registered" errors

**Fixes:**
1. **Request access** at [https://aka.ms/oai/access](https://aka.ms/oai/access) (may take 1-2 business days)
2. Most **Azure for Students** accounts have access by default
3. Try a different region (e.g., `East US`, `West US 2`, `Sweden Central`)

---

## Issue 12: .env file not being loaded

**Symptom:** Variables show as empty even though `.env` has values

**Fixes:**
1. Make sure the `.env` file is in the **project root** (same folder as `README.md`), NOT in the `notebooks/` folder
2. Check that values don't have quotes around them:
   - Correct: `AZURE_AI_KEY=abc123`
   - Wrong: `AZURE_AI_KEY="abc123"`
3. Check there are no spaces around the `=`:
   - Correct: `AZURE_AI_KEY=abc123`
   - Wrong: `AZURE_AI_KEY = abc123`
4. **Restart the Jupyter kernel** after any `.env` changes

---

## Still Stuck?

1. Run the connection test notebook: `notebooks/00_connection_test.ipynb` - it will tell you exactly what's missing
2. Re-read the [Azure Portal Setup Guide](01_azure_portal_setup.md) to make sure you didn't miss a step
3. Ask your instructor for help with the specific error message you're seeing
