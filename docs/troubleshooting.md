# Troubleshooting Guide

Quick fixes for every common issue. Ctrl+F to search for your error message.

---

## Python Version Issues

### `python` / `python3` not recognized

| OS | Fix |
|----|-----|
| Windows | Install from Microsoft Store: search "Python 3.11", click Get. Reopen terminal. |
| macOS | `brew install python@3.11` |
| Linux | `sudo apt install python3.11` |

### Python 3.14+ (too new)

Azure SDKs may not have binary wheels for the latest Python. Install 3.11 side-by-side:

| OS | Fix |
|----|-----|
| Windows | Install Python 3.11 from Microsoft Store (keeps both versions) |
| macOS | `brew install python@3.11` |
| Linux | `sudo apt install python3.11 python3.11-venv` |

The setup scripts automatically pick the best installed version (3.10-3.13).

### Python 3.9 or older

Uninstall the old version and install 3.11 using the instructions above.

---

## Setup Script Issues

### `.\setup.bat` says "was unexpected at this time"

You have an older version of the script. Fix:
```powershell
git pull
.\setup.bat
```

### `Permission denied` on `setup.sh`

```bash
chmod +x setup.sh
./setup.sh
```

### setup.bat cannot delete `.venv` (files locked)

VS Code locks Python files inside `.venv`. Fix:

1. Close VS Code completely
2. Open a plain Command Prompt (Win+R, type `cmd`, Enter)
3. Run:
   ```cmd
   cd C:\path\to\ai900-azure-foundry
   rmdir /s /q .venv
   setup.bat
   ```

### Long path error during pip install (Windows)

Jupyter creates deeply nested files. Fix (run as Administrator):
```powershell
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
```
Then delete `.venv` and re-run `setup.bat`. The latest `setup.bat` tries to enable this automatically.

### `externally-managed-environment` (macOS/Linux)

This is a safety feature. Always install inside the virtual environment:
```bash
source .venv/bin/activate
pip install -r requirements.txt
```

---

## Dependency / pip Issues

### `Failed building wheel for Pillow` (macOS)

pip is trying to compile Pillow from source. The latest `setup.sh` uses `--prefer-binary` to prevent this.

```bash
git pull
rm -rf .venv
./setup.sh
```

If that does not work, install build tools:
```bash
xcode-select --install
```

### Package compilation errors (`gcc`, `cl.exe`, `Visual C++`)

1. Use Python 3.11 (best binary wheel support)
2. Windows: Install [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
3. macOS: `xcode-select --install`
4. Linux: `sudo apt install build-essential python3-dev`

### `No module named 'dotenv'` (or any module)

The virtual environment is not activated, or Jupyter is using the wrong kernel.

1. Activate the venv first:
   - Windows: `.venv\Scripts\activate.bat`
   - macOS/Linux: `source .venv/bin/activate`
2. Re-install: `pip install -r requirements.txt`
3. In Jupyter: Kernel > Change Kernel > select the `.venv` kernel

---

## Activation Issues

### PowerShell: `activate.bat is not recognized`

Use the correct syntax:
```powershell
.venv\Scripts\activate.bat
```
Do NOT add `.\` in front for `.bat` files in PowerShell.

OR use the PowerShell-native version:
```powershell
.\.venv\Scripts\Activate.ps1
```

### PowerShell: execution policy error on `Activate.ps1`

Run once:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```
The latest `setup.bat` sets this automatically.

### How do I know the venv is active?

Your terminal prompt should show `(.venv)` at the beginning:
```
(.venv) PS C:\...\ai900-azure-foundry>
```

---

## .env and Credential Issues

### `.env` file not being loaded

1. File must be in the **project root** (same folder as `README.md`)
2. No quotes around values: `AZURE_AI_KEY=abc123` (not `"abc123"`)
3. No spaces around `=`: `AZURE_AI_KEY=abc123` (not `AZURE_AI_KEY = abc123`)
4. No trailing spaces after the value
5. **Restart the Jupyter kernel** after editing `.env`

### `.env` file does not exist

```bash
# Windows
copy .env.example .env

# macOS/Linux
cp .env.example .env
```

### Where to find Azure keys

Follow [01_azure_portal_setup.md](01_azure_portal_setup.md). Keys are in Azure Portal > your resource > "Keys and Endpoint".

---

## Azure API Errors

### 401 Unauthorized

1. Re-copy the key from Azure Portal (Keys and Endpoint > KEY 1)
2. Check endpoint URL starts with `https://` and ends with `/`
3. Make sure the right key goes with the right service (OpenAI key is separate from AI Services key)
4. Restart Jupyter kernel after editing `.env`

### 404 Resource Not Found

1. For OpenAI: deploy a model named `gpt-4o-mini` in [Azure AI Foundry](https://ai.azure.com)
2. Check `AZURE_OPENAI_DEPLOYMENT=gpt-4o-mini` in `.env`
3. Check endpoint URL matches YOUR resource name

### 429 Too Many Requests

Wait 60 seconds and re-run the cell. Free tier has rate limits.

---

## Jupyter Issues

### `jupyter notebook` won't start

1. Make sure venv is activated (you see `(.venv)` in prompt)
2. Try: `python -m jupyter notebook`
3. Reinstall: `pip install --force-reinstall jupyter notebook`

### "Select Kernel" or wrong kernel

In VS Code: Select Kernel > Python Environments > pick the `.venv` one.

In Jupyter browser: Kernel > Change Kernel > select `.venv`.

If `.venv` does not appear:
```bash
pip install ipykernel
python -m ipykernel install --user --name=ai900-lab
```

### Kernel keeps dying

Close other apps (RAM), check disk space (need 1GB free), make sure you are using the `.venv` kernel.

---

## macOS-Specific Issues

### Azure Speech SDK fails to import

```bash
brew install openssl@1.1
```
The Speech notebook has a REST API fallback -- it still works without the SDK.

### Apple Silicon (M1/M2/M3/M4)

Most packages work natively. If one fails:
```bash
arch -x86_64 pip install <package-name>
```

### `brew` command not found

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

---

## Linux-Specific Issues

### `No module named venv`

```bash
sudo apt install python3.11-venv
# or for your Python version:
sudo apt install python3-venv
```

### Build errors during pip install

```bash
sudo apt install build-essential python3-dev
```

---

## Network / Firewall Issues

### Connection timeouts to Azure

1. Can you open [portal.azure.com](https://portal.azure.com) in your browser?
2. Disconnect VPN if on one
3. Try a different network (mobile hotspot)
4. Use [GitHub Codespaces](04_codespaces_setup.md) to bypass local network restrictions

### SSL certificate errors

- macOS: `/Applications/Python\ 3.11/Install\ Certificates.command`
- All: `pip install --upgrade certifi`
- Corporate networks: Use Codespaces

---

## Nuclear Option: Start Fresh

If nothing is working, delete everything and start from scratch:

**Windows:**
```powershell
cd ..
Remove-Item -Recurse -Force ai900-azure-foundry
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
.\setup.bat
```

**macOS / Linux:**
```bash
cd ..
rm -rf ai900-azure-foundry
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
chmod +x setup.sh
./setup.sh
```

---

## Still Stuck?

1. Run `python scripts/check_env.py` and share the output
2. Try [GitHub Codespaces](04_codespaces_setup.md) -- zero install, runs in browser, works in 2 minutes
3. Ask your instructor with a screenshot of the error
