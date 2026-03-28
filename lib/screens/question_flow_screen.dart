import 'package:flutter/material.dart';
import '../models/question_models.dart';
import '../data/question_data.dart';

// ─── Entry point ─────────────────────────────────────────────────────────────

class QuestionFlowScreen extends StatefulWidget {
  const QuestionFlowScreen({super.key});

  @override
  State<QuestionFlowScreen> createState() => _QuestionFlowScreenState();
}

class _QuestionFlowScreenState extends State<QuestionFlowScreen> {
  // Initialised from route arguments
  late DomainFlow _flow;
  late String _domainTitle;

  // Flow state
  /// Stack of (questionId, answerIndex) representing history for back navigation
  final List<_HistoryEntry> _history = [];

  /// Queue of question IDs remaining to show (primary + any injected branches)
  late List<String> _queue;

  /// Current question being shown
  FlowQuestion? _current;

  /// Primary question step index (1-based) corresponding to the current question
  int _currentPrimaryStep = 0;

  /// Guidance items collected from notable answers
  final List<GuidanceItem> _collectedGuidance = [];

  /// Whether the flow has completed and guidance should be shown
  bool _done = false;

  bool _initialised = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialised) return;
    _initialised = true;

    final args = ModalRoute.of(context)?.settings.arguments;
    final domainId = (args is String ? args : null) ?? 'access_control';

    _flow = QuestionData.getFlow(domainId) ?? QuestionData.accessControlFlow;
    final domain = QuestionData.domains.firstWhere(
      (d) => d.id == domainId,
      orElse: () => QuestionData.domains.first,
    );
    _domainTitle = domain.title;

    _queue = List.of(_flow.primaryQuestionIds);
    _advance();
  }

  // ─── Navigation helpers ─────────────────────────────────────────────────

  /// Advance to the next question in the queue (without changing history)
  void _advance() {
    if (_queue.isEmpty) {
      setState(() => _done = true);
      return;
    }
    final nextId = _queue.removeAt(0);
    final question = _flow.getQuestion(nextId);
    if (question == null) {
      _advance(); // skip unknown IDs
      return;
    }
    if (question.isPrimary) {
      _currentPrimaryStep = question.primaryIndex!;
    }
    setState(() => _current = question);
  }

  /// Handle the user selecting an answer
  void _selectAnswer(int answerIndex) {
    final question = _current;
    if (question == null) return;

    final answer = question.answers[answerIndex];

    // Save history so back can undo this step
    _history.add(_HistoryEntry(
      questionId: question.id,
      answerIndex: answerIndex,
      queueSnapshot: List.of(_queue),
      primaryStep: _currentPrimaryStep,
      guidanceSnapshot: List.of(_collectedGuidance),
      wasDone: _done,
    ));

    // Collect guidance if this answer has one
    if (answer.guidance != null) {
      _collectedGuidance.add(answer.guidance!);
    }

    // Inject follow-up question at front of queue if present
    if (answer.followUpQuestionId != null) {
      _queue.insert(0, answer.followUpQuestionId!);
    }

    _advance();
  }

  /// Go back one step
  void _goBack() {
    if (_history.isEmpty) {
      Navigator.of(context).pop();
      return;
    }
    final entry = _history.removeLast();
    final question = _flow.getQuestion(entry.questionId)!;
    setState(() {
      _current = question;
      _queue = List.of(entry.queueSnapshot);
      _currentPrimaryStep = entry.primaryStep;
      // Restore guidance to snapshot
      _collectedGuidance
        ..clear()
        ..addAll(entry.guidanceSnapshot);
      _done = entry.wasDone;
    });
  }

  // ─── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
          tooltip: 'Back',
        ),
        title: Text(
          _domainTitle,
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
            child: _done ? _buildGuidanceSummary() : _buildQuestionView(),
          ),
        ),
      ),
    );
  }

  // ─── Question view ───────────────────────────────────────────────────────

  Widget _buildQuestionView() {
    final question = _current;
    if (question == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Step indicator
        if (question.isPrimary)
          _StepIndicator(
            current: _currentPrimaryStep,
            total: _flow.totalPrimarySteps,
          ),
        if (!question.isPrimary)
          _FollowUpLabel(text: 'Follow-up'),

        const SizedBox(height: 32),

        // Question card
        _QuestionCard(text: question.text),

        const SizedBox(height: 32),

        // Answer buttons
        ...question.answers.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _AnswerButton(
                  text: entry.value.text,
                  onTap: () => _selectAnswer(entry.key),
                ),
              ),
            ),
      ],
    );
  }

  // ─── Guidance summary ────────────────────────────────────────────────────

  Widget _buildGuidanceSummary() {
    final items = _collectedGuidance.isNotEmpty
        ? _collectedGuidance
        : [_flow.defaultGuidance];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Here\'s what came up',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Based on your answers:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          ...items.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _GuidanceCard(item: g),
              )),
          const SizedBox(height: 32),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Explore another area'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/roles',
                (_) => false,
              );
            },
            child: const Text('Start over'),
          ),
        ],
      ),
    );
  }
}

// ─── History entry ─────────────────────────────────────────────────────────

class _HistoryEntry {
  final String questionId;
  final int answerIndex;
  final List<String> queueSnapshot;
  final int primaryStep;
  final List<GuidanceItem> guidanceSnapshot;
  final bool wasDone;

  _HistoryEntry({
    required this.questionId,
    required this.answerIndex,
    required this.queueSnapshot,
    required this.primaryStep,
    required this.guidanceSnapshot,
    required this.wasDone,
  });
}

// ─── UI components ─────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int current;
  final int total;

  const _StepIndicator({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Step $current of $total',
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
              value: current / total,
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
    );
  }
}

class _FollowUpLabel extends StatelessWidget {
  final String text;
  const _FollowUpLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.subdirectory_arrow_right,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final String text;
  const _QuestionCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              Theme.of(context).colorScheme.primary.withOpacity(0.15),
          width: 1.5,
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _AnswerButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
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
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}

class _GuidanceCard extends StatelessWidget {
  final GuidanceItem item;
  const _GuidanceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GuidanceRow(
            icon: Icons.lightbulb_outline,
            label: 'Meaning',
            text: item.meaning,
            color: scheme.primary,
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          _GuidanceRow(
            icon: Icons.warning_amber_outlined,
            label: 'Risk',
            text: item.risk,
            color: scheme.error,
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          _GuidanceRow(
            icon: Icons.arrow_forward_outlined,
            label: 'Next step',
            text: item.nextStep,
            color: scheme.tertiary,
          ),
        ],
      ),
    );
  }
}

class _GuidanceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String text;
  final Color color;

  const _GuidanceRow({
    required this.icon,
    required this.label,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
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
