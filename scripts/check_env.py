"""
AI-900 Azure AI Foundry - Environment Checker
===============================================
Validates that all required Azure credentials are set in the .env file.
Run this script before starting the notebooks to catch configuration issues early.

Usage:
    python scripts/check_env.py
"""

import os
import sys

# Handle running from repo root or from scripts/ directory
for dotenv_path in [".env", "../.env"]:
    if os.path.exists(dotenv_path):
        # Minimal .env parser (no external dependency needed for this script)
        with open(dotenv_path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#") and "=" in line:
                    key, _, value = line.partition("=")
                    key = key.strip()
                    value = value.strip()
                    if value and not value.startswith("https://YOUR"):
                        os.environ.setdefault(key, value)
        break

# ---------------------------------------------------------------------------
# Define required environment variables grouped by service
# ---------------------------------------------------------------------------
SERVICES = {
    "Azure AI Services (Vision, Language, Content Safety)": {
        "vars": ["AZURE_AI_ENDPOINT", "AZURE_AI_KEY"],
        "notebooks": ["01_responsible_ai", "02_computer_vision", "03_natural_language"],
    },
    "Azure OpenAI (Generative AI)": {
        "vars": ["AZURE_OPENAI_ENDPOINT", "AZURE_OPENAI_KEY", "AZURE_OPENAI_DEPLOYMENT"],
        "notebooks": ["05_generative_ai"],
    },
    "Azure AI Speech": {
        "vars": ["AZURE_SPEECH_KEY", "AZURE_SPEECH_REGION"],
        "notebooks": ["04_speech_ai"],
    },
    "Azure Document Intelligence": {
        "vars": ["AZURE_DOC_INTEL_ENDPOINT", "AZURE_DOC_INTEL_KEY"],
        "notebooks": ["06_document_intelligence"],
    },
}

# ---------------------------------------------------------------------------
# ANSI colours (works in most modern terminals and Jupyter)
# ---------------------------------------------------------------------------
GREEN = "\033[92m"
RED = "\033[91m"
YELLOW = "\033[93m"
BOLD = "\033[1m"
RESET = "\033[0m"


def check_var(name):
    """Return True if the environment variable is set and non-empty."""
    val = os.environ.get(name, "").strip()
    return bool(val) and not val.startswith("https://YOUR")


def main():
    print(f"\n{BOLD}{'='*60}")
    print("  AI-900 Azure AI Foundry - Environment Check")
    print(f"{'='*60}{RESET}\n")

    all_ok = True
    any_service_ok = False

    for service_name, info in SERVICES.items():
        vars_list = info["vars"]
        notebooks = info["notebooks"]
        missing = [v for v in vars_list if not check_var(v)]

        if not missing:
            status = f"{GREEN}[PASS]{RESET}"
            any_service_ok = True
        else:
            status = f"{RED}[FAIL]{RESET}"
            all_ok = False

        print(f"  {status} {BOLD}{service_name}{RESET}")
        print(f"         Notebooks: {', '.join(notebooks)}")

        if missing:
            for var in missing:
                print(f"         {RED}Missing: {var}{RESET}")
            print(f"         {YELLOW}Fix: Open .env and set the value for the variable(s) above.{RESET}")
            print(f"         {YELLOW}See: docs/01_azure_portal_setup.md for where to find these values.{RESET}")
        print()

    # ---------------------------------------------------------------------------
    # Summary
    # ---------------------------------------------------------------------------
    print(f"{BOLD}{'='*60}{RESET}")
    if all_ok:
        print(f"  {GREEN}{BOLD}All services configured! You're ready to run the notebooks.{RESET}")
    elif any_service_ok:
        print(f"  {YELLOW}{BOLD}Some services are configured. You can run notebooks for those services.{RESET}")
        print(f"  {YELLOW}Set the missing variables in .env to unlock the remaining notebooks.{RESET}")
    else:
        print(f"  {RED}{BOLD}No services configured yet.{RESET}")
        print(f"  {RED}1. Open the .env file in this project's root folder.{RESET}")
        print(f"  {RED}2. Paste your Azure keys and endpoints from the Azure Portal.{RESET}")
        print(f"  {RED}3. Follow: docs/01_azure_portal_setup.md for step-by-step instructions.{RESET}")
    print(f"{BOLD}{'='*60}{RESET}\n")

    return 0 if all_ok else 1


if __name__ == "__main__":
    sys.exit(main())
