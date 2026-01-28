class GuidanceCategory {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<String> keyPoints;
  final String? policyReference;

  const GuidanceCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.keyPoints,
    this.policyReference,
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
