"""
Classification Example with Multiple Models

This example demonstrates:
- Loading a dataset
- Data preprocessing
- Training multiple classifiers
- Comparing model performance
- Visualizing results
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
import seaborn as sns

# Set random seed
np.random.seed(42)

def generate_dataset(n_samples=1000, n_features=20):
    """
    Generate a synthetic classification dataset.
    
    Args:
        n_samples: Number of samples
        n_features: Number of features
        
    Returns:
        X: Features
        y: Labels
    """
    X, y = make_classification(
        n_samples=n_samples,
        n_features=n_features,
        n_informative=15,
        n_redundant=5,
        n_classes=2,
        random_state=42
    )
    return X, y

def prepare_data(X, y, test_size=0.2):
    """
    Split and scale the data.
    
    Args:
        X: Features
        y: Labels
        test_size: Fraction of data for testing
        
    Returns:
        X_train, X_test, y_train, y_test (scaled)
    """
    # Split the data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=test_size, random_state=42, stratify=y
    )
    
    # Scale the features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    return X_train_scaled, X_test_scaled, y_train, y_test, scaler

def train_models(X_train, y_train):
    """
    Train multiple classification models.
    
    Args:
        X_train: Training features
        y_train: Training labels
        
    Returns:
        Dictionary of trained models
    """
    models = {
        'Logistic Regression': LogisticRegression(random_state=42),
        'Decision Tree': DecisionTreeClassifier(random_state=42),
        'Random Forest': RandomForestClassifier(n_estimators=100, random_state=42)
    }
    
    trained_models = {}
    
    for name, model in models.items():
        print(f"Training {name}...")
        model.fit(X_train, y_train)
        trained_models[name] = model
    
    return trained_models

def evaluate_models(models, X_test, y_test):
    """
    Evaluate all models and return results.
    
    Args:
        models: Dictionary of trained models
        X_test: Test features
        y_test: Test labels
        
    Returns:
        DataFrame with results
    """
    results = []
    
    for name, model in models.items():
        y_pred = model.predict(X_test)
        accuracy = accuracy_score(y_test, y_pred)
        
        results.append({
            'Model': name,
            'Accuracy': accuracy,
            'Predictions': y_pred
        })
    
    return pd.DataFrame(results)

def plot_confusion_matrices(models, X_test, y_test):
    """
    Plot confusion matrices for all models.
    
    Args:
        models: Dictionary of trained models
        X_test: Test features
        y_test: Test labels
    """
    fig, axes = plt.subplots(1, 3, figsize=(15, 4))
    
    for idx, (name, model) in enumerate(models.items()):
        y_pred = model.predict(X_test)
        cm = confusion_matrix(y_test, y_pred)
        
        sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', ax=axes[idx])
        axes[idx].set_title(f'{name}\nAccuracy: {accuracy_score(y_test, y_pred):.3f}')
        axes[idx].set_ylabel('True Label')
        axes[idx].set_xlabel('Predicted Label')
    
    plt.tight_layout()
    plt.savefig('confusion_matrices.png')
    print("Confusion matrices saved as 'confusion_matrices.png'")
    plt.show()

def compare_models(results_df):
    """
    Create a comparison plot of model accuracies.
    
    Args:
        results_df: DataFrame with model results
    """
    plt.figure(figsize=(10, 6))
    
    models = results_df['Model'].values
    accuracies = results_df['Accuracy'].values
    
    bars = plt.bar(models, accuracies, color=['#1f77b4', '#ff7f0e', '#2ca02c'])
    
    # Add value labels on bars
    for bar in bars:
        height = bar.get_height()
        plt.text(bar.get_x() + bar.get_width()/2., height,
                f'{height:.3f}',
                ha='center', va='bottom')
    
    plt.ylabel('Accuracy')
    plt.title('Model Comparison')
    plt.ylim([0, 1.1])
    plt.grid(axis='y', alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('model_comparison.png')
    print("Model comparison saved as 'model_comparison.png'")
    plt.show()

def main():
    """Main function to run the classification example."""
    
    print("Classification Example with Multiple Models")
    print("=" * 60)
    
    # Generate dataset
    print("\n1. Generating synthetic dataset...")
    X, y = generate_dataset(n_samples=1000, n_features=20)
    print(f"   Dataset shape: {X.shape}")
    print(f"   Class distribution: {np.bincount(y)}")
    
    # Prepare data
    print("\n2. Preparing data (splitting and scaling)...")
    X_train, X_test, y_train, y_test, scaler = prepare_data(X, y)
    print(f"   Training samples: {len(X_train)}")
    print(f"   Testing samples: {len(X_test)}")
    
    # Train models
    print("\n3. Training multiple models...")
    models = train_models(X_train, y_train)
    print("   All models trained successfully!")
    
    # Evaluate models
    print("\n4. Evaluating models...")
    results = evaluate_models(models, X_test, y_test)
    print("\n   Model Results:")
    print(results[['Model', 'Accuracy']].to_string(index=False))
    
    # Detailed report for best model
    best_model_name = results.loc[results['Accuracy'].idxmax(), 'Model']
    best_model = models[best_model_name]
    y_pred_best = best_model.predict(X_test)
    
    print(f"\n5. Detailed report for best model ({best_model_name}):")
    print(classification_report(y_test, y_pred_best))
    
    # Visualizations
    print("\n6. Creating visualizations...")
    plot_confusion_matrices(models, X_test, y_test)
    compare_models(results)
    
    print("\n" + "=" * 60)
    print("Example completed successfully!")
    print("\nNext steps:")
    print("- Try different model parameters")
    print("- Add cross-validation")
    print("- Feature importance analysis")
    print("- Try on real-world datasets")

if __name__ == "__main__":
    main()
