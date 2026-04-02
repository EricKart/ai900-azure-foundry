# Local Setup - macOS

Step-by-step guide to set up the AI-900 lab on macOS.

**Time required:** ~10 minutes

---

## Step 1: Install Python

You need **Python 3.8 or newer**. We recommend Python 3.11.

### Option A: Homebrew (Recommended)
If you have Homebrew installed:
```bash
brew install python@3.11
```

If you don't have Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install python@3.11
```

### Option B: Python.org
1. Go to [https://www.python.org/downloads/](https://www.python.org/downloads/)
2. Download the macOS installer for Python 3.11.x
3. Run the installer

### Verify Python is installed
Open **Terminal** and run:
```bash
python3 --version
```
You should see something like `Python 3.11.x`.

---

## Step 2: Install Git (if needed)

macOS usually comes with Git. Check by running:
```bash
git --version
```

If it's not installed, macOS will prompt you to install the Command Line Tools. Click "Install".

---

## Step 3: Clone the Repository

Open **Terminal** and run:

```bash
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
```

---

## Step 4: Run the Setup Script

```bash
chmod +x setup.sh
./setup.sh
```

This will:
- Verify Python is installed correctly
- Create a virtual environment (`.venv`)
- Install all required packages
- Create your `.env` file

If you see `[OK]` for each step, you're good!

### Note on Azure Speech SDK (macOS)

The Speech SDK on macOS may need additional system libraries. If you see errors related to the Speech SDK, run:
```bash
brew install openssl@1.1
```

If the Speech notebook (04) doesn't work, all other notebooks will still function fine.

---

## Step 5: Add Your Azure Credentials

1. Open the `.env` file:
   ```bash
   open -e .env
   ```
   Or use any text editor (VS Code, TextEdit, nano, etc.)
2. Paste your Azure keys from the [Azure Portal Setup Guide](01_azure_portal_setup.md)
3. Save the file

---

## Step 6: Start Jupyter Notebook

```bash
source .venv/bin/activate
jupyter notebook
```

This will start Jupyter and open it in your default browser.

---

## Step 7: Run the Notebooks

1. In Jupyter (your browser), click on `notebooks/`
2. Open `00_connection_test.ipynb`
3. Click **"Run All"** (in the Cell menu) or press **Shift+Enter** on each cell
4. If all checks pass, proceed to `01_responsible_ai.ipynb`

---

## Returning After a Break

Each time you open a new terminal session:
```bash
cd ai900-azure-foundry
source .venv/bin/activate
jupyter notebook
```

---

## Need Help?

See [troubleshooting.md](troubleshooting.md) for common issues and fixes.
