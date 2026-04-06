import 'package:flutter/material.dart';
import '../models/results_models.dart';

/// Displays triggered failure patterns as expandable cards.
///
/// Each card shows:
///   - Plain-language explanation
///   - Why it matters
///   - First step to investigate
///
/// Visual bar indicates relative occurrence count (advisory only).
/// No compliance scores, pass/fail, or audit language.
class FailurePatternIndicators extends StatelessWidget {
  final List<FailurePatternDetail> patterns;

  const FailurePatternIndicators({
    super.key,
    required this.patterns,
  });

  @override
  Widget build(BuildContext context) {
    if (patterns.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxOccurrences =
        patterns.fold<int>(0, (max, p) => p.occurrences > max ? p.occurrences : max);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Common Patterns Identified in Your Responses',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'These patterns appeared across your responses and may warrant review.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16),
        ...patterns.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FailurePatternCard(
              pattern: p,
              barFraction: maxOccurrences > 0 ? p.occurrences / maxOccurrences : 0,
            ),
          ),
        ),
      ],
    );
  }
}

class _FailurePatternCard extends StatefulWidget {
  final FailurePatternDetail pattern;

  /// Bar fill fraction (0.0–1.0) representing relative occurrence.
  final double barFraction;

  const _FailurePatternCard({
    required this.pattern,
    required this.barFraction,
  });

  @override
  State<_FailurePatternCard> createState() => _FailurePatternCardState();
}

class _FailurePatternCardState extends State<_FailurePatternCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with bar visualization
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: _expanded
                ? const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  )
                : BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.pattern,
                        size: 18,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.pattern.pattern,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(
                        _expanded
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 20,
                        color: scheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Horizontal bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: widget.barFraction,
                      minHeight: 6,
                      backgroundColor: scheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        scheme.primary.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expandable details
          if (_expanded) ...[
            Divider(height: 1, color: scheme.outlineVariant),
            _DetailRow(
              icon: Icons.lightbulb_outline,
              label: 'What this means',
              text: widget.pattern.explanation,
              color: scheme.primary,
            ),
            Divider(height: 1, color: scheme.outlineVariant),
            _DetailRow(
              icon: Icons.info_outline,
              label: 'Why it matters',
              text: widget.pattern.whyItMatters,
              color: scheme.secondary,
            ),
            Divider(height: 1, color: scheme.outlineVariant),
            _DetailRow(
              icon: Icons.arrow_forward_outlined,
              label: 'First step to investigate',
              text: widget.pattern.firstStep,
              color: scheme.tertiary,
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String text;
  final Color color;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
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
