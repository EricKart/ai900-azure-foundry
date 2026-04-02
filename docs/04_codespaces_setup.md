# GitHub Codespaces Setup (Easiest Method)

Use GitHub Codespaces to run everything in your browser - **no local installation needed!**

**Time required:** ~2 minutes (after Azure credentials are ready)

---

## What is GitHub Codespaces?

Codespaces gives you a full VS Code environment in your browser. Everything (Python, Jupyter, all packages) is pre-installed automatically.

**Free allowance:** GitHub gives every account **120 core-hours/month** of free Codespaces. This lab uses about 1-2 hours, so you have plenty of free time.

---

## Step 1: Open in Codespaces

Click this button:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/EricKart/ai900-azure-foundry?quickstart=1)

Or manually:
1. Go to [https://github.com/EricKart/ai900-azure-foundry](https://github.com/EricKart/ai900-azure-foundry)
2. Click the green **"Code"** button
3. Switch to the **"Codespaces"** tab
4. Click **"Create codespace on main"**

---

## Step 2: Wait for Setup (~1 minute)

The Codespace will:
1. Create a container with Python 3.11
2. Install all dependencies from `requirements.txt`
3. Create a `.env` file from the template

You'll see a VS Code editor in your browser when it's ready.

---

## Step 3: Add Your Azure Credentials

1. In the VS Code file explorer (left panel), click on `.env`
2. Fill in your Azure keys (see [Azure Portal Setup Guide](01_azure_portal_setup.md))
3. Press **Ctrl+S** (or **Cmd+S** on Mac) to save

---

## Step 4: Run the Notebooks

1. In the file explorer, navigate to `notebooks/`
2. Click on `00_connection_test.ipynb`
3. VS Code will open it as a Jupyter notebook
4. Click **"Run All"** at the top (or click the play button on each cell)
5. If prompted to select a kernel, choose **Python 3.11**

> **Note:** The first cell might take a few seconds to start as Jupyter initializes.

---

## Step 5: Continue Through All Notebooks

Run the notebooks in order:
1. `00_connection_test.ipynb` - Verify everything works
2. `01_responsible_ai.ipynb` - AI Principles & Content Safety
3. `02_computer_vision.ipynb` - Image Analysis & OCR
4. `03_natural_language.ipynb` - Sentiment, NER, Translation
5. `04_speech_ai.ipynb` - Text-to-Speech & Speech-to-Text
6. `05_generative_ai.ipynb` - GPT & Prompt Engineering
7. `06_document_intelligence.ipynb` - Document Parsing

---

## Returning to Your Codespace

Your Codespace stays alive for a while:
1. Go to [https://github.com/codespaces](https://github.com/codespaces)
2. Find your Codespace and click on it to reconnect
3. Your `.env` file and any changes you made are still there

---

## Stopping Your Codespace

When you're done, stop the Codespace to save your free hours:
1. Go to [https://github.com/codespaces](https://github.com/codespaces)
2. Click the **"..."** menu next to your Codespace
3. Click **"Stop codespace"**

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Codespace won't start | Try a different browser (Chrome recommended) |
| "Kernel not found" | Click "Select Kernel" → "Python Environments" → "Python 3.11" |
| `.env` changes not taking effect | Save the file (Ctrl+S), then restart the kernel (Kernel → Restart) |
| Audio doesn't play (notebook 04) | This is normal in some Codespace configurations. The audio files are saved in `assets/audio/` |
| Slow performance | Free tier Codespaces have 2 cores. This is enough for all notebooks |

For more issues, see [troubleshooting.md](troubleshooting.md).
