@echo off
REM ==========================================================================
REM  AI-900 Azure AI Foundry - Windows Setup Script
REM ==========================================================================
REM  This script will:
REM    1. Check that Python 3.8+ is installed
REM    2. Create a virtual environment
REM    3. Install all dependencies
REM    4. Create your .env file from the template
REM    5. Show next steps
REM ==========================================================================

echo.
echo ============================================================
echo   AI-900 Azure AI Foundry - Setup
echo ============================================================
echo.

REM -- Check Python is available ----------------------------------------
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Python is not installed or not in your PATH.
    echo.
    echo  How to fix:
    echo    1. Open the Microsoft Store and search for "Python 3.11"
    echo    2. Click "Get" to install it
    echo    3. Close and re-open this terminal
    echo    4. Run this script again
    echo.
    echo  Or download from: https://www.python.org/downloads/
    echo  IMPORTANT: Check "Add Python to PATH" during installation!
    echo.
    pause
    exit /b 1
)

REM -- Check Python version >= 3.8 --------------------------------------
python -c "import sys; exit(0 if sys.version_info >= (3, 8) else 1)" 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Python 3.8 or higher is required.
    echo.
    echo  Your current version:
    python --version
    echo.
    echo  Please install Python 3.11 from the Microsoft Store or
    echo  https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

echo [OK] Python found:
python --version
echo.

REM -- Create virtual environment ----------------------------------------
REM Check if venv exists AND is valid (has activate.bat)
if exist ".venv" (
    if not exist ".venv\Scripts\activate.bat" (
        echo [WARN] Virtual environment is incomplete or corrupted. Recreating...
        rmdir /s /q .venv 2>nul
        if exist ".venv" (
            echo [ERROR] Could not delete the broken .venv folder.
            echo         A program (likely VS Code) is locking the files inside it.
            echo.
            echo  Fix: In VS Code, press Ctrl+Shift+P and run:
            echo       "Python: Select Interpreter"
            echo       Choose the global Python (not the .venv one^)
            echo       Then close this terminal and run setup.bat again.
            echo.
            echo  Or: Open a standalone terminal (outside VS Code^) and run:
            echo       rmdir /s /q .venv
            echo       setup.bat
            echo.
            pause
            exit /b 1
        )
    )
)
if not exist ".venv" (
    echo Creating virtual environment...
    python -m venv .venv
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create virtual environment.
        echo  Try: python -m pip install --upgrade pip virtualenv
        pause
        exit /b 1
    )
    echo [OK] Virtual environment created.
) else (
    echo [OK] Virtual environment already exists.
)
echo.

REM -- Activate virtual environment --------------------------------------
echo Activating virtual environment...
call .venv\Scripts\activate.bat
echo [OK] Virtual environment activated.
echo.

REM -- Upgrade pip -------------------------------------------------------
echo Upgrading pip...
python -m pip install --upgrade pip --quiet
echo [OK] pip upgraded.
echo.

REM -- Install dependencies ----------------------------------------------
echo Installing dependencies (this may take 2-3 minutes)...
pip install -r requirements.txt --quiet
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Failed to install some dependencies.
    echo  Try running: pip install -r requirements.txt
    echo  to see the full error message.
    pause
    exit /b 1
)
echo [OK] All dependencies installed.
echo.

REM -- Create .env from template -----------------------------------------
if not exist ".env" (
    copy .env.example .env >nul
    echo [OK] Created .env file from template.
    echo      IMPORTANT: Open .env and paste your Azure keys!
) else (
    echo [OK] .env file already exists.
)
echo.

REM -- Run environment check ---------------------------------------------
echo Running environment check...
echo.
python scripts\check_env.py
echo.

REM -- Print next steps --------------------------------------------------
echo ============================================================
echo   Setup Complete! Next Steps:
echo ============================================================
echo.
echo   1. Open the .env file and paste your Azure credentials
echo      (see docs\01_azure_portal_setup.md for guidance)
echo.
echo   2. Start Jupyter Notebook:
echo      .venv\Scripts\activate.bat
echo      jupyter notebook
echo.
echo   3. Open notebooks in order: 00, 01, 02, ...
echo      Click "Run All" in each notebook.
echo.
echo ============================================================
echo.
pause
