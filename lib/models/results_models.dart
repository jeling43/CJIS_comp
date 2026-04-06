/// Data models for the Results Page visualization layer.
///
/// These models represent advisory-only attention signals derived from
/// question flow responses. They do NOT represent compliance scores,
/// pass/fail outcomes, or audit conclusions.

/// Qualitative risk level — no numeric scoring.
enum RiskLevel { low, moderate, high }

/// Qualitative confidence level derived from user response patterns.
enum ConfidenceLevel { low, moderate, high }

/// A single domain's attention summary for the results page.
class DomainResult {
  /// Domain identifier (matches [Domain.id]).
  final String domainId;

  /// Human-readable domain title.
  final String title;

  /// Icon string (emoji).
  final String icon;

  /// Number of high-risk conditions triggered in this domain.
  final int highRiskConditions;

  /// Number of uncertain or incomplete responses in this domain.
  final int uncertainResponses;

  /// Qualitative risk level.
  final RiskLevel riskLevel;

  /// Qualitative confidence level.
  final ConfidenceLevel confidenceLevel;

  /// Number of questions answered in this domain.
  final int questionsAnswered;

  /// Total number of questions available in this domain.
  final int totalQuestions;

  const DomainResult({
    required this.domainId,
    required this.title,
    required this.icon,
    required this.highRiskConditions,
    required this.uncertainResponses,
    required this.riskLevel,
    required this.confidenceLevel,
    required this.questionsAnswered,
    required this.totalQuestions,
  });

  /// Attention intensity from 0.0 (none) to 1.0 (maximum) based on
  /// the number of triggered conditions and uncertain responses.
  double get attentionIntensity {
    final total = highRiskConditions + uncertainResponses;
    if (total == 0) return 0.0;
    // Cap at 6 combined signals for max intensity
    return (total / 6).clamp(0.0, 1.0);
  }

  /// Domain coverage as a fraction from 0.0 to 1.0.
  double get coverage {
    if (totalQuestions == 0) return 0.0;
    return (questionsAnswered / totalQuestions).clamp(0.0, 1.0);
  }
}

/// A failure pattern identified in user responses, with drill-down details.
class FailurePatternDetail {
  /// Short label for the pattern (e.g., "Shared account usage").
  final String pattern;

  /// Plain-language explanation of what this pattern means.
  final String explanation;

  /// Why this pattern matters.
  final String whyItMatters;

  /// Suggested first step to investigate.
  final String firstStep;

  /// Number of times this pattern was triggered across domains.
  final int occurrences;

  const FailurePatternDetail({
    required this.pattern,
    required this.explanation,
    required this.whyItMatters,
    required this.firstStep,
    required this.occurrences,
  });
}

/// A single data point for the confidence-vs-risk scatter plot.
class ConfidenceRiskPoint {
  /// Domain identifier.
  final String domainId;

  /// Domain title (for display).
  final String label;

  /// Confidence level (0.0 = low, 1.0 = high).
  final double confidence;

  /// Risk level (0.0 = low, 1.0 = high).
  final double risk;

  const ConfidenceRiskPoint({
    required this.domainId,
    required this.label,
    required this.confidence,
    required this.risk,
  });
}

/// Aggregated results data for the entire results page.
/// Does NOT contain compliance scores, percentages, or pass/fail indicators.
class ResultsData {
  /// Per-domain attention summaries.
  final List<DomainResult> domainResults;

  /// Failure patterns triggered across all domains.
  final List<FailurePatternDetail> failurePatterns;

  /// Scatter-plot data points for confidence vs risk.
  final List<ConfidenceRiskPoint> confidenceRiskPoints;

  const ResultsData({
    required this.domainResults,
    required this.failurePatterns,
    required this.confidenceRiskPoints,
  });
}
