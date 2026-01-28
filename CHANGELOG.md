# Changelog

All notable changes to the CJIS Compliance Guidance Tool will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-28

### Added
- Initial release of CJIS Compliance Guidance Tool
- Home/Disclaimer page with clear explanations of tool purpose and limitations
- Six guidance categories:
  - Access Control
  - Authentication and MFA
  - Data Storage and Encryption
  - User Roles and Least Privilege
  - Cloud and Vendor Considerations
  - Training and Personnel Security
- Decision-guided navigation with question/answer flows
- Guided assessments for:
  - Access Control (2 questions)
  - Authentication and MFA (2 questions)
- Risk-oriented output with plain-language explanations
- CJIS policy references for all guidance
- Best practice recommendations
- Responsive design for desktop and tablet
- Material Design 3 UI with professional styling
- Complete test suite (unit and widget tests)
- Comprehensive documentation:
  - README.md - Project overview
  - QUICKSTART.md - Quick start guide
  - DEPLOYMENT.md - Deployment instructions
  - TESTING.md - Testing guide
  - CONTRIBUTING.md - Contribution guidelines
  - UI_DESIGN.md - UI/UX specifications
- GitHub Actions CI/CD pipeline
- MIT License

### Technical Details
- Built with Flutter 3.0+ and Dart
- Web-only (no backend required)
- Frontend-only with local state management
- No user authentication or data storage
- No CJIS data logging or persistence

### Non-Goals (Intentionally Not Included)
- User authentication
- Data storage or persistence
- Compliance scoring or grading
- Official audit reports
- CJIS data input or handling
- Evidence upload or analysis

## [Unreleased]

### Planned
- Additional guidance questions for remaining categories
- More detailed risk assessments
- Enhanced responsive design for mobile devices
- Accessibility improvements
- Additional test coverage
- More comprehensive CJIS policy references

### Under Consideration
- Print-friendly version of guidance results
- Dark mode support
- Multi-language support (Spanish, etc.)
- Offline capability (PWA)
- Export guidance to PDF (without scoring)

---

## Version Numbering

- **Major version** (X.0.0): Breaking changes or major feature additions
- **Minor version** (0.X.0): New features, backward compatible
- **Patch version** (0.0.X): Bug fixes and minor improvements

## Release Process

1. Update version in `pubspec.yaml`
2. Update this CHANGELOG.md
3. Create git tag: `git tag v1.0.0`
4. Push tag: `git push origin v1.0.0`
5. Create GitHub release
6. Build and deploy web version

## Support

For questions about specific versions or changes:
- Check documentation in the version's release tag
- Open an issue on GitHub
- Contact maintainers

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for information on how to contribute changes that will be reflected in future versions.
