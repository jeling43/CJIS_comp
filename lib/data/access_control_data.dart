import '../models/access_control_models.dart';

/// Data for the Access Control section with layered adaptive questioning model
/// Implements three layers: Interpretation Clarity, Operational Validation, Reflection
/// Maximum drill depth: 3 levels per branch
class AccessControlData {
  /// Policy references for the View Policy References link
  static const List<String> policyReferences = [
    'CJIS Security Policy Section 5.2 - Access Control',
    'CJIS Security Policy Section 5.2.1 - Identification and Authentication',
    'CJIS Security Policy Section 5.5 - Access Control',
    'CJIS Security Policy Section 5.6 - Advanced Authentication',
    'CJIS Security Policy Section 5.10 - Physical Protection',
  ];

  /// The layered adaptive question flow for Access Control
  /// Layer 1: Interpretation Clarity - Do you understand what the policy requires?
  /// Layer 2: Operational Validation - Is this actually happening in practice?
  /// Layer 3: Reflection - Organizational consistency check
  static const List<AccessControlQuestion> questions = [
    // ═══════════════════════════════════════════════════════════════════════
    // LAYER 1: INTERPRETATION CLARITY QUESTIONS
    // ═══════════════════════════════════════════════════════════════════════
    
    // Question 1: Governance Decision Question (Layer 1)
    AccessControlQuestion(
      id: 'ac_governance',
      question:
          'When someone needs access to CJIS systems, how is that decision made in practice?',
      isBaseline: true,
      depth: 0,
      category: 'governance',
      options: [
        AccessControlOption(
          text: 'Agency leadership decides',
          nextQuestionId: 'ac_responsibility',
        ),
        AccessControlOption(
          text: 'IT decides',
          nextQuestionId: 'ac_responsibility',
        ),
        AccessControlOption(
          text: 'It is shared',
          nextQuestionId: 'ac_governance_drill_1',
          indicatesSharedResponsibility: true,
          interpretationUncertainty: true,
          foundationalFlag: true,
          uncertaintyArea: 'Governance authority for access decisions',
        ),
        AccessControlOption(
          text: 'I am not sure',
          nextQuestionId: 'ac_governance_drill_1',
          indicatesUncertainty: true,
          interpretationUncertainty: true,
          foundationalFlag: true,
          uncertaintyArea: 'Governance authority for access decisions',
        ),
      ],
    ),

    // Governance drill-down Level 1
    AccessControlQuestion(
      id: 'ac_governance_drill_1',
      question:
          'If there was a disagreement about who should have access, who would make the final decision?',
      depth: 1,
      parentQuestionId: 'ac_governance',
      category: 'governance',
      options: [
        AccessControlOption(
          text: 'There is a clear escalation path',
          nextQuestionId: 'ac_responsibility',
        ),
        AccessControlOption(
          text: 'It would depend on the situation',
          nextQuestionId: 'ac_governance_drill_2',
          interpretationUncertainty: true,
          uncertaintyArea: 'Access governance escalation process',
        ),
        AccessControlOption(
          text: 'I am not sure how this would be resolved',
          nextQuestionId: 'ac_governance_drill_2',
          indicatesUncertainty: true,
          interpretationUncertainty: true,
          uncertaintyArea: 'Access governance escalation process',
        ),
      ],
    ),

    // Governance drill-down Level 2
    AccessControlQuestion(
      id: 'ac_governance_drill_2',
      question:
          'Is the process for deciding access documented anywhere that staff can reference?',
      depth: 2,
      parentQuestionId: 'ac_governance_drill_1',
      category: 'governance',
      options: [
        AccessControlOption(
          text: 'Yes, it is documented and accessible',
          nextQuestionId: 'ac_responsibility',
        ),
        AccessControlOption(
          text: 'There may be documentation, but I have not seen it',
          nextQuestionId: 'ac_responsibility',
          interpretationUncertainty: true,
          uncertaintyArea: 'Access policy documentation',
        ),
        AccessControlOption(
          text: 'No, it is based on institutional knowledge',
          nextQuestionId: 'ac_responsibility',
          interpretationUncertainty: true,
          foundationalFlag: true,
          uncertaintyArea: 'Access policy documentation',
        ),
      ],
    ),

    // Question 2: Responsibility Anchor Question (Layer 1)
    AccessControlQuestion(
      id: 'ac_responsibility',
      question:
          'If access needed to be removed today, would you know exactly who handles that?',
      isBaseline: true,
      depth: 0,
      category: 'responsibility',
      options: [
        AccessControlOption(
          text: 'Yes',
          nextQuestionId: 'ac_remote_access',
        ),
        AccessControlOption(
          text: 'Probably',
          nextQuestionId: 'ac_responsibility_drill_1',
          interpretationUncertainty: true,
          uncertaintyArea: 'Responsibility for access changes',
        ),
        AccessControlOption(
          text: 'Not sure',
          nextQuestionId: 'ac_responsibility_drill_1',
          indicatesUncertainty: true,
          interpretationUncertainty: true,
          uncertaintyArea: 'Responsibility for access changes',
        ),
      ],
    ),

    // Responsibility drill-down Level 1
    AccessControlQuestion(
      id: 'ac_responsibility_drill_1',
      question:
          'When multiple people handle access changes, do they follow the same process?',
      depth: 1,
      parentQuestionId: 'ac_responsibility',
      category: 'responsibility',
      options: [
        AccessControlOption(
          text: 'Yes, there is a standard process everyone follows',
          nextQuestionId: 'ac_remote_access',
        ),
        AccessControlOption(
          text: 'The process varies depending on who handles it',
          nextQuestionId: 'ac_responsibility_drill_2',
          implementationUncertainty: true,
          uncertaintyArea: 'Consistency of access change process',
        ),
        AccessControlOption(
          text: 'I am not aware of a documented process',
          nextQuestionId: 'ac_responsibility_drill_2',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Consistency of access change process',
        ),
      ],
    ),

    // Responsibility drill-down Level 2
    AccessControlQuestion(
      id: 'ac_responsibility_drill_2',
      question:
          'Would different staff members describe the access change process the same way?',
      depth: 2,
      parentQuestionId: 'ac_responsibility_drill_1',
      category: 'responsibility',
      options: [
        AccessControlOption(
          text: 'Yes, everyone would describe it consistently',
          nextQuestionId: 'ac_remote_access',
        ),
        AccessControlOption(
          text: 'There might be some differences in understanding',
          nextQuestionId: 'ac_remote_access',
          implementationUncertainty: true,
          uncertaintyArea: 'Organizational understanding of access processes',
        ),
        AccessControlOption(
          text: 'I expect there would be significant differences',
          nextQuestionId: 'ac_remote_access',
          implementationUncertainty: true,
          uncertaintyArea: 'Organizational understanding of access processes',
        ),
      ],
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // LAYER 2: OPERATIONAL VALIDATION QUESTIONS
    // ═══════════════════════════════════════════════════════════════════════

    // Question 3: Remote Access Validation Question (Layer 2)
    AccessControlQuestion(
      id: 'ac_remote_access',
      question:
          'Does anyone connect to CJIS systems from outside your building?',
      isBaseline: true,
      depth: 0,
      category: 'remote_access',
      options: [
        AccessControlOption(
          text: 'Yes',
          nextQuestionId: 'ac_remote_drill_1',
        ),
        AccessControlOption(
          text: 'No',
          nextQuestionId: 'ac_mixed_use',
        ),
        AccessControlOption(
          text: 'I am not sure',
          nextQuestionId: 'ac_mixed_use',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Remote access awareness',
        ),
      ],
    ),

    // Remote access drill-down Level 1
    AccessControlQuestion(
      id: 'ac_remote_drill_1',
      question:
          'When someone connects from offsite, do they have to complete any additional step before accessing the system?',
      depth: 1,
      parentQuestionId: 'ac_remote_access',
      category: 'remote_access',
      options: [
        AccessControlOption(
          text: 'Yes',
          nextQuestionId: 'ac_mixed_use',
        ),
        AccessControlOption(
          text: 'No',
          nextQuestionId: 'ac_mixed_use',
          implementationUncertainty: true,
          uncertaintyArea: 'Remote access authentication method',
        ),
        AccessControlOption(
          text: 'Not sure',
          nextQuestionId: 'ac_mixed_use',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Remote access authentication method',
        ),
      ],
    ),

    // Question 4: Mixed-Use Workstation Question (Layer 2)
    AccessControlQuestion(
      id: 'ac_mixed_use',
      question:
          'Are CJIS systems accessed from computers that are also used for general internet browsing or email?',
      isBaseline: true,
      depth: 0,
      category: 'mixed_use',
      options: [
        AccessControlOption(
          text: 'No',
          nextQuestionId: 'ac_access_removal',
        ),
        AccessControlOption(
          text: 'Yes',
          nextQuestionId: 'ac_mixed_use_drill_1',
        ),
        AccessControlOption(
          text: 'I am not sure',
          nextQuestionId: 'ac_access_removal',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Mixed-use workstation practices',
        ),
      ],
    ),

    // Mixed-use drill-down Level 1
    AccessControlQuestion(
      id: 'ac_mixed_use_drill_1',
      question:
          'Is that arrangement intentional and periodically reviewed, or simply how it has always been done?',
      depth: 1,
      parentQuestionId: 'ac_mixed_use',
      category: 'mixed_use',
      options: [
        AccessControlOption(
          text: 'Intentional and reviewed',
          nextQuestionId: 'ac_access_removal',
        ),
        AccessControlOption(
          text: 'Not reviewed',
          nextQuestionId: 'ac_access_removal',
          implementationUncertainty: true,
          uncertaintyArea: 'Mixed-use workstation review practices',
        ),
        AccessControlOption(
          text: 'Not sure',
          nextQuestionId: 'ac_access_removal',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Mixed-use workstation review practices',
        ),
      ],
    ),

    // Question 5: Access Lifecycle Validation Question (Layer 2)
    AccessControlQuestion(
      id: 'ac_access_removal',
      question:
          'When someone leaves the agency, is their CJIS access removed the same day?',
      isBaseline: true,
      depth: 0,
      category: 'access_removal',
      options: [
        AccessControlOption(
          text: 'Yes',
          nextQuestionId: 'ac_reflection',
        ),
        AccessControlOption(
          text: 'Usually',
          nextQuestionId: 'ac_reflection',
          implementationUncertainty: true,
          uncertaintyArea: 'Timeliness of access removal',
        ),
        AccessControlOption(
          text: 'Not sure',
          nextQuestionId: 'ac_reflection',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Timeliness of access removal',
        ),
      ],
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // LAYER 4: REFLECTION QUESTION
    // ═══════════════════════════════════════════════════════════════════════

    // Question 6: Organizational Consistency Reflection (Layer 4)
    AccessControlQuestion(
      id: 'ac_reflection',
      question:
          'If you asked three different people how CJIS access works, would they give the same answer?',
      isReflective: true,
      depth: 0,
      category: 'reflection',
      options: [
        AccessControlOption(
          text: 'Yes',
        ),
        AccessControlOption(
          text: 'Probably',
          interpretationUncertainty: true,
          uncertaintyArea: 'Organizational consistency',
        ),
        AccessControlOption(
          text: 'Not sure',
          indicatesUncertainty: true,
          interpretationUncertainty: true,
          uncertaintyArea: 'Organizational consistency',
        ),
      ],
    ),
  ];

  /// Suggested conversation starters based on uncertainty areas (Part 4)
  static const Map<String, List<String>> followUpQuestionsByArea = {
    'governance': [
      'Who formally approves CJIS access requests?',
      'Would leadership and IT describe this process the same way?',
    ],
    'responsibility': [
      'Who formally approves CJIS access requests?',
      'Would leadership and IT describe this process the same way?',
    ],
    'access_removal': [
      'Is access removal documented and time-bound?',
      'Would leadership and IT describe this process the same way?',
    ],
    'remote_access': [
      'Is remote access protected consistently across users?',
      'Would leadership and IT describe this process the same way?',
    ],
    'mixed_use': [
      'Has the mixed-use workstation arrangement been reviewed?',
      'Would leadership and IT describe this process the same way?',
    ],
    'reflection': [
      'Would leadership and IT describe this process the same way?',
    ],
  };

  /// Default suggested conversation starters (Part 4)
  static const List<String> defaultFollowUpQuestions = [
    'Who formally approves CJIS access requests?',
    'Is remote access protected consistently across users?',
    'Is access removal documented and time-bound?',
    'Would leadership and IT describe this process the same way?',
  ];

  /// Calculate the result based on responses using Part 3 classification logic
  /// Internal weighting (hidden from user):
  /// - interpretationUncertaintyCount >= 2 → Interpretation Clarity: Review Recommended
  /// - implementationUncertaintyCount >= 2 OR foundationalFlag true → 
  ///   Implementation Readiness: Early Clarification Recommended
  static AccessControlReflectionResult calculateResult(
    List<AccessControlResponse> responses,
  ) {
    // Count uncertainty signals (Part 3 internal weighting)
    int interpretationUncertaintyCount = 0;
    int implementationUncertaintyCount = 0;
    bool hasFoundationalFlag = false;
    final Set<String> uncertaintyAreas = {};

    for (final response in responses) {
      // Track layered adaptive model signals
      if (response.interpretationUncertainty) {
        interpretationUncertaintyCount++;
      }
      if (response.implementationUncertainty) {
        implementationUncertaintyCount++;
      }
      if (response.foundationalFlag) {
        hasFoundationalFlag = true;
      }
      
      // Track uncertainty areas for follow-up question generation
      if (response.indicatesUncertainty && response.uncertaintyArea != null) {
        uncertaintyAreas.add(response.uncertaintyArea!);
      }
    }

    // Part 3 Classification Logic - determine indicators
    // Interpretation Clarity: Review Recommended if interpretationUncertaintyCount >= 2
    InterpretationClarity interpretationClarity;
    if (interpretationUncertaintyCount >= 2) {
      interpretationClarity = InterpretationClarity.reviewRecommended;
    } else {
      interpretationClarity = InterpretationClarity.generallyClear;
    }

    // Implementation Readiness: Early Clarification Recommended if 
    // implementationUncertaintyCount >= 2 OR foundationalFlag is true
    ImplementationReadiness implementationReadiness;
    if (implementationUncertaintyCount >= 2 || hasFoundationalFlag) {
      implementationReadiness = ImplementationReadiness.earlyClarificationRecommended;
    } else {
      implementationReadiness = ImplementationReadiness.generallyClear;
    }

    // Determine overall clarity level based on the layered model
    // This aligns with the interpretation and implementation indicators
    ClarityLevel clarityLevel;
    if (interpretationUncertaintyCount == 0 && implementationUncertaintyCount == 0 && !hasFoundationalFlag) {
      clarityLevel = ClarityLevel.generallyClear;
    } else if (implementationUncertaintyCount >= 2 || hasFoundationalFlag) {
      clarityLevel = ClarityLevel.earlyClarificationRecommended;
    } else {
      clarityLevel = ClarityLevel.reviewRecommended;
    }

    // Determine clarification priority based on combined uncertainty
    final totalUncertainty = interpretationUncertaintyCount + implementationUncertaintyCount;
    ClarificationPriority priority;
    if (totalUncertainty == 0 && !hasFoundationalFlag) {
      priority = ClarificationPriority.standard;
    } else if (totalUncertainty <= 3 && !hasFoundationalFlag) {
      priority = ClarificationPriority.elevated;
    } else {
      priority = ClarificationPriority.focused;
    }

    // Build suggested follow-up questions based on uncertainty areas
    final List<String> followUpQuestions = [];
    for (final area in uncertaintyAreas) {
      for (final entry in followUpQuestionsByArea.entries) {
        final categoryKey = entry.key;
        final questions = entry.value;
        
        if (_areaMatchesCategory(area, categoryKey) && followUpQuestions.length < 4) {
          followUpQuestions.addAll(questions.take(2));
        }
      }
    }

    // Fall back to defaults if no specific areas identified
    if (followUpQuestions.isEmpty) {
      followUpQuestions.addAll(defaultFollowUpQuestions);
    }

    // Build summary text (avoid prohibited words per requirements)
    String summaryText;
    if (clarityLevel == ClarityLevel.generallyClear) {
      summaryText =
          'Based on your responses, your understanding of access control practices appears consistent. Consider periodic reviews to ensure practices remain aligned with organizational expectations.';
    } else if (clarityLevel == ClarityLevel.reviewRecommended) {
      summaryText =
          'Based on your responses, there are areas where additional clarification may be helpful. This highlights places where assumptions or shared responsibilities may benefit from confirmation.';
    } else {
      summaryText =
          'Based on your responses, several areas may benefit from early clarification. Confirming these practices with appropriate stakeholders could help ensure consistent understanding.';
    }

    return AccessControlReflectionResult(
      clarityLevel: clarityLevel,
      clarificationPriority: priority,
      uncertaintyAreas: uncertaintyAreas.toList(),
      suggestedFollowUpQuestions: followUpQuestions.toSet().toList().take(4).toList(),
      summaryText: summaryText,
      interpretationClarity: interpretationClarity,
      implementationReadiness: implementationReadiness,
      interpretationUncertaintyCount: interpretationUncertaintyCount,
      implementationUncertaintyCount: implementationUncertaintyCount,
      hasFoundationalFlag: hasFoundationalFlag,
    );
  }

  /// Get a question by ID
  static AccessControlQuestion? getQuestionById(String id) {
    try {
      return questions.firstWhere((q) => q.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get the first baseline question
  static AccessControlQuestion? getFirstQuestion() {
    try {
      return questions.firstWhere((q) => q.isBaseline);
    } catch (e) {
      return questions.isNotEmpty ? questions.first : null;
    }
  }

  /// Helper to match an uncertainty area to a category key
  static bool _areaMatchesCategory(String area, String categoryKey) {
    final areaLower = area.toLowerCase();
    switch (categoryKey) {
      case 'governance':
        return areaLower.contains('governance') ||
            areaLower.contains('authority') ||
            areaLower.contains('decision');
      case 'responsibility':
        return areaLower.contains('responsibility') ||
            areaLower.contains('granting') ||
            areaLower.contains('removing') ||
            areaLower.contains('documentation') ||
            areaLower.contains('process');
      case 'access_removal':
        return areaLower.contains('removal') ||
            areaLower.contains('timeliness') ||
            areaLower.contains('offboarding') ||
            areaLower.contains('trigger');
      case 'remote_access':
        return areaLower.contains('remote') ||
            areaLower.contains('authentication') ||
            areaLower.contains('verified');
      case 'mixed_use':
        return areaLower.contains('mixed') ||
            areaLower.contains('workstation') ||
            areaLower.contains('separation');
      case 'reflection':
        return areaLower.contains('consistency') ||
            areaLower.contains('organizational');
      default:
        return false;
    }
  }
}
