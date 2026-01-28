# Contributing to CJIS Compliance Guidance Tool

Thank you for your interest in contributing to the CJIS Compliance Guidance Tool!

## Purpose

This tool provides guidance to law enforcement agencies on CJIS Security Policy requirements. Contributions should focus on:
- Improving clarity and accuracy of guidance
- Enhancing user experience
- Adding more guidance categories and questions
- Fixing bugs and improving code quality

## What We're Looking For

### Content Contributions
- Additional guidance questions for existing categories
- New guidance categories (with approval)
- Updated CJIS policy references
- Improved explanations and recommendations
- Corrections to existing content

### Technical Contributions
- Bug fixes
- UI/UX improvements
- Performance enhancements
- Accessibility improvements
- Test coverage improvements
- Documentation updates

## What to Avoid

Please do NOT contribute:
- Compliance scoring or grading systems
- User authentication or data storage features
- Official assessment or audit capabilities
- Features that would store CJIS data
- Anything that contradicts the "guidance only" disclaimer

## Getting Started

1. **Fork the repository**
2. **Clone your fork**
   ```bash
   git clone https://github.com/your-username/CJIS_comp.git
   cd CJIS_comp
   ```
3. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **Make your changes**
5. **Test your changes**
   ```bash
   flutter test
   flutter run -d chrome
   ```
6. **Commit your changes**
   ```bash
   git commit -m "Description of changes"
   ```
7. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
8. **Create a Pull Request**

## Development Setup

See [README.md](README.md) for installation instructions.

## Code Standards

### Dart/Flutter
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` before committing
- Run `flutter analyze` and fix any issues
- Add tests for new features
- Maintain existing test coverage

### Commit Messages
- Use clear, descriptive commit messages
- Start with a verb (Add, Fix, Update, etc.)
- Reference issue numbers when applicable

Example:
```
Add authentication MFA guidance questions

- Added 2 new questions for MFA category
- Included recommendations for various MFA methods
- Referenced CJIS Policy Section 5.6

Fixes #123
```

## Testing Requirements

All contributions should include:
- Unit tests for data models and business logic
- Widget tests for UI components
- Manual testing on at least Chrome and Firefox
- Verification that all existing tests still pass

Run tests:
```bash
flutter test
```

## Pull Request Process

1. **Update documentation** if you've changed functionality
2. **Add tests** for new features
3. **Ensure all tests pass** before submitting
4. **Update README.md** if needed
5. **Describe your changes** clearly in the PR description
6. **Link to related issues** if applicable

### PR Checklist
- [ ] Code follows project style guidelines
- [ ] Tests added/updated and passing
- [ ] Documentation updated
- [ ] No console errors or warnings
- [ ] Tested on multiple browsers
- [ ] Respects the "guidance only" principle

## Adding Guidance Content

When adding new guidance content:

1. **Review CJIS Security Policy** for accurate information
2. **Use plain language** suitable for non-technical audiences
3. **Include policy references** (e.g., "CJIS Security Policy Section 5.2")
4. **Provide actionable recommendations**
5. **Avoid absolute compliance claims**

### Content Structure

Questions should:
- Be clear and unambiguous
- Offer 2-4 answer options
- Lead to specific guidance or another question
- Include policy references

Results should:
- Explain the situation in plain language
- List specific risk areas (if applicable)
- Provide concrete recommendations
- Reference relevant CJIS policy sections

Example:
```dart
const GuidanceQuestion(
  id: 'category_q1',
  question: 'Clear, specific question?',
  options: [
    AnswerOption(
      text: 'Option 1',
      nextQuestionId: 'category_q2',
    ),
    AnswerOption(
      text: 'Option 2',
      result: GuidanceResult(
        title: 'Result Title',
        description: 'Plain-language explanation.',
        riskAreas: ['Risk 1', 'Risk 2'],
        recommendations: [
          'Action 1',
          'Action 2',
        ],
        policyReference: 'CJIS Security Policy Section X.Y',
      ),
    ),
  ],
),
```

## Reporting Bugs

Use GitHub Issues to report bugs. Include:
- Description of the bug
- Steps to reproduce
- Expected behavior
- Actual behavior
- Browser and version
- Screenshots (if applicable)

## Feature Requests

Feature requests are welcome! Please:
- Check existing issues first
- Describe the feature clearly
- Explain the use case
- Consider if it aligns with the "guidance only" principle

## Questions?

If you have questions about contributing:
- Open a GitHub Discussion
- Comment on related issues
- Contact maintainers

## Code of Conduct

Be respectful and professional. This tool serves law enforcement agencies, and we maintain appropriate standards.

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

Thank you for helping improve the CJIS Compliance Guidance Tool!
