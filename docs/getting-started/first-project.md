# Your First AI Project

## Building Your First Machine Learning Model

Welcome! In this tutorial, you'll build your first AI model from scratch. We'll keep it simple and practical.

## Project Overview

**Goal**: Create a simple classification model to predict outcomes based on data.

**What you'll learn**:
- Loading and exploring data
- Preparing data for machine learning
- Training a model
- Evaluating model performance
- Making predictions

**Time required**: ~30 minutes

## Prerequisites

- Completed [environment setup](setup.md)
- Basic Python knowledge
- Curiosity and patience!

## Step 1: Understanding the Problem

We'll create a model that predicts whether a customer will make a purchase based on:
- Age
- Income
- Time spent on website

This is a **binary classification** problem (Yes/No outcome).

## Step 2: Create Your Project File

Create a new file called `first_project.py`:

```python
# First AI Project - Customer Purchase Prediction
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report

# Step 1: Create sample data
print("Step 1: Creating sample data...")
np.random.seed(42)

# Generate synthetic customer data
n_samples = 1000
age = np.random.randint(18, 70, n_samples)
income = np.random.randint(20000, 150000, n_samples)
time_spent = np.random.randint(1, 60, n_samples)

# Create target variable (1 = purchase, 0 = no purchase)
# Higher income and more time spent increase purchase probability
purchase = ((income > 60000) & (time_spent > 20)).astype(int)

# Add some randomness
purchase = (purchase + np.random.binomial(1, 0.15, n_samples)) % 2

# Create DataFrame
data = pd.DataFrame({
    'age': age,
    'income': income,
    'time_spent': time_spent,
    'purchase': purchase
})

print(f"Created {len(data)} customer records")
print("\nFirst 5 rows:")
print(data.head())
print("\nPurchase distribution:")
print(data['purchase'].value_counts())

# Step 2: Prepare the data
print("\n" + "="*50)
print("Step 2: Preparing data for training...")

# Separate features and target
X = data[['age', 'income', 'time_spent']]
y = data['purchase']

# Split into training and testing sets (80/20)
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Scale the features (important for many ML algorithms)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

print(f"Training samples: {len(X_train)}")
print(f"Testing samples: {len(X_test)}")

# Step 3: Train the model
print("\n" + "="*50)
print("Step 3: Training the model...")

model = LogisticRegression(random_state=42)
model.fit(X_train_scaled, y_train)

print("✅ Model trained successfully!")

# Step 4: Evaluate the model
print("\n" + "="*50)
print("Step 4: Evaluating model performance...")

# Make predictions
y_pred = model.predict(X_test_scaled)

# Calculate accuracy
accuracy = accuracy_score(y_test, y_pred)
print(f"\nModel Accuracy: {accuracy:.2%}")

# Detailed classification report
print("\nDetailed Classification Report:")
print(classification_report(y_test, y_pred, 
                          target_names=['No Purchase', 'Purchase']))

# Step 5: Make predictions on new data
print("\n" + "="*50)
print("Step 5: Making predictions on new customers...")

# Example new customers
new_customers = pd.DataFrame({
    'age': [25, 45, 60],
    'income': [35000, 95000, 120000],
    'time_spent': [10, 35, 45]
})

# Scale and predict
new_customers_scaled = scaler.transform(new_customers)
predictions = model.predict(new_customers_scaled)
probabilities = model.predict_proba(new_customers_scaled)

print("\nNew Customer Predictions:")
for i, (_, customer) in enumerate(new_customers.iterrows()):
    pred = "Will Purchase" if predictions[i] == 1 else "Won't Purchase"
    prob = probabilities[i][1] * 100
    print(f"\nCustomer {i+1}:")
    print(f"  Age: {customer['age']}, Income: ${customer['income']}, "
          f"Time Spent: {customer['time_spent']} min")
    print(f"  Prediction: {pred} (Confidence: {prob:.1f}%)")

print("\n" + "="*50)
print("🎉 Congratulations! You've built your first AI model!")
print("\nNext steps:")
print("- Try adjusting the features")
print("- Experiment with different models")
print("- Create your own dataset")
print("- Move on to intermediate tutorials")
```

## Step 3: Run Your Project

Execute the script:
```bash
python first_project.py
```

## Step 4: Understanding the Output

You should see:
1. **Sample data** - Shows the created dataset
2. **Data split** - Training vs testing sets
3. **Model accuracy** - How well the model performs
4. **Predictions** - Results for new customers

## Step 5: Experiment!

Try these modifications:

### Easy
- Change the number of samples (`n_samples`)
- Modify the age range
- Adjust feature importance

### Medium
- Add a new feature (e.g., website visits)
- Try different train/test split ratios
- Change the model threshold

### Advanced
- Try a different algorithm (e.g., Decision Tree)
- Add data visualization
- Implement cross-validation

## Key Concepts Learned

✅ **Data Preparation** - Creating and organizing data  
✅ **Train/Test Split** - Separating data for validation  
✅ **Feature Scaling** - Normalizing input values  
✅ **Model Training** - Teaching the algorithm  
✅ **Evaluation** - Measuring performance  
✅ **Prediction** - Using the model on new data  

## Common Issues and Solutions

**Issue**: ImportError for sklearn
- Solution: `pip install scikit-learn`

**Issue**: Model accuracy is too low
- Solution: This is normal for random data. Try adjusting the rules in the data generation.

**Issue**: Warnings about convergence
- Solution: Add `max_iter=1000` to LogisticRegression

## Next Steps

Great job! Now you can:

1. **Explore More Concepts**
   - [AI Fundamentals](../core-concepts/fundamentals.md)
   - [FLEX Architecture](../core-concepts/architecture.md)

2. **Try More Examples**
   - Browse the [examples directory](../../examples/)
   - Work through [beginner exercises](../../exercises/)

3. **Join the Community**
   - Share your results
   - Ask questions
   - Help others learn

## Challenge Yourself

Before moving on, try to:
- [ ] Achieve >75% accuracy
- [ ] Add one more feature
- [ ] Visualize the results with matplotlib
- [ ] Save the model to disk
- [ ] Load and use the saved model

---

**You're on your way to becoming an AI developer! 🚀**
