/// Represents a reference to a specific CJIS Security Policy section
class CJISPolicyReference {
  final String sectionNumber;
  final String plainLanguageInterpretation;

  const CJISPolicyReference({
    required this.sectionNumber,
    required this.plainLanguageInterpretation,
  });
}

/// Represents risk context information
class RiskContext {
  final String title;
  final List<String> riskPoints;

  const RiskContext({
    required this.title,
    required this.riskPoints,
  });
}

/// Represents common failure patterns or misconfigurations
class CommonFailurePattern {
  final String pattern;
  final String description;

  const CommonFailurePattern({
    required this.pattern,
    required this.description,
  });
}

/// Represents priority guidance without scoring
class PriorityGuidance {
  final String higherRiskWhen;
  final String lowerRiskWhen;

  const PriorityGuidance({
    required this.higherRiskWhen,
    required this.lowerRiskWhen,
  });
}

class GuidanceCategory {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<String> keyPoints;
  final String? policyReference;
  
  // New fields for CJIS mapping and risk context
  final List<CJISPolicyReference> cjisPolicyReferences;
  final RiskContext riskContext;
  final List<CommonFailurePattern> commonFailures;
  final PriorityGuidance priorityGuidance;

  const GuidanceCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.keyPoints,
    this.policyReference,
    this.cjisPolicyReferences = const [],
    required this.riskContext,
    this.commonFailures = const [],
    required this.priorityGuidance,
  });
}

class GuidanceQuestion {
  final String id;
  final String question;
  final List<AnswerOption> options;

  const GuidanceQuestion({
    required this.id,
    required this.question,
    required this.options,
  });
}

class AnswerOption {
  final String text;
  final String? nextQuestionId;
  final GuidanceResult? result;

  const AnswerOption({
    required this.text,
    this.nextQuestionId,
    this.result,
  });
}

class GuidanceResult {
  final String title;
  final String description;
  final List<String> riskAreas;
  final List<String> recommendations;
  final String? policyReference;

  const GuidanceResult({
    required this.title,
    required this.description,
    required this.riskAreas,
    required this.recommendations,
    this.policyReference,
  });
}
