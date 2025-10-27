# Data Management

## Managing Data in AI_TRG_FLEX

Effective data management is crucial for successful AI projects. This guide covers best practices for handling data throughout the machine learning lifecycle.

## Data Lifecycle

```
Collection → Storage → Processing → Analysis → Modeling → Deployment → Monitoring
     ↑                                                                      ↓
     └──────────────────────── Feedback Loop ────────────────────────────┘
```

## Data Collection

### Sources

**Structured Data**
- Relational databases
- CSV/Excel files
- APIs
- Data warehouses

**Unstructured Data**
- Text documents
- Images
- Audio/Video
- Sensor data

**Semi-structured Data**
- JSON
- XML
- Log files
- NoSQL databases

### Collection Best Practices

1. **Define Clear Requirements**
   - What data do you need?
   - How much data is sufficient?
   - What quality is required?
   - What are the constraints?

2. **Ensure Data Quality**
   - Accuracy
   - Completeness
   - Consistency
   - Timeliness
   - Validity

3. **Document Data Sources**
   - Source system
   - Collection method
   - Update frequency
   - Data owner
   - Access permissions

## Data Storage

### Storage Options

**Data Lake**
- Store raw, unprocessed data
- Scalable and cost-effective
- Multiple data formats
- Schema-on-read

**Data Warehouse**
- Structured, processed data
- Optimized for queries
- Schema-on-write
- Business intelligence

**Feature Store**
- ML-specific features
- Training and serving
- Feature versioning
- Sharing across teams

### Storage Strategies

```python
# Example directory structure
data/
├── raw/              # Original, immutable data
│   ├── source_1/
│   └── source_2/
├── interim/          # Intermediate processing
│   ├── cleaned/
│   └── transformed/
├── processed/        # Final, analysis-ready data
│   ├── train/
│   ├── validation/
│   └── test/
└── external/         # Third-party data
```

## Data Processing

### Data Cleaning

**Handle Missing Values**
```python
# Strategies
- Remove rows/columns
- Impute with mean/median/mode
- Use advanced imputation (KNN, regression)
- Forward/backward fill for time series
```

**Remove Duplicates**
```python
# Check for duplicates
df.duplicated().sum()

# Remove duplicates
df.drop_duplicates(inplace=True)
```

**Handle Outliers**
```python
# Detection methods
- Statistical (z-score, IQR)
- Visual (box plots, scatter plots)
- Domain knowledge

# Treatment
- Remove
- Cap/floor
- Transform
- Keep (if valid)
```

### Data Transformation

**Normalization**
- Scale features to [0, 1]
- Useful for distance-based algorithms

```python
from sklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()
normalized_data = scaler.fit_transform(data)
```

**Standardization**
- Mean = 0, Std = 1
- Useful for most ML algorithms

```python
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
standardized_data = scaler.fit_transform(data)
```

**Encoding Categorical Variables**

```python
# One-Hot Encoding
pd.get_dummies(df, columns=['category'])

# Label Encoding
from sklearn.preprocessing import LabelEncoder
le = LabelEncoder()
df['category_encoded'] = le.fit_transform(df['category'])

# Target Encoding
# For high-cardinality features
```

### Feature Engineering

**Creating New Features**
- Domain-specific features
- Interaction terms
- Polynomial features
- Aggregations
- Time-based features

**Feature Selection**
- Remove low variance features
- Correlation analysis
- Recursive feature elimination
- Feature importance from models
- Domain knowledge

## Data Validation

### Schema Validation

```python
# Example schema definition
schema = {
    'age': {'type': 'int', 'min': 0, 'max': 120},
    'income': {'type': 'float', 'min': 0},
    'category': {'type': 'str', 'allowed': ['A', 'B', 'C']},
    'date': {'type': 'datetime'}
}
```

### Data Quality Checks

**Completeness**
- Check for missing values
- Verify required fields
- Validate date ranges

**Accuracy**
- Range checks
- Format validation
- Cross-field validation

**Consistency**
- Referential integrity
- Business rule validation
- Temporal consistency

### Drift Detection

**Data Drift**
- Distribution changes in input features
- Monitor statistical properties
- Alert on significant changes

**Concept Drift**
- Changes in relationship between features and target
- Monitor model performance
- Retrain when needed

## Data Versioning

### Why Version Data?

- Reproducibility
- Debugging
- Compliance
- Collaboration
- Rollback capability

### Versioning Strategies

**Git-based (DVC, Git LFS)**
```bash
# Initialize DVC
dvc init

# Track data file
dvc add data/raw/dataset.csv

# Commit changes
git add data/raw/dataset.csv.dvc
git commit -m "Add dataset v1.0"
```

**Metadata Tracking**
```python
# Example metadata
{
    'version': '1.0.0',
    'created': '2023-01-15',
    'source': 'production_db',
    'rows': 100000,
    'columns': 50,
    'schema_version': '2.1',
    'quality_score': 0.95
}
```

## Data Privacy and Security

### Privacy Considerations

**Personal Identifiable Information (PII)**
- Identify PII fields
- Apply anonymization
- Use pseudonymization
- Implement access controls

**Compliance**
- GDPR
- CCPA
- HIPAA
- Industry-specific regulations

### Security Best Practices

1. **Encryption**
   - At rest
   - In transit
   - Key management

2. **Access Control**
   - Role-based access
   - Least privilege principle
   - Audit logging

3. **Data Masking**
   - Mask sensitive fields
   - Dynamic masking for different users
   - Preserve data utility

## Data Pipeline

### Pipeline Architecture

```
Source → Extract → Transform → Validate → Load → Store
   ↓         ↓          ↓          ↓        ↓       ↓
 Monitor  Monitor   Monitor    Monitor  Monitor Monitor
```

### Pipeline Best Practices

1. **Idempotency**
   - Rerunning produces same result
   - Safe to retry
   - No side effects

2. **Error Handling**
   - Graceful failures
   - Dead letter queues
   - Retry mechanisms
   - Alerting

3. **Monitoring**
   - Data volume
   - Processing time
   - Error rates
   - Data quality metrics

### Example Pipeline

```python
def data_pipeline(source_path, output_path):
    """
    Complete data processing pipeline
    """
    # Extract
    raw_data = extract_data(source_path)
    log_metric('raw_records', len(raw_data))
    
    # Validate
    valid_data = validate_schema(raw_data)
    log_metric('valid_records', len(valid_data))
    
    # Transform
    cleaned_data = clean_data(valid_data)
    features = engineer_features(cleaned_data)
    
    # Quality checks
    quality_score = assess_quality(features)
    assert quality_score > 0.9, "Data quality below threshold"
    
    # Load
    save_data(features, output_path)
    log_metric('processed_records', len(features))
    
    return features
```

## Best Practices Summary

✅ **Document Everything**
- Data sources
- Transformations
- Quality checks
- Decisions made

✅ **Automate Pipelines**
- Reduce manual errors
- Ensure consistency
- Enable scaling
- Save time

✅ **Monitor Continuously**
- Data quality
- Pipeline health
- Performance metrics
- Anomalies

✅ **Version Control**
- Data versions
- Code versions
- Model versions
- Configuration

✅ **Test Thoroughly**
- Unit tests for transforms
- Integration tests for pipelines
- Data quality tests
- End-to-end tests

## Common Pitfalls

❌ **Data Leakage**
- Using future information
- Including target in features
- Improper train/test split

❌ **Insufficient Data Quality**
- Not cleaning data
- Ignoring outliers
- Missing value issues

❌ **Poor Documentation**
- Unknown data sources
- Undocumented transformations
- Lost tribal knowledge

❌ **Ignoring Data Drift**
- Not monitoring changes
- Not retraining models
- Degrading performance

## Tools and Technologies

### Data Processing
- Pandas, Polars
- Apache Spark
- Dask
- Vaex

### Data Validation
- Great Expectations
- Pandera
- TensorFlow Data Validation

### Data Versioning
- DVC
- Pachyderm
- Delta Lake

### Workflow Orchestration
- Apache Airflow
- Prefect
- Dagster
- Luigi

## Next Steps

Continue your learning:
1. [Explore Training Modules](../../training-modules/beginner/)
2. [Review Code Examples](../../examples/)
3. [Practice with Exercises](../../exercises/)

---

**Good data management is the foundation of successful AI! 📊**
