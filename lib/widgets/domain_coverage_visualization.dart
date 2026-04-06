import 'package:flutter/material.dart';
import '../models/results_models.dart';

/// Shows how much of each domain the user explored, using segmented
/// progress-style bars.
///
/// Purpose: highlight blind spots and prevent false confidence from
/// partial completion.
///
/// Does NOT imply compliance scores or pass/fail outcomes.
class DomainCoverageVisualization extends StatelessWidget {
  final List<DomainResult> domainResults;

  /// Called when the user taps a domain bar to drill down.
  final ValueChanged<DomainResult>? onDomainTap;

  const DomainCoverageVisualization({
    super.key,
    required this.domainResults,
    this.onDomainTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Potential Gaps in Understanding',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Shows how much of each area was explored. '
          'Unexplored areas may contain unidentified considerations.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16),
        ...domainResults.map(
          (d) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _CoverageBar(
              domainResult: d,
              onTap: onDomainTap != null ? () => onDomainTap!(d) : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _CoverageBar extends StatelessWidget {
  final DomainResult domainResult;
  final VoidCallback? onTap;

  const _CoverageBar({
    required this.domainResult,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final coverage = domainResult.coverage;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  domainResult.icon,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    domainResult.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  '${domainResult.questionsAnswered} of '
                  '${domainResult.totalQuestions} explored',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Segmented bar
            _SegmentedBar(
              filled: domainResult.questionsAnswered,
              total: domainResult.totalQuestions,
              activeColor: scheme.primary.withValues(alpha: 0.65),
              inactiveColor: scheme.surfaceContainerHighest,
            ),
            if (coverage < 1.0 && coverage > 0) ...[
              const SizedBox(height: 6),
              Text(
                'Some areas in this domain were not explored',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
            if (coverage == 0) ...[
              const SizedBox(height: 6),
              Text(
                'This domain has not been explored yet',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SegmentedBar extends StatelessWidget {
  final int filled;
  final int total;
  final Color activeColor;
  final Color inactiveColor;

  const _SegmentedBar({
    required this.filled,
    required this.total,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    if (total == 0) return const SizedBox.shrink();

    return Row(
      children: List.generate(total, (index) {
        final isActive = index < filled;
        return Expanded(
          child: Container(
            height: 8,
            margin: EdgeInsets.only(right: index < total - 1 ? 3 : 0),
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
