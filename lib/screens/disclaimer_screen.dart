import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Card(
                  elevation: 8,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.security,
                                size: 80,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'CJIS Compliance\nGuidance Tool',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildSection(
                          context,
                          'Important Disclaimer',
                          [
                            'This application is a guidance and decision-support tool only.',
                            'It is NOT an auditing, certification, or compliance enforcement system.',
                            'This tool does not generate official compliance assessments or reports.',
                            'The information provided should be used as general guidance and does not constitute legal advice.',
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          context,
                          'Intended Audience',
                          [
                            'Small to mid-sized law enforcement agencies',
                            'IT security personnel responsible for CJIS compliance',
                            'Agency administrators seeking to understand CJIS requirements',
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          context,
                          'Purpose',
                          [
                            'Help interpret CJIS Security Policy requirements',
                            'Understand common cybersecurity risks',
                            'Learn about best practices for compliance',
                            'Provide decision-support through guided questions',
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          context,
                          'Limitations',
                          [
                            'No user authentication or data storage',
                            'Does not handle case data or evidence',
                            'Does not log or store any CJIS-related information',
                            'All information is maintained locally in your browser session',
                            'Does not replace official CJIS compliance audits',
                          ],
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .errorContainer
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.error,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Theme.of(context).colorScheme.error,
                                size: 32,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'By continuing, you acknowledge that this is guidance only and not an official compliance tool.',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/categories');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 20,
                              ),
                            ),
                            child: const Text(
                              'I Understand - Continue',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 12),
        ...points.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: Text(
                    point,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
