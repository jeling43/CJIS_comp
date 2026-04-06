import 'package:flutter/material.dart';
import '../models/results_models.dart';

/// Scatter plot showing confidence (X-axis) vs risk (Y-axis) for each domain.
///
/// Quadrant labels provide subtle, non-alarmist guidance:
///   - High confidence + high risk → "May warrant a second look"
///   - Low confidence + low risk → "Consider exploring further"
///   - High confidence + low risk → "Appears well understood"
///   - Low confidence + high risk → "Knowledge gap to review"
///
/// No compliance scores, percentages, or pass/fail indicators.
class ConfidenceRiskScatter extends StatelessWidget {
  final List<ConfidenceRiskPoint> points;

  /// Called when the user taps a data point.
  final ValueChanged<ConfidenceRiskPoint>? onPointTap;

  const ConfidenceRiskScatter({
    super.key,
    required this.points,
    this.onPointTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Observed Risk and Confidence Signals',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Each point represents a domain. Position reflects '
          'response confidence and risk signal strength.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.4,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return _ScatterCanvas(
                points: points,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                onPointTap: onPointTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ScatterCanvas extends StatelessWidget {
  final List<ConfidenceRiskPoint> points;
  final double width;
  final double height;
  final ValueChanged<ConfidenceRiskPoint>? onPointTap;

  const _ScatterCanvas({
    required this.points,
    required this.width,
    required this.height,
    this.onPointTap,
  });

  static const double _padding = 48;
  static const double _dotRadius = 8;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final plotW = width - _padding * 2;
    final plotH = height - _padding * 2;

    return Stack(
      children: [
        // Background quadrant shading
        CustomPaint(
          size: Size(width, height),
          painter: _QuadrantPainter(
            padding: _padding,
            lineColor: scheme.outlineVariant,
            bgLight: scheme.surfaceContainerHighest.withValues(alpha: 0.3),
          ),
        ),

        // Quadrant labels (subtle)
        _quadrantLabel(
          context,
          'May warrant a\nsecond look',
          _padding + plotW * 0.75,
          _padding + plotH * 0.15,
        ),
        _quadrantLabel(
          context,
          'Appears well\nunderstood',
          _padding + plotW * 0.75,
          _padding + plotH * 0.70,
        ),
        _quadrantLabel(
          context,
          'Knowledge gap\nto review',
          _padding + plotW * 0.10,
          _padding + plotH * 0.15,
        ),
        _quadrantLabel(
          context,
          'Consider exploring\nfurther',
          _padding + plotW * 0.10,
          _padding + plotH * 0.70,
        ),

        // Axis labels
        Positioned(
          bottom: 4,
          left: _padding,
          right: _padding,
          child: Center(
            child: Text(
              'User Confidence →',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          ),
        ),
        Positioned(
          top: _padding,
          left: 2,
          bottom: _padding,
          child: RotatedBox(
            quarterTurns: 3,
            child: Center(
              child: Text(
                'Risk Signal →',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
            ),
          ),
        ),

        // Data points
        ...points.map((point) {
          final x = _padding + point.confidence * plotW;
          // Invert Y so high risk is at the top
          final y = _padding + (1.0 - point.risk) * plotH;
          return Positioned(
            left: x - _dotRadius,
            top: y - _dotRadius,
            child: _DataDot(
              point: point,
              color: scheme.primary,
              onTap: onPointTap != null ? () => onPointTap!(point) : null,
            ),
          );
        }),
      ],
    );
  }

  Widget _quadrantLabel(
    BuildContext context,
    String text,
    double x,
    double y,
  ) {
    return Positioned(
      left: x,
      top: y,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.5),
              fontSize: 10,
            ),
      ),
    );
  }
}

class _QuadrantPainter extends CustomPainter {
  final double padding;
  final Color lineColor;
  final Color bgLight;

  _QuadrantPainter({
    required this.padding,
    required this.lineColor,
    required this.bgLight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final plotW = size.width - padding * 2;
    final plotH = size.height - padding * 2;

    // Plot area border
    final borderPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(
      Rect.fromLTWH(padding, padding, plotW, plotH),
      borderPaint,
    );

    // Quadrant dividers (dashed effect via thin line)
    final dashPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    // Horizontal center
    canvas.drawLine(
      Offset(padding, padding + plotH / 2),
      Offset(padding + plotW, padding + plotH / 2),
      dashPaint,
    );
    // Vertical center
    canvas.drawLine(
      Offset(padding + plotW / 2, padding),
      Offset(padding + plotW / 2, padding + plotH),
      dashPaint,
    );

    // Light background for the "knowledge gap" quadrant (low confidence, high risk)
    final highlightPaint = Paint()
      ..color = bgLight
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(padding, padding, plotW / 2, plotH / 2),
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _QuadrantPainter oldDelegate) =>
      lineColor != oldDelegate.lineColor || bgLight != oldDelegate.bgLight;
}

class _DataDot extends StatelessWidget {
  final ConfidenceRiskPoint point;
  final Color color;
  final VoidCallback? onTap;

  const _DataDot({
    required this.point,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: point.label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.75),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
        ),
      ),
    );
  }
}
