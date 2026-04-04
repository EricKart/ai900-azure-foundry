# Local Setup -- Linux

**Time:** ~10 minutes | **Difficulty:** Easy

---

## Prerequisites

- Ubuntu 20.04+, Debian 11+, Fedora 36+, or similar
- Internet connection
- Azure credentials from [01_azure_portal_setup.md](01_azure_portal_setup.md)

---

## Step 1: Install Python 3.11

```bash
python3 --version
```

If you see `Python 3.10.x` through `3.13.x`, skip to Step 2.

Otherwise install Python and required packages:

**Ubuntu / Debian:**
```bash
sudo apt update
sudo apt install python3.11 python3.11-venv python3-pip git -y
```

**Fedora:**
```bash
sudo dnf install python3.11 git -y
```

**Arch:**
```bash
sudo pacman -S python git
```

Verify:
```bash
python3.11 --version
# or: python3 --version
```

---

## Step 2: Clone and Run Setup

```bash
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
chmod +x setup.sh
./setup.sh
```

The script automatically finds the best Python version, creates a virtual environment, and installs everything.

You should see all `[OK]` messages. The `[FAIL]` messages about Azure keys are normal -- you add those next.

---

## Step 3: Add Azure Credentials

Open `.env` and paste your keys from [01_azure_portal_setup.md](01_azure_portal_setup.md):

```bash
nano .env
# or: code .env   # VS Code
```

Replace all placeholder values. Save the file.

---

## Step 4: Verify and Start

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
| `python3: command not found` | `sudo apt install python3.11` |
| `No module named venv` | `sudo apt install python3.11-venv` |
| `Permission denied` on setup.sh | `chmod +x setup.sh` |
| `externally-managed-environment` | Always use venv: `source .venv/bin/activate` first |
| Build errors during pip install | `sudo apt install build-essential python3-dev` |

For more issues see [troubleshooting.md](troubleshooting.md).
