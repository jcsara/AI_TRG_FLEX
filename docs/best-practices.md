# Best Practices for AI in FLEX

## General Principles

### 1. Start Simple

- Begin with baseline models before complex solutions
- Use interpretable models when possible
- Add complexity only when necessary
- Document why each complexity is added

### 2. Data First

- Invest time in data quality
- Understand your data distribution
- Handle edge cases properly
- Version your datasets

### 3. Reproducibility

- Set random seeds
- Document dependencies
- Use version control
- Track experiments systematically

## Data Management

### Data Quality

```python
# Always validate input data
def validate_data(df):
    assert not df.isnull().any().any(), "Missing values found"
    assert len(df) > 0, "Empty dataset"
    assert all(df.select_dtypes(include=[np.number]) >= 0), "Negative values in numeric columns"
    return True
```

### Data Splitting

```python
# Use stratified splits for imbalanced data
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    X, y, 
    test_size=0.2, 
    stratify=y,  # Maintain class distribution
    random_state=42  # Reproducibility
)
```

### Feature Engineering

- Create features based on domain knowledge
- Test feature importance regularly
- Remove redundant features
- Document feature transformations

## Model Development

### Training Process

1. **Baseline Model**
   ```python
   # Start with simple model
   baseline = DummyClassifier(strategy='most_frequent')
   baseline.fit(X_train, y_train)
   baseline_score = baseline.score(X_test, y_test)
   ```

2. **Incremental Improvement**
   - Add one improvement at a time
   - Measure impact of each change
   - Keep what works, discard what doesn't

3. **Cross-Validation**
   ```python
   from sklearn.model_selection import cross_val_score
   
   scores = cross_val_score(model, X, y, cv=5)
   print(f"CV Score: {scores.mean():.4f} (+/- {scores.std():.4f})")
   ```

### Hyperparameter Tuning

```python
from sklearn.model_selection import GridSearchCV

param_grid = {
    'n_estimators': [100, 200, 300],
    'max_depth': [5, 10, 15],
    'min_samples_split': [2, 5, 10]
}

grid_search = GridSearchCV(
    model, 
    param_grid, 
    cv=5,
    n_jobs=-1,
    verbose=1
)

grid_search.fit(X_train, y_train)
best_model = grid_search.best_estimator_
```

### Model Evaluation

```python
# Use multiple metrics
from sklearn.metrics import classification_report, confusion_matrix

y_pred = model.predict(X_test)

print(classification_report(y_test, y_pred))
print(confusion_matrix(y_test, y_pred))

# For imbalanced datasets, use balanced accuracy
from sklearn.metrics import balanced_accuracy_score
balanced_acc = balanced_accuracy_score(y_test, y_pred)
```

## Deployment

### Model Serialization

```python
import joblib

# Save model
joblib.dump(model, 'model.pkl')

# Load model
loaded_model = joblib.load('model.pkl')
```

### API Design

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class PredictionRequest(BaseModel):
    features: List[float]

@app.post("/predict")
async def predict(request: PredictionRequest):
    try:
        prediction = model.predict([request.features])
        return {"prediction": prediction.tolist()}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

### Error Handling

```python
def safe_predict(model, X):
    """Prediction with error handling."""
    try:
        # Validate input
        if not isinstance(X, np.ndarray):
            X = np.array(X)
        
        # Check shape
        if X.shape[1] != model.n_features_in_:
            raise ValueError(f"Expected {model.n_features_in_} features")
        
        # Make prediction
        prediction = model.predict(X)
        
        return {"status": "success", "prediction": prediction}
    
    except Exception as e:
        return {"status": "error", "message": str(e)}
```

## Monitoring

### Performance Tracking

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def monitored_predict(model, X):
    start_time = time.time()
    prediction = model.predict(X)
    latency = time.time() - start_time
    
    logger.info(f"Prediction latency: {latency:.4f}s")
    logger.info(f"Prediction: {prediction}")
    
    return prediction
```

### Data Drift Detection

```python
from scipy.stats import ks_2samp

def detect_drift(reference_data, current_data, threshold=0.05):
    """Detect distribution drift using KS test."""
    statistic, p_value = ks_2samp(reference_data, current_data)
    
    if p_value < threshold:
        logger.warning(f"Data drift detected! p-value: {p_value}")
        return True
    return False
```

## Security

### Input Validation

```python
def validate_input(data):
    """Validate user input."""
    # Check for SQL injection attempts
    dangerous_chars = [';', '--', '/*', '*/', 'xp_', 'sp_']
    if any(char in str(data) for char in dangerous_chars):
        raise ValueError("Invalid input detected")
    
    # Check data types
    if not all(isinstance(x, (int, float)) for x in data):
        raise ValueError("Invalid data type")
    
    return True
```

### Model Protection

```python
# Don't expose model details
@app.get("/model/info")
async def model_info():
    return {
        "version": "1.0",
        "status": "active"
        # Don't expose: algorithm, hyperparameters, training data
    }
```

## Documentation

### Code Comments

```python
def train_model(X, y):
    """
    Train a random forest classifier.
    
    Args:
        X (np.ndarray): Training features of shape (n_samples, n_features)
        y (np.ndarray): Training labels of shape (n_samples,)
    
    Returns:
        RandomForestClassifier: Trained model
    
    Raises:
        ValueError: If input shapes are incompatible
    """
    # Implementation
```

### Experiment Tracking

Keep a log of experiments:

```markdown
# Experiment Log

## Experiment 1: Baseline
- Date: 2025-10-27
- Model: Logistic Regression
- Parameters: C=1.0, solver='lbfgs'
- CV Score: 0.85
- Test Score: 0.83

## Experiment 2: Random Forest
- Date: 2025-10-27
- Model: Random Forest
- Parameters: n_estimators=100, max_depth=10
- CV Score: 0.89
- Test Score: 0.87
- Notes: Better than baseline, but longer training time
```

## Testing

### Unit Tests

```python
import unittest

class TestModel(unittest.TestCase):
    def setUp(self):
        self.model = load_model()
    
    def test_prediction_shape(self):
        X = np.random.rand(10, 5)
        pred = self.model.predict(X)
        self.assertEqual(pred.shape[0], 10)
    
    def test_prediction_range(self):
        X = np.random.rand(10, 5)
        pred = self.model.predict_proba(X)
        self.assertTrue(np.all((pred >= 0) & (pred <= 1)))
```

## Checklist

Before deploying to production:

- [ ] Model performance meets requirements
- [ ] Input validation implemented
- [ ] Error handling in place
- [ ] Logging configured
- [ ] Monitoring setup
- [ ] Documentation complete
- [ ] Tests passing
- [ ] Security review done
- [ ] Rollback plan ready
- [ ] Team trained on maintenance
