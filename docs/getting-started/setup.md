# Environment Setup

## Setting Up Your Development Environment

This guide will help you set up your local environment for AI_TRG_FLEX training.

## Prerequisites

Before you begin, ensure you have:
- A modern operating system (Windows 10+, macOS 10.14+, or Linux)
- At least 8GB of RAM (16GB recommended)
- 10GB of free disk space
- Internet connection

## Step 1: Install Python

AI_TRG_FLEX primarily uses Python for AI development.

### Option A: Using Official Python
1. Download Python 3.8 or later from [python.org](https://www.python.org/downloads/)
2. Run the installer
3. Verify installation:
   ```bash
   python --version
   ```

### Option B: Using Anaconda (Recommended)
1. Download Anaconda from [anaconda.com](https://www.anaconda.com/products/distribution)
2. Install following the wizard
3. Verify installation:
   ```bash
   conda --version
   ```

## Step 2: Create a Virtual Environment

### Using venv (Standard Python)
```bash
# Create virtual environment
python -m venv ai_trg_flex_env

# Activate on Windows
ai_trg_flex_env\Scripts\activate

# Activate on macOS/Linux
source ai_trg_flex_env/bin/activate
```

### Using Conda
```bash
# Create environment
conda create -n ai_trg_flex python=3.9

# Activate environment
conda activate ai_trg_flex
```

## Step 3: Install Required Packages

Create a `requirements.txt` file with essential packages:

```txt
numpy>=1.21.0
pandas>=1.3.0
scikit-learn>=0.24.0
matplotlib>=3.4.0
jupyter>=1.0.0
```

Install packages:
```bash
pip install -r requirements.txt
```

## Step 4: Install Development Tools

### Code Editor
Choose one:
- **Visual Studio Code** (Recommended) - [code.visualstudio.com](https://code.visualstudio.com/)
- **PyCharm** - [jetbrains.com/pycharm](https://www.jetbrains.com/pycharm/)
- **Jupyter Notebook** - Already installed with packages above

### VS Code Extensions (if using VS Code)
- Python
- Pylance
- Jupyter
- GitLens

## Step 5: Verify Your Setup

Create a test file `test_setup.py`:

```python
import numpy as np
import pandas as pd
import sklearn
import matplotlib.pyplot as plt

print("NumPy version:", np.__version__)
print("Pandas version:", pd.__version__)
print("Scikit-learn version:", sklearn.__version__)

# Simple test
data = np.array([1, 2, 3, 4, 5])
print("Test array:", data)
print("\n✅ Setup successful!")
```

Run the test:
```bash
python test_setup.py
```

## Step 6: Clone the Training Repository

```bash
git clone https://github.com/jcsara/AI_TRG_FLEX.git
cd AI_TRG_FLEX
```

## Optional Tools

### For Advanced Users

#### GPU Support (NVIDIA)
If you have an NVIDIA GPU:
```bash
pip install tensorflow-gpu
# or
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu117
```

#### Docker
For containerized development:
```bash
docker pull python:3.9
```

## Troubleshooting

### Common Issues

**Issue: Python not found**
- Solution: Ensure Python is added to your PATH

**Issue: Permission denied during pip install**
- Solution: Use `pip install --user` or run with administrator privileges

**Issue: Package conflicts**
- Solution: Use a fresh virtual environment

**Issue: Jupyter not starting**
- Solution: Run `pip install --upgrade jupyter`

## Next Steps

Now that your environment is set up:
1. [Start your first project](first-project.md)
2. [Learn the fundamentals](../core-concepts/fundamentals.md)
3. [Explore examples](../../examples/)

## Need Help?

If you encounter issues:
- Check our [FAQ](../FAQ.md)
- Search existing [GitHub Issues](https://github.com/jcsara/AI_TRG_FLEX/issues)
- Create a new issue with your setup details

---

**You're all set! Time to start learning! 💻**
