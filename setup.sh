#!/usr/bin/env bash
# ==========================================================================
#  AI-900 Azure AI Foundry - macOS / Linux Setup Script
# ==========================================================================
#  This script will:
#    1. Check that Python 3.8+ is installed
#    2. Create a virtual environment
#    3. Install all dependencies
#    4. Create your .env file from the template
#    5. Show next steps
# ==========================================================================

set -e

echo ""
echo "============================================================"
echo "  AI-900 Azure AI Foundry - Setup"
echo "============================================================"
echo ""

# -- Check Python is available -------------------------------------------
PYTHON_CMD=""
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo "[ERROR] Python is not installed."
    echo ""
    echo "  How to fix (macOS):"
    echo "    brew install python@3.11"
    echo ""
    echo "  How to fix (Ubuntu/Debian):"
    echo "    sudo apt update && sudo apt install python3 python3-venv python3-pip"
    echo ""
    echo "  Or download from: https://www.python.org/downloads/"
    echo ""
    exit 1
fi

# -- Check Python version >= 3.8 ----------------------------------------
$PYTHON_CMD -c "import sys; exit(0 if sys.version_info >= (3, 8) else 1)" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "[ERROR] Python 3.8 or higher is required."
    echo ""
    echo "  Your current version:"
    $PYTHON_CMD --version
    echo ""
    echo "  Please install Python 3.11:"
    echo "    macOS:  brew install python@3.11"
    echo "    Linux:  sudo apt install python3.11"
    echo ""
    exit 1
fi

echo "[OK] Python found: $($PYTHON_CMD --version)"
echo ""

# -- Create virtual environment ------------------------------------------
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment (.venv)..."
    $PYTHON_CMD -m venv .venv
    echo "[OK] Virtual environment created."
else
    echo "[OK] Virtual environment already exists."
fi
echo ""

# -- Activate virtual environment ----------------------------------------
echo "Activating virtual environment..."
source .venv/bin/activate
echo "[OK] Virtual environment activated."
echo ""

# -- Upgrade pip ---------------------------------------------------------
echo "Upgrading pip..."
python -m pip install --upgrade pip --quiet
echo "[OK] pip upgraded."
echo ""

# -- Install dependencies ------------------------------------------------
echo "Installing dependencies (this may take 2-3 minutes)..."
pip install -r requirements.txt --quiet
echo "[OK] All dependencies installed."
echo ""

# -- Create .env from template -------------------------------------------
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "[OK] Created .env file from template."
    echo "     IMPORTANT: Open .env and paste your Azure keys!"
else
    echo "[OK] .env file already exists."
fi
echo ""

# -- Run environment check -----------------------------------------------
echo "Running environment check..."
echo ""
python scripts/check_env.py
echo ""

# -- Print next steps ----------------------------------------------------
echo "============================================================"
echo "  Setup Complete! Next Steps:"
echo "============================================================"
echo ""
echo "  1. Open the .env file and paste your Azure credentials"
echo "     (see docs/01_azure_portal_setup.md for guidance)"
echo ""
echo "  2. Start Jupyter Notebook:"
echo "     source .venv/bin/activate"
echo "     jupyter notebook"
echo ""
echo "  3. Open notebooks in order: 00, 01, 02, ..."
echo "     Click 'Run All' in each notebook."
echo ""
echo "============================================================"
echo ""
