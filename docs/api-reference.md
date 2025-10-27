# API Reference

This document provides a **template** API reference for what a FLEX AI framework might look like. 

> **Note**: This is example documentation showing how an AI framework API could be structured. The examples use scikit-learn and pandas underneath. For actual working code, refer to the examples in the `examples/` directory.

## Using Scikit-Learn Directly

Since this is a training repository, we'll use scikit-learn and pandas directly. Here's the practical API you'll use:

### Data Loading with Pandas

```python
import pandas as pd

# From CSV
df = pd.read_csv('data.csv')

# From Python data
data = {'feature1': [1, 2, 3], 'feature2': [4, 5, 6]}
df = pd.DataFrame(data)
```

### Data Preprocessing with Scikit-Learn

```python
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Scale features
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)
```

### Model Training

```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression, LinearRegression

# Classification
clf = RandomForestClassifier(n_estimators=100, random_state=42)
clf.fit(X_train, y_train)
predictions = clf.predict(X_test)

# Regression
reg = LinearRegression()
reg.fit(X_train, y_train)
predictions = reg.predict(X_test)
```

### Model Evaluation

```python
from sklearn.metrics import (
    accuracy_score, 
    classification_report,
    mean_squared_error,
    r2_score
)

# Classification metrics
accuracy = accuracy_score(y_test, predictions)
report = classification_report(y_test, predictions)

# Regression metrics
mse = mean_squared_error(y_test, predictions)
r2 = r2_score(y_test, predictions)
```

### Pipelines

```python
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier

# Create pipeline
pipeline = Pipeline([
    ('scaler', StandardScaler()),
    ('classifier', RandomForestClassifier())
])

# Fit and predict
pipeline.fit(X_train, y_train)
predictions = pipeline.predict(X_test)
```

### Hyperparameter Tuning

```python
from sklearn.model_selection import GridSearchCV

param_grid = {
    'n_estimators': [100, 200, 300],
    'max_depth': [5, 10, 15]
}

grid_search = GridSearchCV(
    RandomForestClassifier(),
    param_grid,
    cv=5,
    n_jobs=-1
)

grid_search.fit(X_train, y_train)
best_model = grid_search.best_estimator_
best_params = grid_search.best_params_
```

### Model Persistence

```python
import joblib

# Save model
joblib.dump(model, 'model.pkl')

# Load model
loaded_model = joblib.load('model.pkl')
```

## Complete Example

```python
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
from sklearn.pipeline import Pipeline

# Load data
df = pd.read_csv('data.csv')
X = df.drop('target', axis=1)
y = df['target']

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Create pipeline
pipeline = Pipeline([
    ('scaler', StandardScaler()),
    ('classifier', RandomForestClassifier(n_estimators=100, random_state=42))
])

# Train
pipeline.fit(X_train, y_train)

# Predict
predictions = pipeline.predict(X_test)

# Evaluate
accuracy = accuracy_score(y_test, predictions)
print(f"Accuracy: {accuracy:.2%}")
print("\nClassification Report:")
print(classification_report(y_test, predictions))
```

## Model Deployment with FastAPI

For deploying models as APIs:

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import joblib
import numpy as np

app = FastAPI()

# Load model at startup
model = joblib.load('model.pkl')

class PredictionRequest(BaseModel):
    features: list[float]

class PredictionResponse(BaseModel):
    prediction: float
    
@app.post("/predict", response_model=PredictionResponse)
async def predict(request: PredictionRequest):
    try:
        # Convert to numpy array
        X = np.array([request.features])
        
        # Make prediction
        prediction = model.predict(X)[0]
        
        return PredictionResponse(prediction=float(prediction))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Run with: uvicorn api:app --reload
```

## Common Scikit-Learn Classes

### Classification Models
- `LogisticRegression`
- `DecisionTreeClassifier`
- `RandomForestClassifier`
- `GradientBoostingClassifier`
- `SVC` (Support Vector Classifier)
- `KNeighborsClassifier`

### Regression Models
- `LinearRegression`
- `Ridge`
- `Lasso`
- `DecisionTreeRegressor`
- `RandomForestRegressor`
- `GradientBoostingRegressor`

### Preprocessing
- `StandardScaler` - Standardize features
- `MinMaxScaler` - Scale to range [0, 1]
- `LabelEncoder` - Encode labels
- `OneHotEncoder` - One-hot encode categorical features

### Model Selection
- `train_test_split` - Split data
- `cross_val_score` - Cross-validation
- `GridSearchCV` - Grid search
- `RandomizedSearchCV` - Randomized search

### Metrics
- Classification: `accuracy_score`, `precision_score`, `recall_score`, `f1_score`
- Regression: `mean_squared_error`, `mean_absolute_error`, `r2_score`

## Resources

- [Scikit-Learn Documentation](https://scikit-learn.org/stable/)
- [Pandas Documentation](https://pandas.pydata.org/docs/)
- [NumPy Documentation](https://numpy.org/doc/)
- [Working Examples](../examples/)

---

For practical examples, see the [examples directory](../examples/).

---

## Conceptual FLEX Framework (Future Development)

The sections below describe what a custom FLEX framework could look like. This is aspirational and shows how you might wrap scikit-learn and other libraries into a unified interface.

<details>
<summary>Click to expand conceptual framework documentation</summary>

### flex.data Module (Conceptual)

This would wrap pandas and provide utilities:

```python
# Conceptual - not implemented
from flex.data import DataLoader, DataPreprocessor

loader = DataLoader(source="path/to/data", format="csv")
data = loader.load()
```

### flex.model Module (Conceptual)

This would provide a unified interface to various algorithms:

```python
# Conceptual - not implemented
from flex.model import Model

model = Model(algorithm="random_forest", **params)
model.fit(X_train, y_train)
```

</details>

---

For questions about the actual implementation, refer to working examples in the `examples/` directory.
