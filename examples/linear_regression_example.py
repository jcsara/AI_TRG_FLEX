"""
Simple Linear Regression Example

This example demonstrates:
- Creating synthetic data
- Training a linear regression model
- Making predictions
- Visualizing results
"""

import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

# Set random seed for reproducibility
np.random.seed(42)

def generate_data(n_samples=100):
    """
    Generate synthetic data for linear regression.
    
    Args:
        n_samples: Number of samples to generate
        
    Returns:
        X: Features (2D array)
        y: Target values (1D array)
    """
    # Generate feature values
    X = np.random.rand(n_samples, 1) * 10
    
    # Generate target values with linear relationship and noise
    # y = 3*X + 5 + noise
    y = 3 * X + 5 + np.random.randn(n_samples, 1) * 2
    
    return X, y.ravel()

def train_model(X, y):
    """
    Train a linear regression model.
    
    Args:
        X: Training features
        y: Training labels
        
    Returns:
        Trained model
    """
    model = LinearRegression()
    model.fit(X, y)
    return model

def evaluate_model(model, X, y):
    """
    Evaluate model performance.
    
    Args:
        model: Trained model
        X: Features
        y: True labels
        
    Returns:
        Dictionary with metrics
    """
    y_pred = model.predict(X)
    
    mse = mean_squared_error(y, y_pred)
    rmse = np.sqrt(mse)
    r2 = r2_score(y, y_pred)
    
    return {
        'mse': mse,
        'rmse': rmse,
        'r2': r2,
        'predictions': y_pred
    }

def visualize_results(X, y, y_pred, model):
    """
    Visualize the data and regression line.
    
    Args:
        X: Features
        y: True labels
        y_pred: Predicted labels
        model: Trained model
    """
    plt.figure(figsize=(10, 6))
    
    # Scatter plot of actual data
    plt.scatter(X, y, alpha=0.5, label='Actual Data')
    
    # Plot regression line
    X_line = np.linspace(X.min(), X.max(), 100).reshape(-1, 1)
    y_line = model.predict(X_line)
    plt.plot(X_line, y_line, 'r-', linewidth=2, label='Regression Line')
    
    plt.xlabel('Feature (X)')
    plt.ylabel('Target (y)')
    plt.title('Linear Regression Example')
    plt.legend()
    plt.grid(True, alpha=0.3)
    
    # Save the plot
    plt.savefig('linear_regression_example.png')
    print("Plot saved as 'linear_regression_example.png'")
    
    plt.show()

def main():
    """Main function to run the linear regression example."""
    
    print("Linear Regression Example")
    print("=" * 50)
    
    # Generate data
    print("\n1. Generating synthetic data...")
    X, y = generate_data(n_samples=100)
    print(f"   Generated {len(X)} samples")
    
    # Train model
    print("\n2. Training linear regression model...")
    model = train_model(X, y)
    print("   Model trained successfully!")
    print(f"   Coefficients: {model.coef_[0]:.2f}")
    print(f"   Intercept: {model.intercept_:.2f}")
    
    # Evaluate model
    print("\n3. Evaluating model performance...")
    metrics = evaluate_model(model, X, y)
    print(f"   Mean Squared Error: {metrics['mse']:.2f}")
    print(f"   Root Mean Squared Error: {metrics['rmse']:.2f}")
    print(f"   R² Score: {metrics['r2']:.4f}")
    
    # Make predictions on new data
    print("\n4. Making predictions on new data...")
    X_new = np.array([[2.5], [5.0], [7.5]])
    y_new_pred = model.predict(X_new)
    
    print("   New predictions:")
    for i, (x, y_pred) in enumerate(zip(X_new, y_new_pred)):
        print(f"   X = {x[0]:.1f} → Predicted y = {y_pred:.2f}")
    
    # Visualize
    print("\n5. Creating visualization...")
    visualize_results(X, y, metrics['predictions'], model)
    
    print("\n" + "=" * 50)
    print("Example completed successfully!")
    print("\nNext steps:")
    print("- Try different sample sizes")
    print("- Add more features (multiple regression)")
    print("- Experiment with polynomial features")
    print("- Compare with other regression models")

if __name__ == "__main__":
    main()
