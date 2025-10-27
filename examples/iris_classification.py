"""
Iris Classification Example
============================

A simple classification example using the famous Iris dataset.
This demonstrates basic machine learning workflow in FLEX.

Requirements:
- scikit-learn
- pandas
- matplotlib

Usage:
    python iris_classification.py
"""

from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


def load_and_prepare_data():
    """Load the Iris dataset and prepare for training."""
    print("Loading Iris dataset...")
    iris = load_iris()
    X = pd.DataFrame(iris.data, columns=iris.feature_names)
    y = pd.Series(iris.target, name='species')
    
    print(f"Dataset shape: {X.shape}")
    print(f"\nFeatures:\n{X.head()}")
    print(f"\nTarget distribution:\n{y.value_counts()}")
    
    return X, y, iris.target_names


def preprocess_data(X, y, test_size=0.2, random_state=42):
    """Split and scale the data."""
    print("\nSplitting data into train and test sets...")
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=test_size, random_state=random_state, stratify=y
    )
    
    # Scale features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    print(f"Training set size: {len(X_train)}")
    print(f"Test set size: {len(X_test)}")
    
    return X_train_scaled, X_test_scaled, y_train, y_test, scaler


def train_model(X_train, y_train):
    """Train a Random Forest classifier."""
    print("\nTraining Random Forest classifier...")
    model = RandomForestClassifier(
        n_estimators=100,
        random_state=42,
        max_depth=5
    )
    model.fit(X_train, y_train)
    print("Training completed!")
    
    return model


def evaluate_model(model, X_test, y_test, target_names):
    """Evaluate the trained model."""
    print("\nEvaluating model...")
    y_pred = model.predict(X_test)
    
    accuracy = accuracy_score(y_test, y_pred)
    print(f"\nAccuracy: {accuracy:.4f}")
    
    print("\nClassification Report:")
    print(classification_report(y_test, y_pred, target_names=target_names))
    
    return y_pred


def plot_confusion_matrix(y_test, y_pred, target_names):
    """Plot confusion matrix."""
    cm = confusion_matrix(y_test, y_pred)
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues',
                xticklabels=target_names,
                yticklabels=target_names)
    plt.title('Confusion Matrix')
    plt.ylabel('True Label')
    plt.xlabel('Predicted Label')
    plt.tight_layout()
    plt.savefig('iris_confusion_matrix.png')
    print("\nConfusion matrix saved as 'iris_confusion_matrix.png'")


def plot_feature_importance(model, feature_names):
    """Plot feature importance."""
    importances = model.feature_importances_
    indices = importances.argsort()[::-1]
    
    plt.figure(figsize=(10, 6))
    plt.title('Feature Importance')
    plt.bar(range(len(importances)), importances[indices])
    plt.xticks(range(len(importances)), 
               [feature_names[i] for i in indices], 
               rotation=45, ha='right')
    plt.tight_layout()
    plt.savefig('iris_feature_importance.png')
    print("Feature importance plot saved as 'iris_feature_importance.png'")


def main():
    """Main execution function."""
    print("=" * 50)
    print("Iris Classification Example")
    print("=" * 50)
    
    # Load data
    X, y, target_names = load_and_prepare_data()
    
    # Preprocess
    X_train, X_test, y_train, y_test, scaler = preprocess_data(X, y)
    
    # Train
    model = train_model(X_train, y_train)
    
    # Evaluate
    y_pred = evaluate_model(model, X_test, y_test, target_names)
    
    # Visualize
    plot_confusion_matrix(y_test, y_pred, target_names)
    plot_feature_importance(model, X.columns)
    
    print("\n" + "=" * 50)
    print("Example completed successfully!")
    print("=" * 50)


if __name__ == "__main__":
    main()
