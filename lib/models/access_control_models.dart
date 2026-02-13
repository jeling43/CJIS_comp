/// Models for the Access Control section with Clarity & Priority Model
/// These models support the non-scoring, interpretive support focus approach

/// Clarity levels for display - neutral language, no compliance determination
enum ClarityLevel {
  generallyClear('Generally Clear', 4),
  reviewRecommended('Review Recommended', 2),
  earlyClarificationRecommended('Early Clarification Recommended', 1);

  final String displayText;
  final int internalWeight;

  const ClarityLevel(this.displayText, this.internalWeight);
}

/// Clarification priority levels - conveys urgency without declaring failure
enum ClarificationPriority {
  standard('Standard', 'Your responses indicate generally consistent understanding of access control practices.'),
  elevated('Elevated', 'Multiple responses indicated uncertainty in responsibility and remote access verification. Because access control influences authentication and auditing safeguards, confirming these areas may be helpful.'),
  focused('Focused', 'Several foundational areas showed uncertainty. Consider confirming these areas to ensure consistent understanding across your team.');

  final String displayText;
  final String explanation;

  const ClarificationPriority(this.displayText, this.explanation);
}

/// Represents an adaptive question for the Access Control flow
class AccessControlQuestion {
  final String id;
  final String question;
  final List<AccessControlOption> options;
  final bool isBaseline;
  final bool isReflective;
  final String? parentQuestionId;
  final int depth;
  final String? category;

  const AccessControlQuestion({
    required this.id,
    required this.question,
    required this.options,
    this.isBaseline = false,
    this.isReflective = false,
    this.parentQuestionId,
    this.depth = 0,
    this.category,
  });
}

/// An answer option that tracks uncertainty signals
class AccessControlOption {
  final String text;
  final String? nextQuestionId;
  final bool indicatesUncertainty;
  final bool indicatesSharedResponsibility;
  final String? uncertaintyArea;
  
  /// Layered adaptive model signal flags
  /// interpretationUncertainty: Signals user is unsure about policy interpretation
  final bool interpretationUncertainty;
  /// implementationUncertainty: Signals user is unsure about operational implementation
  final bool implementationUncertainty;
  /// foundationalFlag: Signals a foundational area that affects other controls
  final bool foundationalFlag;

  const AccessControlOption({
    required this.text,
    this.nextQuestionId,
    this.indicatesUncertainty = false,
    this.indicatesSharedResponsibility = false,
    this.uncertaintyArea,
    this.interpretationUncertainty = false,
    this.implementationUncertainty = false,
    this.foundationalFlag = false,
  });
}

/// Tracks user responses and uncertainty signals
class AccessControlResponse {
  final String questionId;
  final String questionText;
  final String selectedOptionText;
  final bool indicatesUncertainty;
  final bool indicatesSharedResponsibility;
  final String? uncertaintyArea;
  
  /// Layered adaptive model signal flags
  final bool interpretationUncertainty;
  final bool implementationUncertainty;
  final bool foundationalFlag;

  const AccessControlResponse({
    required this.questionId,
    required this.questionText,
    required this.selectedOptionText,
    this.indicatesUncertainty = false,
    this.indicatesSharedResponsibility = false,
    this.uncertaintyArea,
    this.interpretationUncertainty = false,
    this.implementationUncertainty = false,
    this.foundationalFlag = false,
  });
}

/// Interpretation clarity indicator - Part 4 requirement
enum InterpretationClarity {
  generallyClear('Generally Clear'),
  reviewRecommended('Review Recommended');

  final String displayText;
  const InterpretationClarity(this.displayText);
}

/// Implementation readiness indicator - Part 4 requirement
enum ImplementationReadiness {
  generallyClear('Generally Clear'),
  earlyClarificationRecommended('Early Clarification Recommended');

  final String displayText;
  const ImplementationReadiness(this.displayText);
}

/// Result from the Access Control reflection flow
class AccessControlReflectionResult {
  final ClarityLevel clarityLevel;
  final ClarificationPriority clarificationPriority;
  final List<String> uncertaintyAreas;
  final List<String> suggestedFollowUpQuestions;
  final String summaryText;
  
  /// Part 4 indicators - displayed on results screen
  final InterpretationClarity interpretationClarity;
  final ImplementationReadiness implementationReadiness;
  
  /// Internal counts (hidden from user per Part 3)
  final int interpretationUncertaintyCount;
  final int implementationUncertaintyCount;
  final bool hasFoundationalFlag;

  const AccessControlReflectionResult({
    required this.clarityLevel,
    required this.clarificationPriority,
    required this.uncertaintyAreas,
    required this.suggestedFollowUpQuestions,
    required this.summaryText,
    required this.interpretationClarity,
    required this.implementationReadiness,
    this.interpretationUncertaintyCount = 0,
    this.implementationUncertaintyCount = 0,
    this.hasFoundationalFlag = false,
  });
}
