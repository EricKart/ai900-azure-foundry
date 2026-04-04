#!/usr/bin/env bash
# ==========================================================================
#  AI-900 Azure AI Foundry - macOS / Linux Setup Script
# ==========================================================================
#  Safe to re-run. Handles: broken venv, missing system packages,
#  Pillow build failures, Apple Silicon, and all common student issues.
# ==========================================================================

set -e

echo ""
echo "============================================================"
echo "  AI-900 Azure AI Foundry - Setup (macOS / Linux)"
echo "============================================================"
echo ""

# -- Detect OS -----------------------------------------------------------
OS_TYPE="linux"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
fi

# -- Check Python is available -------------------------------------------
PYTHON_CMD=""
for cmd in python3.11 python3.12 python3.13 python3.10 python3 python; do
    if command -v "$cmd" &> /dev/null; then
        # Check version is 3.10-3.13
        if $cmd -c "import sys; exit(0 if (3,10) <= sys.version_info < (3,14) else 1)" 2>/dev/null; then
            PYTHON_CMD="$cmd"
            break
        fi
    fi
done

if [ -z "$PYTHON_CMD" ]; then
    echo "[ERROR] Python 3.10 to 3.13 is required but not found."
    echo ""
    if [ "$OS_TYPE" = "macos" ]; then
        echo "  Install Python 3.11:"
        echo "    brew install python@3.11"
        echo ""
        echo "  Don't have Homebrew? Install it first:"
        echo "    /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    else
        echo "  Install Python 3.11:"
        echo "    Ubuntu/Debian:  sudo apt update && sudo apt install python3.11 python3.11-venv python3-pip"
        echo "    Fedora:         sudo dnf install python3.11"
        echo "    Arch:           sudo pacman -S python"
    fi
    echo ""
    echo "  Or download from: https://www.python.org/downloads/"
    echo ""
    exit 1
fi

echo "[OK] Python found: $($PYTHON_CMD --version 2>&1)"
echo ""

# -- Check venv module is available --------------------------------------
if ! $PYTHON_CMD -c "import venv" 2>/dev/null; then
    echo "[ERROR] Python venv module is not installed."
    echo ""
    if [ "$OS_TYPE" = "macos" ]; then
        echo "  Fix: brew install python@3.11"
    else
        echo "  Fix: sudo apt install python3-venv"
    fi
    echo ""
    exit 1
fi

# -- Handle virtual environment ------------------------------------------
if [ -d ".venv" ] && [ ! -f ".venv/bin/activate" ]; then
    echo "[WARN] Virtual environment is broken. Removing..."
    rm -rf .venv
fi

if [ ! -d ".venv" ]; then
    echo "Creating virtual environment (.venv)..."
    $PYTHON_CMD -m venv .venv
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to create virtual environment."
        if [ "$OS_TYPE" != "macos" ]; then
            echo "  Try: sudo apt install python3-venv"
        fi
        exit 1
    fi
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

# --prefer-binary: use pre-built wheels, avoids compiling Pillow from source.
pip install -r requirements.txt --quiet --prefer-binary
if [ $? -ne 0 ]; then
    echo ""
    echo "[WARN] First attempt had issues. Retrying..."
    echo ""
    pip install -r requirements.txt --prefer-binary
    if [ $? -ne 0 ]; then
        echo ""
        echo "[ERROR] Failed to install dependencies."
        echo ""
        if [ "$OS_TYPE" = "macos" ]; then
            echo "  Try these fixes:"
            echo "    1. Install Xcode tools: xcode-select --install"
            echo "    2. Delete venv and retry: rm -rf .venv && ./setup.sh"
            echo "    3. Use Python 3.11: brew install python@3.11"
        else
            echo "  Try these fixes:"
            echo "    1. sudo apt install build-essential python3-dev"
            echo "    2. Delete venv and retry: rm -rf .venv && ./setup.sh"
        fi
        echo ""
        exit 1
    fi
fi
echo "[OK] All dependencies installed."
echo ""

# -- Create .env from template -------------------------------------------
if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo "[OK] Created .env file from template."
        echo "     IMPORTANT: Open .env and paste your Azure keys!"
    else
        echo "[WARN] No .env.example found. Create .env manually."
    fi
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
echo "  1. Open .env and paste your Azure credentials"
echo "     (see docs/01_azure_portal_setup.md)"
echo ""
echo "  2. Start Jupyter:"
echo "     source .venv/bin/activate"
echo "     jupyter notebook"
echo ""
echo "  3. Open notebooks in order: 00, 01, 02, ..."
echo "     Click 'Run All' in each notebook."
echo ""
echo "============================================================"
echo ""
