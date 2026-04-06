import 'package:flutter/material.dart';
import '../models/results_models.dart';

/// Displays CJIS domains as tiles with color intensity representing
/// the number of attention signals (high-risk conditions + uncertain responses).
///
/// No numeric scores or pass/fail indicators are shown.
/// Tooltip provides advisory-only context.
class AttentionHeatMap extends StatelessWidget {
  final List<DomainResult> domainResults;

  /// Called when the user taps a domain tile to drill down.
  final ValueChanged<DomainResult>? onDomainTap;

  const AttentionHeatMap({
    super.key,
    required this.domainResults,
    this.onDomainTap,
  });

  /// Map attention intensity (0.0–1.0) to a color from light to dark
  /// using a neutral blue-grey palette to avoid red/green "good vs bad" framing.
  Color _intensityColor(BuildContext context, double intensity) {
    final scheme = Theme.of(context).colorScheme;
    // Blend from a very light surface tone to a deeper primary tone
    return Color.lerp(
      scheme.surfaceContainerHighest,
      scheme.primary.withValues(alpha: 0.85),
      intensity,
    )!;
  }

  Color _textColor(double intensity) {
    // Use white text on darker tiles for legibility
    return intensity > 0.5 ? Colors.white : Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Areas That May Require Closer Review',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tile intensity reflects the number of attention signals identified.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: domainResults.map((d) => _HeatMapTile(
                domainResult: d,
                color: _intensityColor(context, d.attentionIntensity),
                textColor: _textColor(d.attentionIntensity),
                onTap: onDomainTap != null ? () => onDomainTap!(d) : null,
              )).toList(),
        ),
      ],
    );
  }
}

class _HeatMapTile extends StatelessWidget {
  final DomainResult domainResult;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  const _HeatMapTile({
    required this.domainResult,
    required this.color,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: domainResult.attentionIntensity > 0
          ? 'This area contains conditions that may require '
              'validation or clarification'
          : 'No notable attention signals identified in this area',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 160,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                domainResult.icon,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 8),
              Text(
                domainResult.title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                _intensityLabel(domainResult.attentionIntensity),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor.withValues(alpha: 0.8),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Advisory-only label — avoids scoring language.
  String _intensityLabel(double intensity) {
    if (intensity == 0) return 'No signals noted';
    if (intensity < 0.35) return 'Few signals noted';
    if (intensity < 0.65) return 'Several signals noted';
    return 'Multiple signals noted';
  }
}
