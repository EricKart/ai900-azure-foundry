# AI-900 Hands-On Lab with Azure AI Foundry

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/EricKart/ai900-azure-foundry?quickstart=1)
[![Python 3.8+](https://img.shields.io/badge/python-3.8%2B-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> **No coding required!** Clone this repo, set up your Azure credentials, and run pre-built Jupyter notebooks to explore every AI-900 exam domain hands-on.

---

## Quick Start

| Method | Time to Start | Difficulty | Guide |
|--------|--------------|------------|-------|
| **GitHub Codespaces** (recommended) | ~2 min | Easiest | [Codespaces Setup](docs/04_codespaces_setup.md) |
| **Windows Local** | ~10 min | Easy | [Windows Setup](docs/02_local_setup_windows.md) |
| **macOS Local** | ~10 min | Easy | [macOS Setup](docs/03_local_setup_mac.md) |

---

## What You'll Learn

Each notebook maps directly to an **AI-900 exam domain**:

| # | Notebook | AI-900 Domain | What It Does |
|---|----------|---------------|-------------|
| 0 | [Connection Test](notebooks/00_connection_test.ipynb) | Setup | Verifies your Azure credentials and service connectivity |
| 1 | [Responsible AI](notebooks/01_responsible_ai.ipynb) | AI Principles | Explore the 6 Microsoft Responsible AI principles + Content Safety API |
| 2 | [Computer Vision](notebooks/02_computer_vision.ipynb) | Computer Vision | Image analysis, OCR, object detection on sample images |
| 3 | [Natural Language](notebooks/03_natural_language.ipynb) | NLP | Sentiment analysis, key phrases, NER, translation |
| 4 | [Speech AI](notebooks/04_speech_ai.ipynb) | Speech | Text-to-Speech and Speech-to-Text with audio playback |
| 5 | [Generative AI](notebooks/05_generative_ai.ipynb) | Generative AI | Chat with GPT-4o-mini, prompt engineering patterns |
| 6 | [Document Intelligence](notebooks/06_document_intelligence.ipynb) | Document AI | Extract structured data from invoices and receipts |

---

## Prerequisites

1. **Azure for Students account** (free $100 credit) — [Sign up here](https://azure.microsoft.com/en-us/free/students/)
2. **Azure AI Foundry resources** — Follow [Azure Portal Setup Guide](docs/01_azure_portal_setup.md)
3. **Python 3.8+** — Only needed for local setup (Codespaces handles this automatically)

---

## Setup (3 Steps)

### Step 1: Clone the Repository

```bash
git clone https://github.com/EricKart/ai900-azure-foundry.git
cd ai900-azure-foundry
```

### Step 2: Run the Setup Script

**Windows (PowerShell or Command Prompt):**
```cmd
setup.bat
```

**macOS / Linux (Terminal):**
```bash
chmod +x setup.sh
./setup.sh
```

This will:
- Create a Python virtual environment
- Install all dependencies
- Create your `.env` file from the template

### Step 3: Add Your Azure Credentials

Open the `.env` file and paste your keys from the [Azure Portal Setup Guide](docs/01_azure_portal_setup.md):

```ini
AZURE_AI_ENDPOINT=https://your-resource.cognitiveservices.azure.com/
AZURE_AI_KEY=your-key-here
AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com/
AZURE_OPENAI_KEY=your-key-here
...
```

Then open Jupyter and run the notebooks in order:
```bash
jupyter notebook
```

---

## Troubleshooting

Running into issues? Check the [Troubleshooting Guide](docs/troubleshooting.md) — it covers the top 10 common problems students encounter.

---

## Project Structure

```
ai900-azure-foundry/
├── notebooks/          ← Jupyter notebooks (run these!)
├── assets/             ← Sample images, audio, and documents
├── docs/               ← Setup guides and troubleshooting
├── scripts/            ← Helper scripts
├── .devcontainer/      ← GitHub Codespaces configuration
├── .env.example        ← Template for Azure credentials
├── requirements.txt    ← Python dependencies
├── setup.bat           ← Windows setup script
└── setup.sh            ← macOS/Linux setup script
```

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

Built for AI-900 students to gain practical Azure AI experience.
