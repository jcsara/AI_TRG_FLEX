# Quick Start Guide

Get started with AI training in FLEX in just a few minutes!

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/jcsara/AI_TRG_FLEX.git
cd AI_TRG_FLEX
```

### 2. Set Up Python Environment

We recommend using a virtual environment:

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Linux/Mac:
source venv/bin/activate
# On Windows:
venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

## Your First Model

Let's create a simple classification model in just a few lines of code!

### Step 1: Create a Python File

Create a file named `my_first_model.py`:

```python
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Load data
iris = load_iris()
X, y = iris.data, iris.target

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Train model
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Make predictions
predictions = model.predict(X_test)

# Evaluate
accuracy = accuracy_score(y_test, predictions)
print(f"Model Accuracy: {accuracy:.2%}")
```

### Step 2: Run It

```bash
python my_first_model.py
```

Expected output:
```
Model Accuracy: 100.00%
```

Congratulations! You've just trained your first AI model! 🎉

## Next Steps

### 1. Run Example Scripts

Try the provided examples:

```bash
cd examples
python iris_classification.py
python linear_regression_demo.py
```

### 2. Start Learning Modules

Begin with Module 1:

```bash
cd modules/01-getting-started
cat README.md
```

### 3. Explore Documentation

- [FLEX AI Guide](flex-ai-guide.md) - Complete guide to AI in FLEX
- [Best Practices](best-practices.md) - Industry best practices
- [API Reference](api-reference.md) - Detailed API documentation

## Common Tasks

### Loading Data

```python
import pandas as pd

# From CSV
df = pd.read_csv('data.csv')

# From Python lists
data = {'feature1': [1, 2, 3], 'feature2': [4, 5, 6]}
df = pd.DataFrame(data)
```

### Training a Model

```python
from sklearn.ensemble import RandomForestClassifier

model = RandomForestClassifier()
model.fit(X_train, y_train)
```

### Making Predictions

```python
predictions = model.predict(X_test)
probabilities = model.predict_proba(X_test)
```

### Evaluating Performance

```python
from sklearn.metrics import accuracy_score, classification_report

accuracy = accuracy_score(y_test, predictions)
report = classification_report(y_test, predictions)
print(report)
```

### Saving and Loading Models

```python
import joblib

# Save model
joblib.dump(model, 'my_model.pkl')

# Load model
loaded_model = joblib.load('my_model.pkl')
```

## Troubleshooting

### Issue: Import errors

**Solution**: Make sure all dependencies are installed:
```bash
pip install -r requirements.txt
```

### Issue: "No module named 'sklearn'"

**Solution**: Install scikit-learn:
```bash
pip install scikit-learn
```

### Issue: Out of memory

**Solution**: Reduce batch size or use smaller dataset for testing

### Issue: Model performance is poor

**Solution**: Check:
1. Data quality
2. Feature engineering
3. Model hyperparameters
4. Train/test split

## Resources

- **Documentation**: See the `docs/` directory
- **Examples**: Check the `examples/` directory
- **Modules**: Progressive training in `modules/`
- **Issues**: Report problems on GitHub

## Getting Help

- Open an issue on GitHub
- Check existing documentation
- Review example code
- Read module lessons

## What's Next?

1. **Complete Module 1**: Learn the fundamentals
2. **Build Projects**: Apply what you've learned
3. **Share Knowledge**: Help others in the community
4. **Contribute**: Add your own examples and modules

---

Happy learning! Start with [Module 1: Getting Started](../modules/01-getting-started/README.md)
