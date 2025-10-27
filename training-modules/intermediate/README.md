# Intermediate Training Module

## Welcome to Intermediate Level Training!

This module builds on your beginner knowledge and introduces more advanced concepts and techniques.

## Module Overview

**Duration**: 4-5 weeks (20-25 hours)  
**Prerequisites**: Completed Beginner Module  
**Difficulty**: ⭐⭐ Intermediate

## Learning Objectives

By completing this module, you will:
- ✅ Master advanced preprocessing techniques
- ✅ Understand ensemble methods
- ✅ Implement cross-validation strategies
- ✅ Perform hyperparameter tuning
- ✅ Handle imbalanced datasets
- ✅ Work with different data types (text, images basics)
- ✅ Deploy models to production

## Module Structure

### Part 1: Advanced Techniques (2 weeks)

#### Week 1: Advanced Preprocessing
- Feature engineering strategies
- Handling imbalanced data
- Advanced feature selection
- Dimensionality reduction (PCA, t-SNE)

#### Week 2: Ensemble Methods
- Bagging (Random Forest)
- Boosting (XGBoost, LightGBM)
- Stacking
- Voting classifiers

### Part 2: Model Optimization (2 weeks)

#### Week 3: Cross-Validation & Tuning
- K-fold cross-validation
- Stratified sampling
- Grid search
- Random search
- Bayesian optimization

#### Week 4: Model Interpretation
- Feature importance
- SHAP values
- LIME
- Partial dependence plots

### Part 3: Specialized Topics (1 week)

#### Week 5: Production & Deployment
- Model serialization
- API development
- Monitoring and logging
- A/B testing basics

## Key Topics

### 1. Advanced Feature Engineering

**Creating Interaction Features**
```python
# Polynomial features
from sklearn.preprocessing import PolynomialFeatures

poly = PolynomialFeatures(degree=2, include_bias=False)
X_poly = poly.fit_transform(X)
```

**Domain-Specific Features**
- Date/time features
- Geospatial features
- Text features (TF-IDF, word embeddings)
- Binning and discretization

### 2. Handling Imbalanced Data

**Techniques**:
- Oversampling (SMOTE)
- Undersampling
- Class weights
- Ensemble methods
- Anomaly detection approaches

### 3. Ensemble Methods

**Random Forest**
- Bagging with decision trees
- Feature randomness
- Out-of-bag scoring

**Gradient Boosting**
- XGBoost
- LightGBM
- CatBoost

**Stacking**
- Combining multiple models
- Meta-learner concept

### 4. Hyperparameter Tuning

**Grid Search**
- Exhaustive search
- Cross-validation
- Best parameters

**Random Search**
- Random sampling
- Efficient exploration
- Good results with less computation

**Bayesian Optimization**
- Probabilistic model
- Acquisition function
- Efficient optimization

### 5. Model Interpretation

**Feature Importance**
- Tree-based importance
- Permutation importance
- Comparison across models

**SHAP (SHapley Additive exPlanations)**
- Individual predictions
- Feature contributions
- Visualization

**LIME (Local Interpretable Model-agnostic Explanations)**
- Local approximations
- Instance-level explanations
- Model-agnostic

## Practical Projects

### Project 1: Credit Risk Assessment
**Difficulty**: Medium  
**Skills**: Imbalanced data, ensemble methods, interpretation

Tasks:
- Handle highly imbalanced dataset
- Engineer financial features
- Build ensemble model
- Interpret predictions for business

### Project 2: Customer Segmentation
**Difficulty**: Medium  
**Skills**: Clustering, dimensionality reduction, visualization

Tasks:
- Perform exploratory analysis
- Apply PCA for visualization
- Implement K-means and DBSCAN
- Profile each segment

### Project 3: Text Classification
**Difficulty**: Medium  
**Skills**: NLP basics, feature extraction, classification

Tasks:
- Preprocess text data
- Extract TF-IDF features
- Build and compare classifiers
- Tune hyperparameters

### Project 4: Time Series Forecasting
**Difficulty**: Medium-Hard  
**Skills**: Time series, feature engineering, validation

Tasks:
- Create lag features
- Handle seasonality
- Build forecasting model
- Validate with proper splitting

## Advanced Exercises

### Exercise 1: Pipeline Construction
Build end-to-end scikit-learn pipelines with:
- Preprocessing steps
- Feature selection
- Model training
- Easy deployment

### Exercise 2: Custom Transformers
Create custom sklearn transformers for:
- Domain-specific preprocessing
- Feature engineering
- Integration with pipelines

### Exercise 3: Cross-Validation Strategies
Implement and compare:
- K-fold
- Stratified K-fold
- Time series split
- Group K-fold

### Exercise 4: Hyperparameter Tuning
Optimize models using:
- Grid search with cross-validation
- Random search
- Optuna for Bayesian optimization

## Model Deployment

### Creating APIs with Flask

```python
from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)
model = joblib.load('model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    prediction = model.predict([data['features']])
    return jsonify({'prediction': int(prediction[0])})

if __name__ == '__main__':
    app.run(debug=True)
```

### Docker Containerization

```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

### Monitoring

Key metrics to track:
- Prediction latency
- Throughput
- Error rates
- Model performance (accuracy, etc.)
- Data drift

## Best Practices

### Model Development
1. Start with a baseline model
2. Validate properly (avoid data leakage)
3. Document experiments
4. Version your models
5. Test edge cases

### Production Deployment
1. Separate train/serve code
2. Implement proper logging
3. Monitor performance
4. Have rollback plans
5. A/B test new models

### Code Quality
1. Write modular code
2. Add unit tests
3. Use type hints
4. Document functions
5. Follow PEP 8 style

## Learning Resources

### Books
- "Hands-On Machine Learning" by Aurélien Géron
- "Feature Engineering for Machine Learning" by Alice Zheng
- "Interpretable Machine Learning" by Christoph Molnar

### Online Courses
- Fast.ai: Practical Deep Learning for Coders
- Kaggle Learn: Intermediate ML
- Coursera: Advanced Machine Learning Specialization

### Tools to Learn
- XGBoost, LightGBM
- SHAP, LIME
- MLflow for experiment tracking
- Docker for deployment

## Assessment

### Knowledge Checks
- Weekly quizzes
- Code reviews
- Peer assessments

### Final Project
Build a complete ML solution:
1. Problem definition
2. Data analysis
3. Model development
4. Deployment (local)
5. Documentation

**Passing criteria**: 75% or higher

## Tips for Success

💡 **Experiment Actively**
- Try different approaches
- Compare results systematically
- Learn from failures

💡 **Think About Production**
- Consider real-world constraints
- Think about maintainability
- Plan for monitoring

💡 **Stay Current**
- Follow ML blogs and papers
- Participate in Kaggle competitions
- Join ML communities

💡 **Focus on Fundamentals**
- Understand the why, not just the how
- Know when to use which technique
- Develop intuition through practice

## Common Challenges

### "My ensemble model isn't better"
- Check for overfitting
- Ensure diversity in base models
- Validate properly

### "Hyperparameter tuning takes forever"
- Use random search first
- Limit search space intelligently
- Consider computational budget

### "I can't interpret my model"
- Start with simpler models for baseline
- Use interpretation tools (SHAP, LIME)
- Consider model-agnostic approaches

## Next Steps

After completing this module:

1. **Master**: Review complex topics
2. **Build**: Create portfolio projects
3. **Compete**: Try Kaggle competitions
4. **Advance**: Move to [Advanced Module](../advanced/)

## Module Checklist

- [ ] Complete all lessons and exercises
- [ ] Finish at least two projects
- [ ] Implement model deployment
- [ ] Pass final assessment
- [ ] Build a portfolio project

---

**Keep pushing your boundaries! You're becoming a skilled ML practitioner! 🎯**
