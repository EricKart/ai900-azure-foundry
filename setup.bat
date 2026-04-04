@echo off
REM ==========================================================================
REM  AI-900 Azure AI Foundry - Windows Setup Script
REM ==========================================================================
REM  Flat control flow (no nested if-blocks) for maximum batch compatibility.
REM  Safe to re-run at any time.
REM ==========================================================================

echo.
echo ============================================================
echo   AI-900 Azure AI Foundry - Setup (Windows)
echo ============================================================
echo.

REM -- Enable long paths (silent, best-effort) ---------------------------
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f >nul 2>nul

REM -- Set execution policy for PowerShell -------------------------------
powershell -NoProfile -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force" >nul 2>nul

REM -- Find Python -------------------------------------------------------
where python >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set "PYTHON_CMD=python"
    goto :python_found
)
where py >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set "PYTHON_CMD=py"
    goto :python_found
)
echo [ERROR] Python is not installed or not in your PATH.
echo.
echo   Fix: Open Microsoft Store, search "Python 3.11", click Get.
echo        Close and reopen this terminal, then run setup.bat again.
echo.
pause
exit /b 1

:python_found
REM -- Check Python version (3.10-3.13) using only batch-safe chars ------
%PYTHON_CMD% -c "import sys; v=sys.version_info; exit(0 if v[0]==3 and v[1] in [10,11,12,13] else 1)" 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Python 3.10 to 3.13 is required.
    echo.
    echo   Your current version:
    %PYTHON_CMD% --version
    echo.
    echo   Fix: Install Python 3.11 from the Microsoft Store
    echo        or https://www.python.org/downloads/release/python-3119/
    echo.
    pause
    exit /b 1
)
echo [OK] Python found:
%PYTHON_CMD% --version
echo.

REM -- Check venv state --------------------------------------------------
if exist ".venv\Scripts\activate.bat" goto :venv_ready
if exist ".venv" goto :venv_broken
goto :venv_create

:venv_broken
echo [WARN] Virtual environment is broken. Removing...
rmdir /s /q .venv 2>nul
if not exist ".venv" goto :venv_create
echo [WARN] Files locked. Attempting to free them...
taskkill /f /im python.exe >nul 2>nul
timeout /t 2 /nobreak >nul
rmdir /s /q .venv 2>nul
if not exist ".venv" goto :venv_create
echo.
echo [ERROR] Cannot delete .venv - files are locked by another program.
echo.
echo   Fix: Close VS Code completely, open a plain Command Prompt
echo        (Win+R, type "cmd", Enter) and run:
echo.
echo        cd "%CD%"
echo        rmdir /s /q .venv
echo        setup.bat
echo.
pause
exit /b 1

:venv_create
echo Creating virtual environment...
%PYTHON_CMD% -m venv .venv
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to create virtual environment.
    pause
    exit /b 1
)
echo [OK] Virtual environment created.
goto :venv_done

:venv_ready
echo [OK] Virtual environment already exists.

:venv_done
echo.

REM -- Activate ----------------------------------------------------------
echo Activating virtual environment...
call .venv\Scripts\activate.bat
echo [OK] Virtual environment activated.
echo.

REM -- Upgrade pip -------------------------------------------------------
echo Upgrading pip...
python -m pip install --upgrade pip --quiet 2>nul
echo [OK] pip upgraded.
echo.

REM -- Install dependencies ----------------------------------------------
echo Installing dependencies (this may take 2-3 minutes)...
pip install -r requirements.txt --quiet --prefer-binary
if %ERRORLEVEL% equ 0 goto :deps_ok
echo.
echo [WARN] Retrying with verbose output...
echo.
pip install -r requirements.txt --prefer-binary
if %ERRORLEVEL% equ 0 goto :deps_ok
echo.
echo [ERROR] Failed to install dependencies.
echo   1. Check your internet connection
echo   2. Delete .venv and try Python 3.11
echo.
pause
exit /b 1

:deps_ok
echo [OK] All dependencies installed.
echo.

REM -- Create .env -------------------------------------------------------
if exist ".env" goto :env_exists
if not exist ".env.example" goto :env_no_template
copy .env.example .env >nul
echo [OK] Created .env file from template.
echo      IMPORTANT: Open .env and paste your Azure keys!
goto :env_done
:env_no_template
echo [WARN] No .env.example found. Create .env manually.
goto :env_done
:env_exists
echo [OK] .env file already exists.
:env_done
echo.

REM -- Run environment check ---------------------------------------------
echo Running environment check...
echo.
python scripts\check_env.py
echo.

REM -- Done --------------------------------------------------------------
echo ============================================================
echo   Setup Complete! Next Steps:
echo ============================================================
echo.
echo   1. Open .env and paste your Azure credentials
echo      (see docs\01_azure_portal_setup.md)
echo.
echo   2. Start Jupyter:
echo      .venv\Scripts\activate.bat
echo      jupyter notebook
echo.
echo   3. Open notebooks in order: 00, 01, 02, ...
echo.
echo ============================================================
echo.
pause
