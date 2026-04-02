# Azure Portal Setup Guide

This guide walks you through creating all the Azure resources needed for the AI-900 notebooks.

**Time required:** ~15-20 minutes

**Cost:** Free with Azure for Students ($100 credit)

---

## Prerequisites

- An Azure account. [Sign up for Azure for Students](https://azure.microsoft.com/en-us/free/students/) (free, no credit card needed)
- A web browser

---

## Step 1: Sign in to the Azure Portal

1. Go to [https://portal.azure.com](https://portal.azure.com)
2. Sign in with your student email

---

## Step 2: Create a Resource Group

A resource group is a container that holds all your Azure resources together.

1. In the search bar at the top, type **"Resource groups"** and click on it
2. Click **"+ Create"**
3. Fill in:
   - **Subscription:** Your Azure for Students subscription
   - **Resource group name:** `ai900-lab`
   - **Region:** `East US` (or your nearest region)
4. Click **"Review + Create"** then **"Create"**

---

## Step 3: Create an Azure AI Services Multi-Service Resource

This single resource gives you access to Vision, Language, Content Safety, and more.

1. In the search bar, type **"Azure AI services"** and click on it
2. Click **"+ Create"** under **Azure AI services multi-service account**
3. Fill in:
   - **Subscription:** Your Azure for Students subscription
   - **Resource group:** `ai900-lab`
   - **Region:** `East US` (use the same region as your resource group)
   - **Name:** `ai900-services` (must be globally unique - add your initials if taken)
   - **Pricing tier:** `Standard S0`
4. Check the **Responsible AI** acknowledgment box
5. Click **"Review + Create"** then **"Create"**
6. Wait for deployment to complete (1-2 minutes)

### Get Your Keys

1. Once deployed, click **"Go to resource"**
2. In the left menu, click **"Keys and Endpoint"**
3. Copy these values to your `.env` file:
   - **KEY 1** → `AZURE_AI_KEY`
   - **Endpoint** → `AZURE_AI_ENDPOINT`
   - **KEY 1** → `AZURE_DOC_INTEL_KEY` (same key works)
   - **Endpoint** → `AZURE_DOC_INTEL_ENDPOINT` (same endpoint works)
   - **KEY 1** → `AZURE_SPEECH_KEY` (same key works for Speech too)
   
4. Note the **Location/Region** (e.g., `eastus`) → `AZURE_SPEECH_REGION`

> **Tip:** Key 1 and Key 2 are interchangeable. Use either one.

---

## Step 4: Create an Azure OpenAI Resource

1. In the search bar, type **"Azure OpenAI"** and click on it
2. Click **"+ Create"**
3. Fill in:
   - **Subscription:** Your Azure for Students subscription
   - **Resource group:** `ai900-lab`
   - **Region:** `East US` (or any region where GPT-4o-mini is available)
   - **Name:** `ai900-openai` (must be globally unique)
   - **Pricing tier:** `Standard S0`
4. Click **"Review + Create"** then **"Create"**
5. Wait for deployment to complete

> **Note:** If you don't see Azure OpenAI, you may need to [request access](https://aka.ms/oai/access). Most Azure for Students accounts have access by default.

---

## Step 5: Deploy a GPT Model

1. Once the OpenAI resource is deployed, click **"Go to resource"**
2. Click **"Go to Azure AI Foundry portal"** (or go to [https://ai.azure.com](https://ai.azure.com))
3. In Azure AI Foundry, navigate to your project
4. Click **"Deployments"** in the left menu
5. Click **"+ Deploy model"** → **"Deploy base model"**
6. Search for **"gpt-4o-mini"** and select it
7. Click **"Confirm"**
8. Configure:
   - **Deployment name:** `gpt-4o-mini` (keep this name - it matches the `.env` default)
   - **Deployment type:** `Standard`
   - Leave other settings as default
9. Click **"Deploy"**

### Get Your OpenAI Keys

1. Go back to the [Azure Portal](https://portal.azure.com)
2. Navigate to your `ai900-openai` resource
3. Click **"Keys and Endpoint"** in the left menu
4. Copy these values to your `.env` file:
   - **KEY 1** → `AZURE_OPENAI_KEY`
   - **Endpoint** → `AZURE_OPENAI_ENDPOINT`
   - The deployment name is `gpt-4o-mini` → `AZURE_OPENAI_DEPLOYMENT`

---

## Step 6: Fill in Your .env File

Open the `.env` file in your project root and fill in all the values:

```ini
# Azure AI Services
AZURE_AI_ENDPOINT=https://ai900-services.cognitiveservices.azure.com/
AZURE_AI_KEY=abc123...your-key-here...

# Azure OpenAI
AZURE_OPENAI_ENDPOINT=https://ai900-openai.openai.azure.com/
AZURE_OPENAI_KEY=xyz789...your-key-here...
AZURE_OPENAI_DEPLOYMENT=gpt-4o-mini

# Azure Speech (same key as AI Services if using multi-service)
AZURE_SPEECH_KEY=abc123...same-key-as-above...
AZURE_SPEECH_REGION=eastus

# Azure Document Intelligence (same key as AI Services if using multi-service)
AZURE_DOC_INTEL_ENDPOINT=https://ai900-services.cognitiveservices.azure.com/
AZURE_DOC_INTEL_KEY=abc123...same-key-as-above...
```

---

## Step 7: Verify Your Setup

Run the connection test notebook (`notebooks/00_connection_test.ipynb`) to verify everything works!

---

## Cost Summary

| Service | Free Tier / Student Allowance |
|---------|-------------------------------|
| Azure AI Services | 20 transactions/min, plenty for lab use |
| Azure OpenAI (GPT-4o-mini) | Very low cost (~$0.15/1M input tokens) |
| Azure Speech | 5 hours free per month |
| Document Intelligence | 500 pages free per month |

> **Total estimated cost for this lab:** Less than $1 with Azure for Students credits.

---

## Troubleshooting

If you run into issues during setup, check [troubleshooting.md](troubleshooting.md).
