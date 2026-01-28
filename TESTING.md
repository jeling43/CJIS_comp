# Testing Guide for CJIS Compliance Guidance Tool

## Overview

This document describes how to test the CJIS Compliance Guidance Tool.

## Unit and Widget Tests

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/guidance_data_test.dart

# Run tests in verbose mode
flutter test --verbose
```

### Test Structure

The test suite includes:

1. **Data Model Tests** (`guidance_data_test.dart`)
   - Validates guidance data structure
   - Ensures all categories have required fields
   - Verifies questions and answer options
   - Tests data retrieval functions

2. **Widget Tests** (`*_screen_test.dart`)
   - Tests UI components render correctly
   - Validates navigation flows
   - Ensures user interactions work

### Coverage Goals

- Data models: 100%
- Business logic: >90%
- Widget tests: >80%
- Overall: >85%

## Manual Testing

### Test Scenarios

#### Scenario 1: First-Time User Flow
1. Launch application
2. Read disclaimer page
3. Click "I Understand - Continue"
4. Verify navigation to categories screen
5. Verify all 6 categories are displayed

**Expected Result**: User successfully navigates from disclaimer to categories

#### Scenario 2: Category Exploration
1. From categories screen, click "Access Control"
2. Verify category details display:
   - Category icon and title
   - Description
   - Key points (4 items)
   - Policy reference
   - "Start Guided Assessment" button
3. Click "Back to Categories"

**Expected Result**: Category information displays correctly and navigation works

#### Scenario 3: Guided Assessment Flow
1. Navigate to "Access Control" category
2. Click "Start Guided Assessment"
3. Answer first question: "No documentation"
4. Verify result screen displays:
   - Result title
   - Assessment description
   - Risk areas
   - Recommendations
   - Policy reference
5. Click "Start Over"
6. Verify returns to first question

**Expected Result**: Question flow works, results display correctly

#### Scenario 4: Multi-Question Flow
1. Navigate to "Authentication and MFA" category
2. Click "Start Guided Assessment"
3. Answer: "Yes, for all users"
4. Verify moves to second question
5. Answer: "Hardware tokens or biometrics"
6. Verify results display

**Expected Result**: Multi-question flow navigates correctly

#### Scenario 5: Back Navigation
1. From any screen, use browser back button
2. Verify navigation works correctly
3. Test "Back to Category" buttons
4. Test "Return to All Categories" link

**Expected Result**: All navigation methods work correctly

#### Scenario 6: Responsive Design
1. Test on desktop (1920x1080)
   - Verify 3-column grid on categories screen
   - Check text readability
2. Test on tablet (1024x768)
   - Verify 2-column grid
3. Test on small screen (800x600)
   - Verify single column layout

**Expected Result**: Layout adapts appropriately to screen size

## Browser Compatibility Testing

Test on the following browsers:

### Chrome/Chromium
- [ ] Version 90+
- [ ] All features work
- [ ] No console errors

### Firefox
- [ ] Version 88+
- [ ] All features work
- [ ] No console errors

### Safari
- [ ] Version 14+ (macOS)
- [ ] All features work
- [ ] No console errors

### Edge
- [ ] Version 90+ (Chromium-based)
- [ ] All features work
- [ ] No console errors

## Accessibility Testing

### Keyboard Navigation
- [ ] Tab through all interactive elements
- [ ] Enter/Space activates buttons
- [ ] Escape closes modals (if any)
- [ ] Focus indicators visible

### Screen Reader Testing
- [ ] Test with NVDA (Windows)
- [ ] Test with VoiceOver (macOS)
- [ ] All content is readable
- [ ] Navigation is logical

### Color Contrast
- [ ] Text meets WCAG AA standards (4.5:1)
- [ ] Icons have sufficient contrast
- [ ] Error messages are distinguishable

## Performance Testing

### Load Time
- [ ] Initial load < 3 seconds
- [ ] Navigation between screens < 200ms
- [ ] No layout shifts during load

### Memory Usage
- [ ] Monitor browser DevTools
- [ ] No memory leaks during navigation
- [ ] Reasonable memory footprint

## Security Testing

### Data Privacy
- [ ] No data sent to external servers
- [ ] No cookies set
- [ ] No localStorage used
- [ ] No sessionStorage used

### Console Security
- [ ] No sensitive data in console logs
- [ ] No error stack traces with sensitive info
- [ ] No API keys or secrets exposed

## Regression Testing Checklist

Before each release, verify:

- [ ] All unit tests pass
- [ ] All widget tests pass
- [ ] Disclaimer screen displays correctly
- [ ] All 6 categories display
- [ ] Category detail screens work
- [ ] Guided assessments work for Access Control
- [ ] Guided assessments work for Authentication/MFA
- [ ] All navigation paths work
- [ ] Responsive design works on all sizes
- [ ] Works on Chrome, Firefox, Safari, Edge
- [ ] No console errors
- [ ] README is up to date
- [ ] DEPLOYMENT.md is accurate

## Test Data

### Test Categories

The application includes test data for:
1. Access Control (2 questions)
2. Authentication and MFA (2 questions)
3. Data Storage and Encryption (no questions yet)
4. User Roles and Least Privilege (no questions yet)
5. Cloud and Vendor Considerations (no questions yet)
6. Training and Personnel Security (no questions yet)

### Adding Test Data

To add more test questions:

1. Edit `lib/data/guidance_data.dart`
2. Add questions to `categoryQuestions` map
3. Follow existing question structure
4. Include appropriate results
5. Run tests to verify
6. Test manually in UI

## Troubleshooting Tests

### Tests Fail to Run
```bash
flutter clean
flutter pub get
flutter test
```

### Widget Test Fails
- Check that widgets are properly wrapped in MaterialApp
- Ensure all routes are defined
- Use `pumpAndSettle()` after navigation

### Test Coverage Not Generating
```bash
# Install lcov
sudo apt-get install lcov

# Generate coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html

# View coverage
open coverage/html/index.html
```

## Continuous Integration

### GitHub Actions (Example)

```yaml
name: Test

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - run: flutter analyze
```

## Reporting Issues

When reporting bugs, include:
1. Steps to reproduce
2. Expected behavior
3. Actual behavior
4. Browser and version
5. Screenshots (if applicable)
6. Console errors (if any)

## Test Maintenance

- Review and update tests with each feature addition
- Remove obsolete tests
- Keep test data realistic and current
- Update this guide as testing procedures evolve
