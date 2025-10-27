# Contributing to AI Training for FLEX

Thank you for your interest in contributing to the AI Training for FLEX repository! This document provides guidelines and instructions for contributing.

## Ways to Contribute

### 1. Report Issues
- Bug reports in examples or documentation
- Suggestions for new training modules
- Requests for additional examples
- Documentation improvements

### 2. Submit Content
- New training modules
- Code examples
- Exercises and quizzes
- Documentation updates

### 3. Improve Existing Content
- Fix typos and grammar
- Clarify explanations
- Update outdated information
- Add missing details

## Getting Started

### Prerequisites

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/AI_TRG_FLEX.git
   cd AI_TRG_FLEX
   ```
3. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

### Setting Up Development Environment

```bash
# Install dependencies
pip install -r requirements.txt

# Run tests (if available)
python -m pytest tests/
```

## Contribution Guidelines

### Code Examples

When contributing code examples:

1. **Follow Python Best Practices**
   - Use PEP 8 style guide
   - Include docstrings
   - Add type hints where appropriate
   - Keep functions focused and modular

2. **Documentation**
   - Add clear comments explaining the code
   - Include a README in the example directory
   - Document prerequisites and dependencies
   - Provide expected output examples

3. **Testing**
   - Ensure your code runs without errors
   - Test with different input scenarios
   - Include error handling
   - Verify output is as expected

### Training Modules

When adding new training modules:

1. **Structure**
   ```
   modules/XX-module-name/
   ├── README.md          # Module overview and learning objectives
   ├── lesson-1.md        # Individual lessons
   ├── lesson-2.md
   ├── exercises/         # Hands-on exercises
   └── resources/         # Additional materials
   ```

2. **Content Guidelines**
   - Clear learning objectives
   - Progressive difficulty
   - Practical examples
   - Exercises for practice
   - Links to additional resources

3. **Format**
   - Use Markdown for all documentation
   - Include code blocks with syntax highlighting
   - Add images/diagrams where helpful
   - Keep paragraphs concise

### Documentation

When updating documentation:

1. **Clarity**
   - Write in clear, simple language
   - Define technical terms
   - Use examples to illustrate concepts
   - Break complex topics into smaller sections

2. **Accuracy**
   - Verify all information is correct
   - Test all code snippets
   - Check links are valid
   - Update version numbers

3. **Consistency**
   - Follow existing formatting
   - Use consistent terminology
   - Maintain similar structure across documents

## Submission Process

### Pull Request Checklist

Before submitting a pull request:

- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] Documentation is updated
- [ ] Commit messages are clear
- [ ] Branch is up to date with main
- [ ] Changes are focused and minimal

### Pull Request Template

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Other (please describe)

## Testing
Describe how you tested your changes

## Checklist
- [ ] My code follows the project style guidelines
- [ ] I have commented my code where necessary
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix/feature works
```

## Code Review Process

1. **Submission**: Submit pull request with clear description
2. **Review**: Maintainers will review your contribution
3. **Feedback**: Address any requested changes
4. **Approval**: Once approved, changes will be merged
5. **Recognition**: Contributors will be acknowledged

## Style Guide

### Python Code

```python
# Good
def calculate_accuracy(predictions: np.ndarray, 
                       labels: np.ndarray) -> float:
    """
    Calculate classification accuracy.
    
    Args:
        predictions: Model predictions
        labels: Ground truth labels
    
    Returns:
        Accuracy score between 0 and 1
    """
    return np.mean(predictions == labels)

# Avoid
def calc_acc(p,l):
    return np.mean(p==l)
```

### Markdown Documentation

```markdown
# Good
## Section Title

Clear explanation with examples:

```python
# Example code with comments
model = Model()
model.train(data)
```

### Avoid
# section title
explanation
code without context
```

## Recognition

Contributors will be:
- Listed in the CONTRIBUTORS.md file
- Mentioned in release notes for significant contributions
- Acknowledged in the relevant module/example

## Questions?

If you have questions:
- Open an issue with the "question" label
- Reach out to maintainers
- Check existing issues for similar questions

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers
- Accept constructive criticism
- Focus on what's best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Personal or political attacks
- Publishing others' private information
- Other unprofessional conduct

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to AI Training for FLEX! 🎉
