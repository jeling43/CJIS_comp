import 'package:flutter/material.dart';
import '../data/access_control_data.dart';
import '../models/access_control_models.dart';

/// Screen for the Access Control adaptive question flow
/// Implements the structured adaptive model:
/// - Begin with broad baseline question
/// - Detect uncertainty or shared responsibility
/// - Drill deeper with 1-3 clarifying questions
/// - Stop when clarity improves
/// - End with reflective question
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

    // Record the response
    final response = AccessControlResponse(
      questionId: _currentQuestion!.id,
      questionText: _currentQuestion!.question,
      selectedOptionText: option.text,
      indicatesUncertainty: option.indicatesUncertainty,
      indicatesSharedResponsibility: option.indicatesSharedResponsibility,
      uncertaintyArea: option.uncertaintyArea,
    );

    setState(() {
      _responses.add(response);

      if (option.nextQuestionId != null) {
        // Navigate to the next question
        _currentQuestion =
            AccessControlData.getQuestionById(option.nextQuestionId!);
      } else if (_currentQuestion!.isReflective) {
        // End of flow - show results
        _isComplete = true;
      } else {
        // No next question specified and not reflective - show results
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
      appBar: AppBar(
        title: const Text('Access Control'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _isComplete ? _buildResultsView() : _buildQuestionView(),
    );
  }

  Widget _buildQuestionView() {
    if (_currentQuestion == null) {
      return const Center(
        child: Text('No questions available.'),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress indicator (subtle, not numeric)
                _buildProgressIndicator(),
                const SizedBox(height: 24),
                // Question card
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question type badge
                        if (_currentQuestion!.isBaseline ||
                            _currentQuestion!.isReflective)
                          _buildQuestionTypeBadge(),
                        if (_currentQuestion!.isBaseline ||
                            _currentQuestion!.isReflective)
                          const SizedBox(height: 16),
                        // Question text
                        Text(
                          _currentQuestion!.question,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                        ),
                        const SizedBox(height: 32),
                        // Answer options
                        ..._currentQuestion!.options.map(
                          (option) => _buildAnswerOption(option),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Back navigation
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Exit to Access Control'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    // Calculate progress based on responses
    final progress = _responses.length / 6; // Approximate total questions
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.question_answer_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Question ${_responses.length + 1}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: clampedProgress,
            backgroundColor: Theme.of(context)
                .colorScheme
                .primaryContainer
                .withValues(alpha: 0.5),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionTypeBadge() {
    String label;
    IconData icon;
    Color backgroundColor;
    Color textColor;

    if (_currentQuestion!.isReflective) {
      label = 'Reflection';
      icon = Icons.psychology_outlined;
      backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
      textColor = Theme.of(context).colorScheme.onTertiaryContainer;
    } else {
      label = 'Baseline Question';
      icon = Icons.foundation_outlined;
      backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
      textColor = Theme.of(context).colorScheme.onSecondaryContainer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(AccessControlOption option) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: InkWell(
        onTap: () => _handleAnswer(option),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  option.text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.5,
                      ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color:
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsView() {
    final result = AccessControlData.calculateResult(_responses);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section header
                _buildResultsHeader(),
                const SizedBox(height: 24),
                // High-level summary
                _buildSummaryCard(result),
                const SizedBox(height: 24),
                // Visual clarity spectrum
                _buildClaritySpectrum(result),
                const SizedBox(height: 24),
                // Clarification priority indicator
                _buildClarificationPriority(result),
                const SizedBox(height: 24),
                // Uncertainty summary
                if (result.uncertaintyAreas.isNotEmpty)
                  _buildUncertaintySummary(result),
                if (result.uncertaintyAreas.isNotEmpty)
                  const SizedBox(height: 24),
                // Suggested follow-up questions
                _buildFollowUpQuestions(result),
                const SizedBox(height: 32),
                // Action buttons
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              Icons.insights_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Access Control Reflection',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(AccessControlReflectionResult result) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.summarize_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              result.summaryText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaritySpectrum(AccessControlReflectionResult result) {
    // Calculate the fill level based on clarity (no percentages shown)
    int fillLevel;
    switch (result.clarityLevel) {
      case ClarityLevel.generallyClear:
        fillLevel = 4;
      case ClarityLevel.reviewRecommended:
        fillLevel = 2;
      case ClarityLevel.earlyClarificationRecommended:
        fillLevel = 1;
    }

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Access Control',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Clarity Level: ${result.clarityLevel.displayText}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 16),
            // Visual clarity bar (neutral, no colors like red/yellow/green)
            Row(
              children: [
                Text(
                  '[ ',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: 'monospace',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                ...List.generate(5, (index) {
                  final isFilled = index < fillLevel;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isFilled
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
                Text(
                  ' ]',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: 'monospace',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClarificationPriority(AccessControlReflectionResult result) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Priority badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        size: 16,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Clarification Priority: ${result.clarificationPriority.displayText}',
                        style:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              result.clarificationPriority.explanation,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUncertaintySummary(AccessControlReflectionResult result) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.help_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 12),
                Text(
                  'You indicated uncertainty in:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...result.uncertaintyAreas.map(
              (area) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        area,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowUpQuestions(AccessControlReflectionResult result) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Suggested Internal Follow-Up Questions:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...result.suggestedFollowUpQuestions.map(
              (question) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_right,
                      size: 20,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        question,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _restart,
              icon: const Icon(Icons.refresh),
              label: const Text('Start Over'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Access Control'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/categories',
            (route) => false,
          ),
          icon: const Icon(Icons.home),
          label: const Text('Return to All Categories'),
        ),
      ],
    );
  }
}
