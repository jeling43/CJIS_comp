import 'package:flutter/material.dart';
import '../data/guidance_data.dart';
import '../models/guidance_models.dart';

class GuidanceFlowScreen extends StatefulWidget {
  const GuidanceFlowScreen({super.key});

  @override
  State<GuidanceFlowScreen> createState() => _GuidanceFlowScreenState();
}

class _GuidanceFlowScreenState extends State<GuidanceFlowScreen> {
  late String categoryId;
  late List<GuidanceQuestion> questions;
  int currentQuestionIndex = 0;
  GuidanceResult? result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! String) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
      return;
    }
    categoryId = args;
    questions = GuidanceData.getQuestionsForCategory(categoryId) ?? [];
  }

  void _handleAnswer(AnswerOption option) {
    if (option.result != null) {
      setState(() {
        result = option.result;
      });
    } else if (option.nextQuestionId != null) {
      final nextIndex = questions.indexWhere(
        (q) => q.id == option.nextQuestionId,
      );
      if (nextIndex != -1) {
        setState(() {
          currentQuestionIndex = nextIndex;
        });
      }
    }
  }

  void _restart() {
    setState(() {
      currentQuestionIndex = 0;
      result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Guidance')),
        body: const Center(
          child: Text('No questions available for this category.'),
        ),
      );
    }

    final category = GuidanceData.getCategoryById(categoryId);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          category?.title ?? 'Guidance',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: result != null ? _buildResultView() : _buildQuestionView(),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionView() {
    final question = questions[currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Step indicator
        Row(
          children: [
            Text(
              'Step ${currentQuestionIndex + 1} of ${questions.length}',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / questions.length,
                  minHeight: 6,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Question
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primaryContainer
                .withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.primary.withOpacity(0.15),
              width: 1.5,
            ),
          ),
          child: Text(
            question.question,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
          ),
        ),
        const SizedBox(height: 32),
        // Answer buttons
        ...question.options.map(
          (option) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18, horizontal: 20),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1.5,
                  ),
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                onPressed: () => _handleAnswer(option),
                child: Text(option.text),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            result!.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          // Guidance card with Meaning / Risk / Next Step
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGuidanceRow(
                  icon: Icons.lightbulb_outline,
                  label: 'What this means',
                  text: result!.description,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Divider(
                    height: 1,
                    color: Theme.of(context).colorScheme.outlineVariant),
                if (result!.riskAreas.isNotEmpty)
                  _buildGuidanceRow(
                    icon: Icons.warning_amber_outlined,
                    label: 'Why it matters',
                    text: result!.riskAreas.first,
                    color: Theme.of(context).colorScheme.error,
                  ),
                if (result!.riskAreas.isNotEmpty)
                  Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.outlineVariant),
                if (result!.recommendations.isNotEmpty)
                  _buildGuidanceRow(
                    icon: Icons.arrow_forward_outlined,
                    label: 'First step',
                    text: result!.recommendations.first,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
              ],
            ),
          ),
          // Optional: collapsed CJIS reference
          if (result!.policyReference != null) ...[
            const SizedBox(height: 16),
            Text(
              result!.policyReference!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 32),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _restart,
            child: const Text('Try again'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidanceRow({
    required IconData icon,
    required String label,
    required String text,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
