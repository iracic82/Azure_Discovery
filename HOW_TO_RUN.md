# How to Run the Workflow

## ⚠️ IMPORTANT: Use YOUR Repository, Not the Template!

When you create a repository from the template, you need to run the workflow in **YOUR repository**, not the original template.

---

## Step-by-Step Instructions

### 1. Make Sure You're in YOUR Repository

Check the repository name at the top of the page:

✅ **Correct** - Your repository:
```
https://github.com/YOUR-USERNAME/YOUR-REPO-NAME
```

❌ **Wrong** - Template repository:
```
https://github.com/iracic82/Azure_Discovery
```

---

### 2. Go to Actions Tab

Click the **"Actions"** tab at the top of YOUR repository:

```
┌────────────────────────────────────────────────────────┐
│  < >  Code    Issues    Pull requests    [Actions]     │
└────────────────────────────────────────────────────────┘
```

---

### 3. Select the Workflow

In the left sidebar, click:
```
Onboard Azure Account for Infoblox DNS
```

---

### 4. Click "Run workflow"

You'll see a green button on the right side:
```
┌─────────────────────────────────────────────────┐
│  All workflows                                  │
│                                                 │
│  ▶ Onboard Azure...    [Run workflow ▼]  ←──   │
│                                            Click here!
└─────────────────────────────────────────────────┘
```

---

### 5. Fill in the Form

A form will appear:

```
┌─────────────────────────────────────────────────┐
│  Run workflow                                   │
│                                                 │
│  Branch: main                                   │
│                                                 │
│  Infoblox Application ID *                      │
│  ┌───────────────────────────────────────┐     │
│  │ [paste your Application ID here]      │     │
│  └───────────────────────────────────────┘     │
│                                                 │
│  Azure Subscription ID (optional)               │
│  ┌───────────────────────────────────────┐     │
│  │ [leave empty for auto-discover]       │     │
│  └───────────────────────────────────────┘     │
│                                                 │
│  [Run workflow]  ← Click this green button     │
└─────────────────────────────────────────────────┘
```

---

### 6. Monitor Progress

The workflow will start running. Click on it to see progress:

```
┌─────────────────────────────────────────────────┐
│  ● Onboard Azure Account for Infoblox DNS       │
│    #1 - Running                                 │
│                                                 │
│    ✓ Azure Login                                │
│    ● Run Azure Discovery and Configuration      │
│    ○ Display Configuration Summary              │
└─────────────────────────────────────────────────┘
```

---

### 7. Get the Output

When complete, click on **"Display Configuration Summary"** step to see:

```
🎯 COPY THIS TENANT ID TO INFOBLOX PORTAL:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Tenant ID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Copy this Tenant ID and paste it in Infoblox Portal!

---

## Common Mistakes

### ❌ Mistake 1: Running in Template Repository

**Problem**: You click the "Deploy" button in the template repository README
**Result**: The workflow runs in the template (iracic82/Azure_Discovery), not your repository
**Solution**: Go to YOUR repository's Actions tab instead

### ❌ Mistake 2: No Workflow in Actions Tab

**Problem**: Actions tab is empty or workflow not visible
**Reasons**:
- You didn't create from template correctly
- Actions are disabled in your repository
**Solution**:
  - Go to Settings → Actions → General
  - Enable "Allow all actions and reusable workflows"

### ❌ Mistake 3: Azure Login Fails

**Problem**: "Application with identifier not found" error
**Solution**: Make sure you added the `AZURE_CREDENTIALS` secret in YOUR repository
- Settings → Secrets and variables → Actions
- Should see `AZURE_CREDENTIALS` listed

---

## Quick Checklist

Before running, verify:

- [ ] I'm in MY repository (check URL)
- [ ] I've added the `AZURE_CREDENTIALS` secret
- [ ] I'm in the **Actions** tab of MY repository
- [ ] I clicked **"Onboard Azure Account for Infoblox DNS"** in left sidebar
- [ ] I clicked green **"Run workflow"** button
- [ ] I filled in the Application ID
- [ ] I clicked the green **"Run workflow"** button at bottom

✅ If all checked, the workflow should run successfully!

---

## Still Confused?

### Visual Example:

```
Step 1: You created repo from template
   Template: github.com/iracic82/Azure_Discovery
   ↓ [Use this template]
   Your Repo: github.com/YOUR-NAME/your-azure-infoblox

Step 2: Go to YOUR repo (check URL!)
   ✅ github.com/YOUR-NAME/your-azure-infoblox

Step 3: Click Actions tab IN YOUR REPO
   ✅ github.com/YOUR-NAME/your-azure-infoblox/actions

Step 4: Run workflow IN YOUR REPO
   The workflow uses YOUR AZURE_CREDENTIALS secret
   The workflow runs in YOUR account
   The output appears in YOUR workflow logs
```

---

## Need Help?

If you're still stuck:
1. Double-check you're in YOUR repository (look at the URL)
2. Verify the `AZURE_CREDENTIALS` secret exists in YOUR repository
3. Make sure Actions are enabled in YOUR repository settings
4. Contact your vendor for support

The key is: **Everything happens in YOUR repository, not the template!**
