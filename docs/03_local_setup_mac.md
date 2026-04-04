# Local Setup -- macOS

**Time:** ~10 minutes | **Difficulty:** Easy

---

## Prerequisites

- macOS 11 (Big Sur) or newer
- Internet connection
- Azure credentials from [01_azure_portal_setup.md](01_azure_portal_setup.md)

---

## Step 1: Install Python 3.11

Open **Terminal** (`Cmd + Space`, type "Terminal", press Enter):

```bash
python3 --version
```

If you see `Python 3.10.x` through `3.13.x`, skip to Step 2.

Otherwise, install Python 3.11 with Homebrew:

```bash
# Install Homebrew (if you don't have it)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon Macs: add Homebrew to PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc

# Install Python
brew install python@3.11
```

Verify:
```bash
python3 --version
```

> If you have Python 3.14+, install 3.11 side-by-side (Homebrew keeps both). The setup script will automatically pick the best version.

---

## Step 2: Install Git

```bash
git --version
```

If macOS asks to install Command Line Tools, click **Install** and wait. Otherwise you already have Git.

---

## Step 3: Clone and Run Setup

```bash
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
chmod +x setup.sh
./setup.sh
```

The script automatically:
- Finds the best Python version (prefers 3.11)
- Creates and activates a virtual environment
- Installs all packages with `--prefer-binary` (no compiling from source)
- Creates your `.env` file

You should see all `[OK]` messages. The `[FAIL]` messages about Azure keys are normal -- you add those next.

---

## Step 4: Add Azure Credentials

Open `.env` and paste your keys from [01_azure_portal_setup.md](01_azure_portal_setup.md):

```bash
open -e .env      # TextEdit
# or: code .env   # VS Code
# or: nano .env   # Terminal editor
```

Replace all placeholder values. Save the file.

---

## Step 5: Verify and Start

```bash
source .venv/bin/activate
python scripts/check_env.py
jupyter notebook
```

All services should show `[PASS]`. Jupyter opens in your browser. Open notebooks in order starting from `00_connection_test.ipynb`.

---

## Returning After a Break

```bash
cd ai900-azure-foundry
source .venv/bin/activate
jupyter notebook
```

---

## Common Issues

| Problem | Fix |
|---------|-----|
| `python3: command not found` | `brew install python@3.11` |
| `Permission denied` on setup.sh | `chmod +x setup.sh` then `./setup.sh` |
| `Failed building wheel for Pillow` | Pull latest: `git pull` and re-run `./setup.sh` (now uses `--prefer-binary`) |
| `externally-managed-environment` | Always use the venv: `source .venv/bin/activate` first |
| Speech SDK import fails | `brew install openssl@1.1` -- the notebook has a REST fallback anyway |
| `brew: command not found` | Install Homebrew first (see Step 1) |
| Apple Silicon (M1/M2/M3/M4) issue | `arch -x86_64 pip install <package>` for problematic packages |

For more issues see [troubleshooting.md](troubleshooting.md).
