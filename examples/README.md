# Examples

This directory contains practical, hands-on examples demonstrating AI concepts in FLEX.

## Available Examples

### 1. Basic Classification
- **iris_classification.py**: Classic Iris dataset classification
- **image_classifier.py**: Simple image classification with CNNs
- **text_sentiment.py**: Sentiment analysis on text data

### 2. Regression Models
- **house_price_prediction.py**: Predicting house prices
- **sales_forecasting.py**: Time series sales forecasting
- **linear_regression_demo.py**: Basic linear regression example

### 3. Natural Language Processing
- **text_classification.py**: Multi-class text classification
- **named_entity_recognition.py**: NER with pre-trained models
- **text_generation.py**: Simple text generation model

### 4. Computer Vision
- **object_detection.py**: Detect objects in images
- **image_segmentation.py**: Semantic segmentation example
- **face_recognition.py**: Face detection and recognition

### 5. Time Series
- **stock_prediction.py**: Stock price prediction
- **anomaly_detection.py**: Anomaly detection in time series
- **weather_forecasting.py**: Weather data forecasting

## Running Examples

Each example includes:
- Detailed comments explaining the code
- Sample data or data loading instructions
- Expected output and visualizations
- Exercises to extend the example

### Prerequisites

```bash
pip install -r requirements.txt
```

### Basic Usage

```python
# Navigate to examples directory
cd examples

# Run any example
python basic_classification/iris_classification.py
```

## Contributing Examples

To contribute a new example:
1. Create a new directory or add to existing category
2. Include a README with explanation
3. Add sample data or data loading script
4. Document expected outputs
5. Follow the existing code style

## Example Template

Each example should follow this structure:

```python
"""
Example Title
=============

Description of what this example demonstrates.

Requirements:
- List required libraries
- List required data

Usage:
    python example_name.py
"""

# Imports
import necessary_libraries

# Load data
data = load_data()

# Preprocessing
processed_data = preprocess(data)

# Model training
model = train_model(processed_data)

# Evaluation
results = evaluate_model(model)

# Visualization
plot_results(results)
```

## Learning Path

1. Start with **basic_classification** examples
2. Move to **regression_models** for continuous outputs
3. Explore **nlp** for text-based applications
4. Try **computer_vision** for image tasks
5. Advanced: Work with **time_series** examples

## Support

If you encounter issues with any example:
- Check the example's README
- Verify all dependencies are installed
- Review the prerequisites
- Open an issue with details about the error
