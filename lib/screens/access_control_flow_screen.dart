import 'package:flutter/material.dart';
import '../data/access_control_data.dart';
import '../models/access_control_models.dart';

/// Screen for the Access Control adaptive question flow
class AccessControlFlowScreen extends StatefulWidget {
  const AccessControlFlowScreen({super.key});

  @override
  State<AccessControlFlowScreen> createState() =>
      _AccessControlFlowScreenState();
}

class _AccessControlFlowScreenState extends State<AccessControlFlowScreen> {
  final List<AccessControlResponse> _responses = [];
  AccessControlQuestion? _currentQuestion;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _currentQuestion = AccessControlData.getFirstQuestion();
  }

  void _handleAnswer(AccessControlOption option) {
    if (_currentQuestion == null) return;

    final response = AccessControlResponse(
      questionId: _currentQuestion!.id,
      questionText: _currentQuestion!.question,
      selectedOptionText: option.text,
      indicatesUncertainty: option.indicatesUncertainty,
      indicatesSharedResponsibility: option.indicatesSharedResponsibility,
      uncertaintyArea: option.uncertaintyArea,
      interpretationUncertainty: option.interpretationUncertainty,
      implementationUncertainty: option.implementationUncertainty,
      foundationalFlag: option.foundationalFlag,
    );

    setState(() {
      _responses.add(response);

      if (option.nextQuestionId != null) {
        _currentQuestion =
            AccessControlData.getQuestionById(option.nextQuestionId!);
      } else if (_currentQuestion!.isReflective) {
        _isComplete = true;
      } else {
        _isComplete = true;
      }
    });
  }

  void _restart() {
    setState(() {
      _responses.clear();
      _currentQuestion = AccessControlData.getFirstQuestion();
      _isComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Access Control',
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
            child: _isComplete ? _buildResultsView() : _buildQuestionView(),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionView() {
    if (_currentQuestion == null) {
      return const Center(child: Text('No questions available.'));
    }

    // Progress indicator
    final baselineCount =
        AccessControlData.questions.where((q) => q.isBaseline).length;
    final estimatedTotal = baselineCount + 2;
    final progress = (_responses.length / estimatedTotal).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Step indicator
        Row(
          children: [
            Text(
              'Question ${_responses.length + 1}',
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
                  value: progress,
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
        // Question card
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
            _currentQuestion!.question,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
          ),
        ),
        const SizedBox(height: 32),
        // Answer buttons
        ..._currentQuestion!.options.map(
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

  Widget _buildResultsView() {
    final result = AccessControlData.calculateResult(_responses);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Access Control Overview',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Clarification Priority: ${result.clarificationPriority.displayText}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          // Clarity indicators
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
                  icon: Icons.menu_book_outlined,
                  label: 'Interpretation Clarity',
                  text: result.interpretationClarity.displayText,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Divider(
                    height: 1,
                    color: Theme.of(context).colorScheme.outlineVariant),
                _buildGuidanceRow(
                  icon: Icons.build_outlined,
                  label: 'Implementation Readiness',
                  text: result.implementationReadiness.displayText,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Conversation starters
          Text(
            'Consider discussing:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          ...const [
            'Who formally approves CJIS access requests?',
            'Is remote access protected consistently across users?',
            'Is access removal documented and time-bound?',
            'Would leadership and IT describe this process the same way?',
          ].map(
            (starter) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_right,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      starter,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _restart,
            child: const Text('Start over'),
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
