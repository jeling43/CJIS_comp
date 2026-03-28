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

    // Record the response with layered adaptive model signal flags
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
    // Calculate progress based on responses relative to baseline questions count
    // Using baseline questions as a rough progress indicator since the actual path varies
    final baselineCount = AccessControlData.questions.where((q) => q.isBaseline).length;
    final estimatedTotal = baselineCount + 2; // Baseline + reflective + average drill-down
    final progress = _responses.length / estimatedTotal;
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
                // Section header - Part 4: "Access Control Overview"
                _buildResultsHeader(),
                const SizedBox(height: 24),
                // Part 4: Executive Summary Block
                _buildExecutiveSummary(),
                const SizedBox(height: 24),
                // Part 4: Visual clarity spectrum with Clarification Priority
                _buildClaritySpectrum(result),
                const SizedBox(height: 24),
                // Part 4: Two indicators - Interpretation Clarity and Implementation Readiness
                _buildIndicatorsCard(result),
                const SizedBox(height: 24),
                // Part 4: "Why This Matters" section
                _buildWhyThisMattersCard(),
                const SizedBox(height: 24),
                // Part 4: Suggested Conversation Starters
                _buildConversationStarters(result),
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
              'Access Control Overview',
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

  /// Part 4: Executive Summary Block
  Widget _buildExecutiveSummary() {
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
                  'Executive Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Based on your responses, there are areas where clarification or follow-up discussion may be helpful. This does not determine compliance. It highlights topics where interpretation or implementation may benefit from confirmation.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// Part 4: Two indicators - Interpretation Clarity and Implementation Readiness
  Widget _buildIndicatorsCard(AccessControlReflectionResult result) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Interpretation Clarity indicator
            _buildIndicatorRow(
              icon: Icons.menu_book_outlined,
              label: 'Interpretation Clarity',
              value: result.interpretationClarity.displayText,
              isReviewRecommended: result.interpretationClarity == 
                  InterpretationClarity.reviewRecommended,
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            // Implementation Readiness indicator
            _buildIndicatorRow(
              icon: Icons.build_outlined,
              label: 'Implementation Readiness',
              value: result.implementationReadiness.displayText,
              isReviewRecommended: result.implementationReadiness == 
                  ImplementationReadiness.earlyClarificationRecommended,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isReviewRecommended,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClaritySpectrum(AccessControlReflectionResult result) {
    // Calculate the fill level based on clarity (no percentages shown)
    // Part 4: Display neutral clarity bar [ ▮▮▮▯▯ ]
    // Use balanced fill levels: 5 (best), 3 (middle), 1 (needs attention)
    int fillLevel;
    String priorityLabel;
    switch (result.clarityLevel) {
      case ClarityLevel.generallyClear:
        fillLevel = 5;
        priorityLabel = 'Standard';
      case ClarityLevel.reviewRecommended:
        fillLevel = 3;
        priorityLabel = 'Elevated';
      case ClarityLevel.earlyClarificationRecommended:
        fillLevel = 1;
        priorityLabel = 'Focused';
    }

    // Build the clarity bar string using Unicode block characters
    final filledChar = '▮';
    final emptyChar = '▯';
    final clarityBar = '[ ${filledChar * fillLevel}${emptyChar * (5 - fillLevel)} ]';

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
                  Icons.bar_chart_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Access Control',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Neutral clarity bar as specified in Part 4
            Center(
              child: Text(
                clarityBar,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: 'monospace',
                      letterSpacing: 4,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            // Clarification Priority label
            Center(
              child: Text(
                'Clarification Priority: $priorityLabel',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Part 4: "Why This Matters" section
  Widget _buildWhyThisMattersCard() {
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
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Why This Matters',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Access control decisions influence authentication, auditing, and incident response safeguards. Uncertainty in this area can lead to delayed access removal, unintended exposure, or inconsistent application of safeguards.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// Part 4: Suggested Conversation Starters
  Widget _buildConversationStarters(AccessControlReflectionResult result) {
    // Use the specific conversation starters from requirements
    const conversationStarters = [
      'Who formally approves CJIS access requests?',
      'Is remote access protected consistently across users?',
      'Is access removal documented and time-bound?',
      'Would leadership and IT describe this process the same way?',
    ];

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
                  Icons.forum_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Suggested Conversation Starters',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'You may want to discuss the following with your IT provider or CJIS administrator:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.4,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 16),
            ...conversationStarters.map(
              (starter) => Padding(
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
                        starter,
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
          icon: const Icon(Icons.menu_book_outlined),
          label: const Text('Return to Reference Library'),
        ),
        TextButton.icon(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/roles',
            (route) => false,
          ),
          icon: const Icon(Icons.home),
          label: const Text('Back to guided tool'),
        ),
      ],
    );
  }
}
