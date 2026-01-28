# CJIS Compliance Guidance Tool

A web-based guidance and decision-support tool built with Flutter to help small to mid-sized law enforcement agencies interpret CJIS Security Policy requirements and understand common cybersecurity risks and best practices.

## Important Disclaimer

This application is a **guidance and decision-support tool only**. It is NOT an auditing, certification, or compliance enforcement system. It does not generate official compliance assessments or reports.

## Features

- **Home/Disclaimer Page**: Clear explanation of the tool's purpose, audience, and limitations
- **Guidance Categories**: Six key CJIS compliance areas:
  - Access Control
  - Authentication and MFA
  - Data Storage and Encryption
  - User Roles and Least Privilege
  - Cloud and Vendor Considerations
  - Training and Personnel Security
- **Decision-Guided Navigation**: Question-based flow with tailored guidance
- **Risk-Oriented Output**: Plain-language explanations with CJIS policy references
- **Responsive Design**: Works on desktop and tablet devices

## Technical Details

- **Framework**: Flutter (Dart)
- **Platform**: Web (frontend-only)
- **State Management**: Local in-memory state
- **No Backend**: All processing happens client-side
- **No Data Storage**: No user authentication, no data logging, no CJIS data storage

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Web browser (Chrome, Firefox, Safari, or Edge)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/jeling43/CJIS_comp.git
   cd CJIS_comp
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run -d chrome
   ```

### Building for Production

To build the web application for production:

```bash
flutter build web
```

The output will be in the `build/web` directory.

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── app.dart                  # Main app configuration and routing
├── models/                   # Data models
│   └── guidance_models.dart
├── data/                     # Static data and content
│   └── guidance_data.dart
├── screens/                  # Screen widgets
│   ├── disclaimer_screen.dart
│   ├── categories_screen.dart
│   ├── category_detail_screen.dart
│   └── guidance_flow_screen.dart
└── widgets/                  # Reusable UI components (future)
```

## Usage

1. **Read the Disclaimer**: The app starts with an important disclaimer explaining its purpose and limitations
2. **Select a Category**: Choose from six CJIS compliance categories
3. **Review Guidance**: Read key points and policy references for each category
4. **Take Assessment**: Answer guided questions to receive tailored recommendations
5. **Review Results**: Get plain-language guidance on potential risks and best practices

## Explicit Non-Goals

This tool does NOT:
- Upload or analyze evidence
- Accept CJIS data input
- Provide compliance scoring or grading
- Generate audit readiness reports
- Store any information between sessions
- Require user authentication

## Contributing

This is a guidance tool for law enforcement agencies. Contributions should focus on improving clarity, accuracy of guidance, and user experience.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Important**: This software is a guidance tool only and does not constitute official CJIS compliance certification.

## Contact

For questions about CJIS compliance, contact your state's CJIS Systems Officer (CSO) or the FBI CJIS Division.
