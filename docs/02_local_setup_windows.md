# Local Setup - Windows

Step-by-step guide to set up the AI-900 lab on Windows.

**Time required:** ~10 minutes

---

## Step 1: Install Python

You need **Python 3.8 or newer**. We recommend Python 3.11.

### Option A: Microsoft Store (Easiest)
1. Open the **Microsoft Store** app
2. Search for **"Python 3.11"**
3. Click **"Get"** / **"Install"**
4. Done! Python is automatically added to PATH

### Option B: Python.org
1. Go to [https://www.python.org/downloads/](https://www.python.org/downloads/)
2. Download the latest Python 3.11.x installer
3. **IMPORTANT:** During installation, check the box that says **"Add Python to PATH"**
4. Click "Install Now"

### Verify Python is installed
Open **Command Prompt** or **PowerShell** and run:
```
python --version
```
You should see something like `Python 3.11.x`.

> **Troubleshooting:** If you see `'python' is not recognized`, try closing and reopening your terminal. If it still doesn't work, see [troubleshooting.md](troubleshooting.md).

---

## Step 2: Install Git (if needed)

If you don't have Git installed:
1. Go to [https://git-scm.com/download/win](https://git-scm.com/download/win)
2. Download and run the installer
3. Use all default settings

---

## Step 3: Clone the Repository

Open **Command Prompt** or **PowerShell** and run:

```
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
```

---

## Step 4: Run the Setup Script

```
setup.bat
```

This will:
- Verify Python is installed correctly
- Create a virtual environment (`.venv`)
- Install all required packages
- Create your `.env` file

If you see `[OK]` for each step, you're good!

---

## Step 5: Add Your Azure Credentials

1. Open the `.env` file in any text editor (Notepad, VS Code, etc.)
2. Paste your Azure keys from the [Azure Portal Setup Guide](01_azure_portal_setup.md)
3. Save the file

---

## Step 6: Start Jupyter Notebook

```
.venv\Scripts\activate
jupyter notebook
```

This will:
1. Activate the virtual environment
2. Start Jupyter and open it in your browser

---

## Step 7: Run the Notebooks

1. In Jupyter (your browser), click on `notebooks/`
2. Open `00_connection_test.ipynb`
3. Click **"Run All"** (in the Cell menu) or press **Shift+Enter** on each cell
4. If all checks pass, proceed to `01_responsible_ai.ipynb`

---

## Returning After a Break

Each time you open a new terminal session:
```
cd ai900-azure-foundry
.venv\Scripts\activate
jupyter notebook
```

---

## Need Help?

See [troubleshooting.md](troubleshooting.md) for common issues and fixes.
