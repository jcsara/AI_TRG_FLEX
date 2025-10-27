"""
Linear Regression Example
==========================

A simple linear regression example demonstrating prediction of continuous values.

Requirements:
- scikit-learn
- pandas
- matplotlib
- numpy

Usage:
    python linear_regression_demo.py
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error


def generate_sample_data(n_samples=100, noise=10, random_state=42):
    """Generate synthetic data for demonstration."""
    print("Generating synthetic data...")
    np.random.seed(random_state)
    
    # Generate features
    X = np.random.rand(n_samples, 1) * 100
    
    # Generate target with linear relationship + noise
    y = 2.5 * X.squeeze() + 15 + np.random.randn(n_samples) * noise
    
    print(f"Generated {n_samples} samples")
    return X, y


def prepare_data(X, y, test_size=0.2, random_state=42):
    """Split data into training and testing sets."""
    print("\nSplitting data...")
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=test_size, random_state=random_state
    )
    
    print(f"Training samples: {len(X_train)}")
    print(f"Testing samples: {len(X_test)}")
    
    return X_train, X_test, y_train, y_test


def train_model(X_train, y_train):
    """Train linear regression model."""
    print("\nTraining Linear Regression model...")
    model = LinearRegression()
    model.fit(X_train, y_train)
    
    print(f"Model coefficients: {model.coef_[0]:.4f}")
    print(f"Model intercept: {model.intercept_:.4f}")
    
    return model


def evaluate_model(model, X_test, y_test):
    """Evaluate the trained model."""
    print("\nEvaluating model...")
    y_pred = model.predict(X_test)
    
    mse = mean_squared_error(y_test, y_pred)
    rmse = np.sqrt(mse)
    mae = mean_absolute_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)
    
    print(f"Mean Squared Error: {mse:.4f}")
    print(f"Root Mean Squared Error: {rmse:.4f}")
    print(f"Mean Absolute Error: {mae:.4f}")
    print(f"R² Score: {r2:.4f}")
    
    return y_pred


def visualize_results(X_train, y_train, X_test, y_test, model):
    """Create visualization of the results."""
    fig, axes = plt.subplots(1, 2, figsize=(14, 5))
    
    # Plot 1: Training data with regression line
    axes[0].scatter(X_train, y_train, alpha=0.5, label='Training data')
    X_line = np.linspace(X_train.min(), X_train.max(), 100).reshape(-1, 1)
    y_line = model.predict(X_line)
    axes[0].plot(X_line, y_line, 'r-', linewidth=2, label='Regression line')
    axes[0].set_xlabel('Feature X')
    axes[0].set_ylabel('Target y')
    axes[0].set_title('Training Data with Regression Line')
    axes[0].legend()
    axes[0].grid(True, alpha=0.3)
    
    # Plot 2: Predictions vs Actual
    y_pred = model.predict(X_test)
    axes[1].scatter(y_test, y_pred, alpha=0.5)
    min_val = min(y_test.min(), y_pred.min())
    max_val = max(y_test.max(), y_pred.max())
    axes[1].plot([min_val, max_val], [min_val, max_val], 'r--', linewidth=2)
    axes[1].set_xlabel('Actual Values')
    axes[1].set_ylabel('Predicted Values')
    axes[1].set_title('Predictions vs Actual Values')
    axes[1].grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('linear_regression_results.png')
    print("\nVisualization saved as 'linear_regression_results.png'")


def plot_residuals(X_test, y_test, y_pred):
    """Plot residuals to check for patterns."""
    residuals = y_test - y_pred
    
    plt.figure(figsize=(10, 5))
    plt.scatter(y_pred, residuals, alpha=0.5)
    plt.axhline(y=0, color='r', linestyle='--', linewidth=2)
    plt.xlabel('Predicted Values')
    plt.ylabel('Residuals')
    plt.title('Residual Plot')
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('residual_plot.png')
    print("Residual plot saved as 'residual_plot.png'")


def main():
    """Main execution function."""
    print("=" * 60)
    print("Linear Regression Example")
    print("=" * 60)
    
    # Generate data
    X, y = generate_sample_data(n_samples=100, noise=10)
    
    # Prepare data
    X_train, X_test, y_train, y_test = prepare_data(X, y)
    
    # Train model
    model = train_model(X_train, y_train)
    
    # Evaluate
    y_pred = evaluate_model(model, X_test, y_test)
    
    # Visualize
    visualize_results(X_train, y_train, X_test, y_test, model)
    plot_residuals(X_test, y_test, y_pred)
    
    print("\n" + "=" * 60)
    print("Example completed successfully!")
    print("=" * 60)


if __name__ == "__main__":
    main()
