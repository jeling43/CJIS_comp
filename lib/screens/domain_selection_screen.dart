import 'package:flutter/material.dart';
import '../data/question_data.dart';
import '../models/question_models.dart';

/// Two-domain selection screen shown after role selection.
class DomainSelectionScreen extends StatelessWidget {
  const DomainSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Where would you like to start?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 32),
                ...QuestionData.domains.map(
                  (domain) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _DomainCard(
                      domain: domain,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/question-flow',
                          arguments: domain.id,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('Change role'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DomainCard extends StatelessWidget {
  final Domain domain;
  final VoidCallback onTap;

  const _DomainCard({required this.domain, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Text(
                domain.icon,
                style: const TextStyle(fontSize: 36),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  domain.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
