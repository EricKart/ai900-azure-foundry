# AI-900 Hands-On Lab with Azure AI Foundry

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/EricKart/ai900-azure-foundry?quickstart=1)
[![Python 3.10–3.13](https://img.shields.io/badge/python-3.10–3.13-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> **No coding required!** Clone this repo, set up your Azure credentials, and run pre-built Jupyter notebooks to explore every AI-900 exam domain hands-on.

---

## How to Use This Repo (Follow These Steps In Order)

### Step 1: Get an Azure Account

Sign up for a free **Azure for Students** account ($100 credit, no credit card):
👉 [https://azure.microsoft.com/en-us/free/students/](https://azure.microsoft.com/en-us/free/students/)

---

### Step 2: Create Azure Resources

Follow the **Azure Portal Setup Guide** to create all the required Azure services and get your keys:

👉 **[docs/01_azure_portal_setup.md](docs/01_azure_portal_setup.md)**

This guide walks you through:
- Creating a Resource Group
- Creating an Azure AI Services multi-service resource
- Creating an Azure OpenAI resource and deploying GPT-4o-mini
- Copying all your keys and endpoints

**Do NOT skip this step.** You need these keys before running any notebook.

---

### Step 3: Set Up Your Environment (Pick ONE Method)

| Method | Time | Best For | Guide |
|--------|------|----------|-------|
| **GitHub Codespaces** | ~2 min | No install needed, runs in browser | 👉 [docs/04_codespaces_setup.md](docs/04_codespaces_setup.md) |
| **Windows Local** | ~10 min | Running on your own Windows PC | 👉 [docs/02_local_setup_windows.md](docs/02_local_setup_windows.md) |
| **macOS Local** | ~10 min | Running on your own Mac | 👉 [docs/03_local_setup_mac.md](docs/03_local_setup_mac.md) |

**Using Codespaces?** Click the badge at the top of this page, add your keys to `.env`, and skip to Step 4.

**Using Local setup?** Quick summary:
```bash
# 1. Clone the repo
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry

# 2. Run the setup script
# Windows (Command Prompt):
setup.bat
# Windows (PowerShell):
.\setup.bat
# macOS/Linux:
chmod +x setup.sh && ./setup.sh

# 3. Open .env and paste your Azure keys from Step 2

# 4. Start Jupyter
# Windows:
.venv\Scripts\activate
jupyter notebook
# macOS/Linux:
source .venv/bin/activate
jupyter notebook
```

---

### Step 4: Run the Notebooks (In Order)

Open Jupyter and run each notebook sequentially. Every notebook maps to an **AI-900 exam domain**:

| Order | Notebook | AI-900 Domain | What It Does |
|:-----:|----------|---------------|-------------|
| **1st** | [00_connection_test.ipynb](notebooks/00_connection_test.ipynb) | Setup | **Run this first!** Verifies your Azure keys work |
| **2nd** | [01_responsible_ai.ipynb](notebooks/01_responsible_ai.ipynb) | AI Principles | Explore the 6 Microsoft Responsible AI principles + Content Safety API |
| **3rd** | [02_computer_vision.ipynb](notebooks/02_computer_vision.ipynb) | Computer Vision | Image analysis, OCR, object detection on sample images |
| **4th** | [03_natural_language.ipynb](notebooks/03_natural_language.ipynb) | NLP | Sentiment analysis, key phrases, NER, translation |
| **5th** | [04_speech_ai.ipynb](notebooks/04_speech_ai.ipynb) | Speech | Text-to-Speech and Speech-to-Text with audio playback |
| **6th** | [05_generative_ai.ipynb](notebooks/05_generative_ai.ipynb) | Generative AI | Chat with GPT-4o-mini, prompt engineering patterns |
| **7th** | [06_document_intelligence.ipynb](notebooks/06_document_intelligence.ipynb) | Document AI | Extract structured data from invoices and receipts |

> **Tip:** In each notebook, just click **"Run All"** (or press `Shift+Enter` on each cell). No code changes needed.

---

### Step 5: Stuck? Check the Troubleshooting Guide

Running into errors? The troubleshooting guide covers **every common issue** with exact symptoms and fixes:

👉 **[docs/troubleshooting.md](docs/troubleshooting.md)**

Covers: Python version problems (3.14+ too new, 3.9 too old), `python not recognized`, pip install failures, `.env` mistakes, 401/404 Azure errors, Jupyter kernel issues, firewall/VPN blocks, macOS-specific problems, and more.

### Python Version Note

| Version | Status |
|---------|--------|
| 3.10 – 3.13 | ✅ Supported |
| **3.11** | ✅ **Recommended** |
| 3.14+ | ⚠️ May not work (Azure SDKs may not support it yet) |
| 3.9 or older | ❌ Not supported |

If you have Python 3.14+, see the setup guides for how to install 3.11 side-by-side or switch versions.

---

## Complete Guide Reference

| # | Document | What It Covers |
|---|----------|----------------|
| 1 | [docs/01_azure_portal_setup.md](docs/01_azure_portal_setup.md) | **First** — Create Azure resources, get keys, fill `.env` |
| 2 | [docs/02_local_setup_windows.md](docs/02_local_setup_windows.md) | End-to-end Windows setup: Python check/install, version handling, venv, deps, verification |
| 2 | [docs/03_local_setup_mac.md](docs/03_local_setup_mac.md) | End-to-end macOS setup: Homebrew, Python, Apple Silicon notes, Speech SDK |
| 2 | [docs/04_codespaces_setup.md](docs/04_codespaces_setup.md) | Zero-install browser setup via GitHub Codespaces |
| 3 | [docs/troubleshooting.md](docs/troubleshooting.md) | Every common error: Python versions, pip, .env, Azure API, Jupyter, network |

---

## Project Structure

```
ai900-azure-foundry/
├── notebooks/          ← Jupyter notebooks (run these in order!)
│   ├── 00_connection_test.ipynb
│   ├── 01_responsible_ai.ipynb
│   ├── 02_computer_vision.ipynb
│   ├── 03_natural_language.ipynb
│   ├── 04_speech_ai.ipynb
│   ├── 05_generative_ai.ipynb
│   └── 06_document_intelligence.ipynb
├── docs/               ← Setup guides (read before running notebooks)
├── assets/             ← Sample images, audio, and documents
├── scripts/            ← Helper scripts (check_env.py)
├── .devcontainer/      ← GitHub Codespaces auto-configuration
├── .env.example        ← Template for Azure credentials
├── requirements.txt    ← Python dependencies
├── setup.bat           ← Windows setup script
└── setup.sh            ← macOS/Linux setup script
```

---

## Cost

| Service | Free Allowance |
|---------|----------------|
| Azure AI Services | 20 transactions/min — plenty for labs |
| Azure OpenAI (GPT-4o-mini) | ~$0.15 per 1M input tokens |
| Azure Speech | 5 hours free/month |
| Document Intelligence | 500 pages free/month |

> **Total estimated cost:** Less than **$1** with Azure for Students credits.

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

Built for AI-900 students to gain practical Azure AI experience.
