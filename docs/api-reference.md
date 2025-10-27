# API Reference

This document provides detailed API reference for working with AI in FLEX.

## Core Modules

### flex.data

Data loading and preprocessing utilities.

#### DataLoader

Load data from various sources.

```python
from flex.data import DataLoader

loader = DataLoader(source="path/to/data", format="csv")
data = loader.load()
```

**Parameters:**
- `source` (str): Path to data source
- `format` (str): Data format ('csv', 'json', 'parquet', 'database')
- `options` (dict): Format-specific options

**Methods:**

##### load()

Load data from the configured source.

```python
data = loader.load()
```

**Returns:** pandas.DataFrame

##### validate()

Validate data quality.

```python
is_valid, errors = loader.validate()
```

**Returns:** tuple(bool, list)

#### DataPreprocessor

Preprocess and transform data.

```python
from flex.data import DataPreprocessor

preprocessor = DataPreprocessor()
preprocessor.fit(data)
transformed = preprocessor.transform(data)
```

**Methods:**

##### fit(data)

Learn preprocessing parameters from data.

**Parameters:**
- `data` (DataFrame): Training data

**Returns:** self

##### transform(data)

Apply preprocessing transformations.

**Parameters:**
- `data` (DataFrame): Data to transform

**Returns:** DataFrame

##### fit_transform(data)

Fit and transform in one step.

**Parameters:**
- `data` (DataFrame): Data to fit and transform

**Returns:** DataFrame

### flex.model

Model training and prediction.

#### Model

Base model class for training and inference.

```python
from flex.model import Model

model = Model(algorithm="random_forest", **params)
model.fit(X_train, y_train)
predictions = model.predict(X_test)
```

**Parameters:**
- `algorithm` (str): Algorithm name
- `params` (dict): Algorithm-specific hyperparameters

**Methods:**

##### fit(X, y)

Train the model.

**Parameters:**
- `X` (array-like): Training features
- `y` (array-like): Training labels

**Returns:** self

##### predict(X)

Make predictions.

**Parameters:**
- `X` (array-like): Input features

**Returns:** array-like predictions

##### predict_proba(X)

Predict class probabilities (classification only).

**Parameters:**
- `X` (array-like): Input features

**Returns:** array-like probabilities

##### score(X, y)

Calculate model score.

**Parameters:**
- `X` (array-like): Input features
- `y` (array-like): True labels

**Returns:** float score

##### save(path)

Save model to disk.

**Parameters:**
- `path` (str): Save path

##### load(path)

Load model from disk.

**Parameters:**
- `path` (str): Model path

**Returns:** Model instance

#### Classifier

Classification-specific model.

```python
from flex.model import Classifier

clf = Classifier(algorithm="logistic_regression")
clf.fit(X_train, y_train)
```

**Inherits from:** Model

**Additional Methods:**

##### get_classes()

Get class labels.

**Returns:** array of class labels

#### Regressor

Regression-specific model.

```python
from flex.model import Regressor

reg = Regressor(algorithm="linear_regression")
reg.fit(X_train, y_train)
```

**Inherits from:** Model

### flex.pipeline

End-to-end ML pipelines.

#### Pipeline

Chain multiple processing steps.

```python
from flex.pipeline import Pipeline
from flex.data import DataPreprocessor
from flex.model import Classifier

pipeline = Pipeline([
    ('preprocessor', DataPreprocessor()),
    ('classifier', Classifier(algorithm='random_forest'))
])

pipeline.fit(X_train, y_train)
predictions = pipeline.predict(X_test)
```

**Parameters:**
- `steps` (list): List of (name, transformer) tuples

**Methods:**

##### fit(X, y)

Fit all steps.

**Parameters:**
- `X` (array-like): Training features
- `y` (array-like): Training labels

**Returns:** self

##### predict(X)

Apply all transformations and predict.

**Parameters:**
- `X` (array-like): Input features

**Returns:** predictions

##### fit_predict(X, y)

Fit and predict in one step.

**Parameters:**
- `X` (array-like): Features
- `y` (array-like): Labels

**Returns:** predictions

### flex.metrics

Model evaluation metrics.

#### accuracy_score

Calculate classification accuracy.

```python
from flex.metrics import accuracy_score

acc = accuracy_score(y_true, y_pred)
```

**Parameters:**
- `y_true` (array-like): Ground truth labels
- `y_pred` (array-like): Predicted labels

**Returns:** float accuracy

#### mean_squared_error

Calculate MSE for regression.

```python
from flex.metrics import mean_squared_error

mse = mean_squared_error(y_true, y_pred)
```

**Parameters:**
- `y_true` (array-like): Ground truth values
- `y_pred` (array-like): Predicted values

**Returns:** float MSE

#### classification_report

Generate detailed classification report.

```python
from flex.metrics import classification_report

report = classification_report(y_true, y_pred)
print(report)
```

**Parameters:**
- `y_true` (array-like): Ground truth labels
- `y_pred` (array-like): Predicted labels

**Returns:** str report

### flex.tuning

Hyperparameter optimization.

#### GridSearch

Grid search for best hyperparameters.

```python
from flex.tuning import GridSearch

param_grid = {
    'n_estimators': [100, 200, 300],
    'max_depth': [5, 10, 15]
}

search = GridSearch(model, param_grid, cv=5)
search.fit(X_train, y_train)
best_model = search.best_model_
```

**Parameters:**
- `model` (Model): Model to tune
- `param_grid` (dict): Parameter grid
- `cv` (int): Cross-validation folds

**Attributes:**
- `best_params_` (dict): Best parameters found
- `best_score_` (float): Best cross-validation score
- `best_model_` (Model): Model with best parameters

### flex.deployment

Model deployment utilities.

#### ModelServer

Serve models via REST API.

```python
from flex.deployment import ModelServer

server = ModelServer(model, host='0.0.0.0', port=8000)
server.start()
```

**Parameters:**
- `model` (Model): Model to serve
- `host` (str): Server host
- `port` (int): Server port

**Methods:**

##### start()

Start the server.

##### stop()

Stop the server.

#### Predictor

Make predictions with deployed model.

```python
from flex.deployment import Predictor

predictor = Predictor(endpoint='http://localhost:8000')
result = predictor.predict(data)
```

**Parameters:**
- `endpoint` (str): API endpoint URL

**Methods:**

##### predict(data)

Make prediction via API.

**Parameters:**
- `data` (dict): Input data

**Returns:** Prediction result

## Examples

### Complete Example

```python
from flex.data import DataLoader, DataPreprocessor
from flex.model import Classifier
from flex.pipeline import Pipeline
from flex.metrics import accuracy_score
from flex.tuning import GridSearch

# Load data
loader = DataLoader(source='data.csv')
data = loader.load()

X = data.drop('target', axis=1)
y = data['target']

# Create pipeline
pipeline = Pipeline([
    ('preprocessor', DataPreprocessor()),
    ('classifier', Classifier(algorithm='random_forest'))
])

# Tune hyperparameters
param_grid = {'classifier__n_estimators': [100, 200]}
search = GridSearch(pipeline, param_grid)
search.fit(X, y)

# Get best model
best_model = search.best_model_

# Make predictions
predictions = best_model.predict(X_test)

# Evaluate
accuracy = accuracy_score(y_test, predictions)
print(f"Accuracy: {accuracy:.2%}")
```

## Configuration

### Environment Variables

- `FLEX_DATA_DIR`: Default data directory
- `FLEX_MODEL_DIR`: Default model save directory
- `FLEX_LOG_LEVEL`: Logging level (DEBUG, INFO, WARNING, ERROR)
- `FLEX_CACHE_DIR`: Cache directory for temporary files

### Configuration File

Create `flex_config.yaml`:

```yaml
data:
  default_format: csv
  cache_enabled: true

model:
  default_algorithm: random_forest
  auto_save: true

deployment:
  host: 0.0.0.0
  port: 8000
  workers: 4
```

Load configuration:

```python
from flex.config import load_config

config = load_config('flex_config.yaml')
```

## Error Handling

### Common Exceptions

#### DataError

Raised when data loading or validation fails.

```python
from flex.exceptions import DataError

try:
    data = loader.load()
except DataError as e:
    print(f"Data error: {e}")
```

#### ModelError

Raised when model training or prediction fails.

```python
from flex.exceptions import ModelError

try:
    model.fit(X_train, y_train)
except ModelError as e:
    print(f"Model error: {e}")
```

#### DeploymentError

Raised when deployment fails.

```python
from flex.exceptions import DeploymentError

try:
    server.start()
except DeploymentError as e:
    print(f"Deployment error: {e}")
```

## Logging

Enable logging:

```python
import logging
from flex.utils import setup_logging

setup_logging(level=logging.INFO)
```

## Version Information

Check FLEX version:

```python
import flex
print(flex.__version__)
```

---

For more examples, see the [examples directory](../examples/).
