/// Models for the guided question flow system

/// A role the user can identify as
class UserRole {
  final String id;
  final String label;

  const UserRole({required this.id, required this.label});
}

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

  const FlowAnswer({
    required this.text,
    this.followUpQuestionId,
    this.guidance,
  });
}

/// A single guidance item surfaced at the end of a flow
class GuidanceItem {
  final String meaning;
  final String risk;
  final String nextStep;

  const GuidanceItem({
    required this.meaning,
    required this.risk,
    required this.nextStep,
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

  const DomainFlow({
    required this.domainId,
    required this.primaryQuestionIds,
    required this.questions,
    required this.defaultGuidance,
  });

  int get totalPrimarySteps => primaryQuestionIds.length;

  FlowQuestion? getQuestion(String id) => questions[id];
}
