import 'package:flutter/material.dart';
import '../models/results_models.dart';
import '../data/results_sample_data.dart';
import '../widgets/attention_heat_map.dart';
import '../widgets/confidence_risk_scatter.dart';
import '../widgets/failure_pattern_indicators.dart';
import '../widgets/domain_coverage_visualization.dart';

/// Unified results page integrating all visualization components.
///
/// This page provides advisory-only attention guidance. It does NOT display
/// compliance scores, pass/fail indicators, or audit conclusions.
class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late ResultsData _data;
  bool _initialised = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialised) return;
    _initialised = true;

    // Accept ResultsData via route arguments; fall back to sample data for testing.
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ResultsData) {
      _data = args;
    } else {
      _data = ResultsSampleData.sampleResults;
    }
  }

  void _showDrillDown(BuildContext context, String title, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.85,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),
              content,
            ],
          ),
        ),
      ),
    );
  }

  void _onDomainTap(DomainResult domain) {
    _showDrillDown(
      context,
      domain.title,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            label: 'Attention signals',
            value:
                '${domain.highRiskConditions} high-risk conditions, '
                '${domain.uncertainResponses} uncertain responses',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            label: 'Coverage',
            value:
                '${domain.questionsAnswered} of ${domain.totalQuestions} '
                'questions explored',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            label: 'Risk signal',
            value: domain.riskLevel.name,
          ),
          const SizedBox(height: 12),
          _InfoRow(
            label: 'Confidence signal',
            value: domain.confidenceLevel.name,
          ),
          const SizedBox(height: 20),
          Text(
            'This information is advisory only and does not constitute a '
            'compliance evaluation.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }

  void _onScatterPointTap(ConfidenceRiskPoint point) {
    String quadrantNote;
    if (point.confidence >= 0.5 && point.risk >= 0.5) {
      quadrantNote = 'High confidence alongside elevated risk signals — '
          'may warrant a second look to validate assumptions.';
    } else if (point.confidence < 0.5 && point.risk >= 0.5) {
      quadrantNote = 'Lower confidence with elevated risk signals — '
          'this area may benefit from further exploration.';
    } else if (point.confidence >= 0.5 && point.risk < 0.5) {
      quadrantNote = 'This area appears well understood with '
          'fewer risk signals identified.';
    } else {
      quadrantNote = 'Lower confidence in an area with fewer risk signals — '
          'consider exploring further when possible.';
    }

    _showDrillDown(
      context,
      point.label,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quadrantNote,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Text(
            'This information is advisory only.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
        title: Text(
          'Signals to Validate',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Advisory disclaimer
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'This summary highlights areas to review. It does '
                          'not represent a compliance evaluation, audit finding, '
                          'or certification status.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // 1. Attention Heat Map
                AttentionHeatMap(
                  domainResults: _data.domainResults,
                  onDomainTap: _onDomainTap,
                ),
                const SizedBox(height: 36),

                // 2. Confidence vs Risk Scatter Plot
                ConfidenceRiskScatter(
                  points: _data.confidenceRiskPoints,
                  onPointTap: _onScatterPointTap,
                ),
                const SizedBox(height: 36),

                // 3. Failure Pattern Indicators
                FailurePatternIndicators(
                  patterns: _data.failurePatterns,
                ),
                const SizedBox(height: 36),

                // 4. Domain Coverage Visualization
                DomainCoverageVisualization(
                  domainResults: _data.domainResults,
                  onDomainTap: _onDomainTap,
                ),
                const SizedBox(height: 36),

                // Navigation
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back to guidance summary'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (_) => false,
                    );
                  },
                  child: const Text('Start from the beginning'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
