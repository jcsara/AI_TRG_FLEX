# Contributing to AI_TRG_FLEX

Thank you for your interest in contributing to AI_TRG_FLEX! We welcome contributions from everyone.

## How to Contribute

There are many ways to contribute:

1. **Improve Documentation**
   - Fix typos and grammatical errors
   - Clarify confusing sections
   - Add missing explanations
   - Translate content

2. **Add Training Materials**
   - Create new lessons
   - Develop exercises
   - Share projects
   - Add examples

3. **Report Issues**
   - Bug reports
   - Content errors
   - Improvement suggestions
   - Feature requests

4. **Code Contributions**
   - Fix bugs
   - Add features
   - Improve examples
   - Optimize code

## Getting Started

### 1. Fork the Repository

Click the "Fork" button at the top of the repository page.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR_USERNAME/AI_TRG_FLEX.git
cd AI_TRG_FLEX
```

### 3. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 4. Make Your Changes

Follow our style guides (see below).

### 5. Commit Your Changes

```bash
git add .
git commit -m "Description of your changes"
```

Use clear, descriptive commit messages:
- ✅ "Add exercise for linear regression"
- ✅ "Fix typo in getting started guide"
- ✅ "Update CNN example with comments"
- ❌ "Update"
- ❌ "Fix"

### 6. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 7. Create a Pull Request

Go to the original repository and click "New Pull Request".

## Contribution Guidelines

### Documentation

**Style**:
- Use clear, simple language
- Include code examples where helpful
- Add diagrams for complex concepts
- Break content into digestible sections

**Format**:
- Use Markdown formatting
- Include a table of contents for long documents
- Use code blocks with language specification
- Add links to related resources

**Structure**:
```markdown
# Title

## Overview
Brief introduction

## Main Content
Detailed information

## Examples
Practical code examples

## Next Steps
Where to go from here
```

### Code Examples

**Requirements**:
- Must be functional and tested
- Include comments explaining key concepts
- Follow PEP 8 style guide (Python)
- Include sample output

**Template**:
```python
"""
Brief description of what this example demonstrates.

Topics covered:
- Topic 1
- Topic 2
- Topic 3
"""

# Import statements
import numpy as np
import pandas as pd

# Constants
RANDOM_SEED = 42

def main():
    """Main function demonstrating the concept."""
    # Your code here
    pass

if __name__ == "__main__":
    main()
```

### Exercises

When creating exercises:
1. Clearly state the learning objective
2. Provide starter code
3. Include hints
4. Offer a solution (in separate file)
5. Specify estimated time to complete

**Exercise Template**:
```markdown
# Exercise: [Title]

## Objective
What you'll learn

## Instructions
Step-by-step tasks

## Starter Code
```python
# Your starter code
```

## Hints
- Hint 1
- Hint 2

## Solution
See `solutions/exercise_name.py`
```

### Projects

Project contributions should include:
- Clear problem statement
- Dataset description or link
- Evaluation criteria
- Starter template
- Example solution

## Style Guides

### Python Code Style

Follow PEP 8 with these specifics:

```python
# Good
def train_model(X_train, y_train, learning_rate=0.01):
    """
    Train a machine learning model.
    
    Args:
        X_train: Training features
        y_train: Training labels
        learning_rate: Learning rate for optimization
        
    Returns:
        Trained model
    """
    # Implementation
    pass

# Bad
def TrainModel(x,y,lr=0.01):
    # trains model
    pass
```

### Markdown Style

```markdown
# Main Title (H1) - One per document

## Section (H2)

### Subsection (H3)

Use **bold** for emphasis and `code` for inline code.

Lists:
- Item 1
- Item 2
  - Sub-item 2.1

Numbered lists:
1. First step
2. Second step

Code blocks:
​```python
print("Hello, World!")
​```
```

## Testing

Before submitting:

1. **Test all code**
   - Ensure it runs without errors
   - Verify expected output
   - Test edge cases

2. **Check links**
   - Verify all links work
   - Ensure relative paths are correct

3. **Review formatting**
   - Preview Markdown rendering
   - Check for typos
   - Ensure consistent style

## Review Process

1. **Automated Checks**
   - Code linting
   - Link validation
   - Format checking

2. **Peer Review**
   - Maintainer review
   - Community feedback
   - Suggested improvements

3. **Approval**
   - Changes requested (if needed)
   - Approval from maintainers
   - Merge into main branch

## Types of Contributions

### Priority Areas

We especially welcome contributions in:

1. **Beginner-Friendly Content**
   - Simple explanations
   - More examples
   - Additional exercises

2. **Real-World Projects**
   - Industry-relevant problems
   - End-to-end solutions
   - Best practices

3. **Advanced Topics**
   - Cutting-edge techniques
   - Research implementations
   - Performance optimization

4. **Accessibility**
   - Translations
   - Alternative formats
   - Simplified explanations

## Community Guidelines

### Be Respectful
- Welcome newcomers
- Be patient with questions
- Provide constructive feedback
- Respect different skill levels

### Be Helpful
- Answer questions when you can
- Share your knowledge
- Point to relevant resources
- Celebrate others' successes

### Be Professional
- Keep discussions on-topic
- Avoid off-topic debates
- Use appropriate language
- Maintain a positive tone

## Recognition

Contributors are recognized through:
- GitHub contributors page
- Acknowledgments in documentation
- Community spotlights
- Contributor badge

## Questions?

If you have questions about contributing:

1. Check existing issues and discussions
2. Review this guide again
3. Open a new issue with your question
4. Join our community chat

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

## Thank You!

Every contribution, no matter how small, helps make AI_TRG_FLEX better for everyone. Thank you for your support!

---

**Happy Contributing! 🎉**
