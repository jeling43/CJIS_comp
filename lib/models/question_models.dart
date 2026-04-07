/// Models for the guided question flow system

/// A domain (top-level category) the user can explore
class Domain {
  final String id;
  final String title;
  final String icon;

  const Domain({required this.id, required this.title, required this.icon});
}

/// A single question in the flow
class FlowQuestion {
  final String id;
  final String text;

  /// If non-null, this is a primary question and this is its 1-based index
  final int? primaryIndex;

  /// Answers the user can choose from
  final List<FlowAnswer> answers;

  const FlowQuestion({
    required this.id,
    required this.text,
    this.primaryIndex,
    required this.answers,
  });

  bool get isPrimary => primaryIndex != null;
}

/// An answer option for a question
class FlowAnswer {
  final String text;

  /// If set, the question with this ID is inserted immediately after this answer
  final String? followUpQuestionId;

  /// Guidance triggered when the user selects this answer (collected for the summary)
  final GuidanceItem? guidance;

  /// Diagnostic flag surfaced in the summary (e.g. "Lack of visibility in this area")
  final String? diagnosticFlag;

  const FlowAnswer({
    required this.text,
    this.followUpQuestionId,
    this.guidance,
    this.diagnosticFlag,
  });
}

/// A single guidance item surfaced at the end of a flow
class GuidanceItem {
  final String meaning;
  final String risk;
  final String whereToLook;
  final String whatToCheck;
  final String firstStep;

  /// Related CJIS reference shown only in the summary (e.g. "CJIS 5.6.2.2")
  final String? cjisReference;

  const GuidanceItem({
    required this.meaning,
    required this.risk,
    required this.whereToLook,
    required this.whatToCheck,
    required this.firstStep,
    this.cjisReference,
  });
}

/// Standard diagnostic flag labels used across the app
class DiagnosticFlags {
  DiagnosticFlags._();

  static const String lackOfVisibility = 'Lack of visibility in this area';
  static const String responsibilityUnclear = 'Responsibility is unclear';
  static const String controlNotEnforced =
      'Control may not be consistently enforced';
}

/// A diagnostic entry collected during the flow
class DiagnosticEntry {
  final String questionId;
  final GuidanceItem guidance;
  final String? diagnosticFlag;

  const DiagnosticEntry({
    required this.questionId,
    required this.guidance,
    this.diagnosticFlag,
  });
}

/// A combined insight generated when multiple related risks appear together
class CombinedInsight {
  /// Question IDs that must each have triggered guidance for this insight to apply
  final Set<String> triggerQuestionIds;

  /// The combined insight text
  final String insight;

  const CombinedInsight({
    required this.triggerQuestionIds,
    required this.insight,
  });
}

/// A complete domain flow (ordered primary questions + branch questions by id)
class DomainFlow {
  final String domainId;

  /// Ordered list of primary question IDs (determines question order + step count)
  final List<String> primaryQuestionIds;

  /// All questions in this flow (primary + branch), keyed by id
  final Map<String, FlowQuestion> questions;

  /// Guidance shown when no notable answers were collected
  final GuidanceItem defaultGuidance;

  /// Combined insights surfaced when multiple related risks are present
  final List<CombinedInsight> combinedInsights;

  const DomainFlow({
    required this.domainId,
    required this.primaryQuestionIds,
    required this.questions,
    required this.defaultGuidance,
    this.combinedInsights = const [],
  });

  int get totalPrimarySteps => primaryQuestionIds.length;

  FlowQuestion? getQuestion(String id) => questions[id];
}
