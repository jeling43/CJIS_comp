# Quick Start Guide

Get the CJIS Compliance Guidance Tool running in minutes!

## Prerequisites

- Git
- Flutter SDK 3.0.0 or higher
- Chrome, Firefox, Safari, or Edge browser

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/jeling43/CJIS_comp.git
cd CJIS_comp
```

### 2. Install Flutter (if not already installed)

#### macOS/Linux:
```bash
# Clone Flutter
git clone https://github.com/flutter/flutter.git -b stable ~/flutter

# Add to PATH (add to ~/.bashrc, ~/.zshrc, or ~/.profile)
export PATH="$PATH:$HOME/flutter/bin"

# Verify installation
flutter doctor
```

#### Windows:
1. Download Flutter from https://docs.flutter.dev/get-started/install/windows
2. Extract to `C:\src\flutter`
3. Add `C:\src\flutter\bin` to your PATH
4. Run `flutter doctor` in PowerShell

### 3. Install Project Dependencies

```bash
flutter pub get
```

### 4. Run the Application

```bash
flutter run -d chrome
```

The application will open in your default Chrome browser.

## Common Commands

### Development
```bash
# Run in Chrome
flutter run -d chrome

# Run with hot reload
flutter run -d chrome --hot

# Run on different device
flutter devices           # List available devices
flutter run -d <device-id>
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test
flutter test test/guidance_data_test.dart

# Run with coverage
flutter test --coverage
```

### Code Quality
```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Fix formatting
dart fix --apply
```

### Building
```bash
# Build for web (production)
flutter build web --release

# Output will be in build/web/
```

## Project Structure

```
CJIS_comp/
├── lib/
│   ├── main.dart              # App entry point
│   ├── app.dart               # App configuration & routing
│   ├── models/                # Data models
│   ├── screens/               # Screen widgets
│   ├── data/                  # Static data
│   └── widgets/               # Reusable components (future)
├── test/                      # Unit & widget tests
├── web/                       # Web-specific files
├── pubspec.yaml               # Dependencies
└── README.md                  # Documentation
```

## Quick Feature Tour

### 1. Disclaimer Screen
- First screen users see
- Explains tool purpose and limitations
- Click "I Understand - Continue" to proceed

### 2. Categories Screen
- Shows 6 CJIS compliance categories
- Click any category to view details

### 3. Category Detail
- Shows category information
- Lists key points
- "Start Guided Assessment" button (for some categories)

### 4. Guided Assessment
- Answer questions
- Receive tailored guidance
- Get risk areas and recommendations

## Troubleshooting

### "Flutter command not found"
```bash
# Ensure Flutter is in your PATH
echo $PATH | grep flutter

# If not, add Flutter to PATH
export PATH="$PATH:$HOME/flutter/bin"
```

### "Pub get failed"
```bash
# Clear cache and retry
flutter clean
flutter pub get
```

### "Cannot run on Chrome"
```bash
# Check if Chrome is available
flutter devices

# If not listed, install Chrome or use different browser
flutter run -d edge
flutter run -d firefox
```

### Tests failing
```bash
# Clean and re-run
flutter clean
flutter pub get
flutter test
```

## Next Steps

1. **Explore the code**: Start with `lib/main.dart` and `lib/app.dart`
2. **Add content**: Edit `lib/data/guidance_data.dart` to add more questions
3. **Customize UI**: Modify screen files in `lib/screens/`
4. **Add tests**: Create tests in `test/` directory
5. **Read docs**: Check out [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines

## Getting Help

- **Documentation**: See [README.md](README.md) for full documentation
- **Deployment**: See [DEPLOYMENT.md](DEPLOYMENT.md) for deployment options
- **Testing**: See [TESTING.md](TESTING.md) for testing guide
- **UI Design**: See [UI_DESIGN.md](UI_DESIGN.md) for design specs
- **Issues**: Open an issue on GitHub
- **Flutter docs**: https://docs.flutter.dev

## Development Tips

### Hot Reload
While running with `flutter run`, press:
- `r` - Hot reload (fast)
- `R` - Hot restart (slower, full restart)
- `q` - Quit

### Debugging
```bash
# Run in debug mode (default)
flutter run -d chrome

# Enable verbose logging
flutter run -d chrome --verbose

# Check for issues
flutter doctor -v
```

### Performance
```bash
# Run in profile mode
flutter run -d chrome --profile

# Run in release mode (best performance)
flutter run -d chrome --release
```

## Contributing

Want to contribute? Great! Check out [CONTRIBUTING.md](CONTRIBUTING.md) for:
- How to submit changes
- Code style guidelines
- Testing requirements
- Content guidelines

## License

[Add license information here]

---

**Ready to start?** Run `flutter run -d chrome` and explore! 🚀
