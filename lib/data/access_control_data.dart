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
          'Who in your organization has the authority to decide who gets access to CJIS systems?',
      isBaseline: true,
      depth: 0,
      category: 'governance',
      options: [
        AccessControlOption(
          text: 'A specific person or role is clearly designated',
          nextQuestionId: 'ac_responsibility',
        ),
        AccessControlOption(
          text: 'Multiple people share this authority informally',
          nextQuestionId: 'ac_governance_drill_1',
          indicatesSharedResponsibility: true,
          interpretationUncertainty: true,
          foundationalFlag: true,
          uncertaintyArea: 'Governance authority for access decisions',
        ),
        AccessControlOption(
          text: 'I am not certain who has this authority',
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

    // Question 2: Responsibility Clarity Question (Layer 1)
    AccessControlQuestion(
      id: 'ac_responsibility',
      question:
          'Is there a clear understanding of who is responsible for adding and removing access?',
      isBaseline: true,
      depth: 0,
      category: 'responsibility',
      options: [
        AccessControlOption(
          text: 'Yes, responsibility is clearly assigned',
          nextQuestionId: 'ac_remote_access',
        ),
        AccessControlOption(
          text: 'Responsibility is split across different teams',
          nextQuestionId: 'ac_responsibility_drill_1',
          indicatesSharedResponsibility: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Responsibility for access changes',
        ),
        AccessControlOption(
          text: 'It depends on who is available at the time',
          nextQuestionId: 'ac_responsibility_drill_1',
          indicatesUncertainty: true,
          implementationUncertainty: true,
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
          'When someone accesses CJIS systems from outside your facility, how is their identity verified?',
      isBaseline: true,
      depth: 0,
      category: 'remote_access',
      options: [
        AccessControlOption(
          text: 'Multi-factor authentication is required',
          nextQuestionId: 'ac_mixed_use',
        ),
        AccessControlOption(
          text: 'A username and password is used',
          nextQuestionId: 'ac_remote_drill_1',
          implementationUncertainty: true,
          uncertaintyArea: 'Remote access authentication method',
        ),
        AccessControlOption(
          text: 'Remote access is not permitted',
          nextQuestionId: 'ac_mixed_use',
        ),
        AccessControlOption(
          text: 'I am not sure how remote access works',
          nextQuestionId: 'ac_remote_drill_1',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Remote access authentication method',
        ),
      ],
    ),

    // Remote access drill-down Level 1
    AccessControlQuestion(
      id: 'ac_remote_drill_1',
      question:
          'Is remote access handled the same way for everyone, or are there different arrangements for different people?',
      depth: 1,
      parentQuestionId: 'ac_remote_access',
      category: 'remote_access',
      options: [
        AccessControlOption(
          text: 'Everyone follows the same remote access procedure',
          nextQuestionId: 'ac_mixed_use',
        ),
        AccessControlOption(
          text: 'Some people have different access arrangements',
          nextQuestionId: 'ac_remote_drill_2',
          implementationUncertainty: true,
          uncertaintyArea: 'Consistency of remote access practices',
        ),
        AccessControlOption(
          text: 'I am not certain how different users connect',
          nextQuestionId: 'ac_remote_drill_2',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Consistency of remote access practices',
        ),
      ],
    ),

    // Remote access drill-down Level 2
    AccessControlQuestion(
      id: 'ac_remote_drill_2',
      question:
          'Are remote access methods documented and reviewed periodically?',
      depth: 2,
      parentQuestionId: 'ac_remote_drill_1',
      category: 'remote_access',
      options: [
        AccessControlOption(
          text: 'Yes, remote access is documented and reviewed',
          nextQuestionId: 'ac_mixed_use',
        ),
        AccessControlOption(
          text: 'Documentation may exist but is not regularly reviewed',
          nextQuestionId: 'ac_mixed_use',
          implementationUncertainty: true,
          uncertaintyArea: 'Remote access documentation and review',
        ),
        AccessControlOption(
          text: 'I am not aware of any documentation',
          nextQuestionId: 'ac_mixed_use',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Remote access documentation and review',
        ),
      ],
    ),

    // Question 4: Mixed-Use Workstation Question (Layer 2)
    AccessControlQuestion(
      id: 'ac_mixed_use',
      question:
          'Are computers that access CJIS systems also used for other purposes like email or web browsing?',
      isBaseline: true,
      depth: 0,
      category: 'mixed_use',
      options: [
        AccessControlOption(
          text: 'No, CJIS computers are dedicated to that purpose',
          nextQuestionId: 'ac_access_removal',
        ),
        AccessControlOption(
          text: 'Yes, the same computers are used for multiple purposes',
          nextQuestionId: 'ac_mixed_use_drill_1',
          implementationUncertainty: true,
          uncertaintyArea: 'Mixed-use workstation practices',
        ),
        AccessControlOption(
          text: 'It varies by workstation or department',
          nextQuestionId: 'ac_mixed_use_drill_1',
          implementationUncertainty: true,
          uncertaintyArea: 'Mixed-use workstation practices',
        ),
        AccessControlOption(
          text: 'I am not certain about workstation usage',
          nextQuestionId: 'ac_mixed_use_drill_1',
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
          'For workstations used for multiple purposes, are there controls to separate CJIS access from other activities?',
      depth: 1,
      parentQuestionId: 'ac_mixed_use',
      category: 'mixed_use',
      options: [
        AccessControlOption(
          text: 'Yes, there are clear separation controls in place',
          nextQuestionId: 'ac_access_removal',
        ),
        AccessControlOption(
          text: 'Some controls exist but I am not sure of the details',
          nextQuestionId: 'ac_mixed_use_drill_2',
          implementationUncertainty: true,
          uncertaintyArea: 'Workstation access separation controls',
        ),
        AccessControlOption(
          text: 'I do not believe there are specific controls',
          nextQuestionId: 'ac_mixed_use_drill_2',
          implementationUncertainty: true,
          foundationalFlag: true,
          uncertaintyArea: 'Workstation access separation controls',
        ),
      ],
    ),

    // Mixed-use drill-down Level 2
    AccessControlQuestion(
      id: 'ac_mixed_use_drill_2',
      question:
          'Has the mixed-use approach been reviewed or approved by someone responsible for security?',
      depth: 2,
      parentQuestionId: 'ac_mixed_use_drill_1',
      category: 'mixed_use',
      options: [
        AccessControlOption(
          text: 'Yes, this has been reviewed and approved',
          nextQuestionId: 'ac_access_removal',
        ),
        AccessControlOption(
          text: 'I believe it has been reviewed but am not certain',
          nextQuestionId: 'ac_access_removal',
          implementationUncertainty: true,
          uncertaintyArea: 'Security review of workstation practices',
        ),
        AccessControlOption(
          text: 'I do not think this has been formally reviewed',
          nextQuestionId: 'ac_access_removal',
          implementationUncertainty: true,
          uncertaintyArea: 'Security review of workstation practices',
        ),
      ],
    ),

    // Question 5: Access Removal Timing Question (Layer 2)
    AccessControlQuestion(
      id: 'ac_access_removal',
      question:
          'When someone leaves your organization or changes roles, how quickly is their access adjusted?',
      isBaseline: true,
      depth: 0,
      category: 'access_removal',
      options: [
        AccessControlOption(
          text: 'Same day, as part of a standard offboarding process',
          nextQuestionId: 'ac_reflection',
        ),
        AccessControlOption(
          text: 'Within a few days, depending on notification',
          nextQuestionId: 'ac_access_removal_drill_1',
          implementationUncertainty: true,
          uncertaintyArea: 'Timeliness of access removal',
        ),
        AccessControlOption(
          text: 'It varies and depends on who remembers to request it',
          nextQuestionId: 'ac_access_removal_drill_1',
          implementationUncertainty: true,
          foundationalFlag: true,
          uncertaintyArea: 'Timeliness of access removal',
        ),
        AccessControlOption(
          text: 'I am not sure how this is handled',
          nextQuestionId: 'ac_access_removal_drill_1',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Timeliness of access removal',
        ),
      ],
    ),

    // Access removal drill-down Level 1
    AccessControlQuestion(
      id: 'ac_access_removal_drill_1',
      question:
          'Is there a defined trigger that initiates the access removal process?',
      depth: 1,
      parentQuestionId: 'ac_access_removal',
      category: 'access_removal',
      options: [
        AccessControlOption(
          text: 'Yes, HR or management has an automated notification',
          nextQuestionId: 'ac_reflection',
        ),
        AccessControlOption(
          text: 'It relies on someone remembering to notify IT',
          nextQuestionId: 'ac_access_removal_drill_2',
          implementationUncertainty: true,
          uncertaintyArea: 'Access removal trigger process',
        ),
        AccessControlOption(
          text: 'I am not aware of a defined trigger',
          nextQuestionId: 'ac_access_removal_drill_2',
          indicatesUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Access removal trigger process',
        ),
      ],
    ),

    // Access removal drill-down Level 2
    AccessControlQuestion(
      id: 'ac_access_removal_drill_2',
      question:
          'Has there ever been a situation where someone retained access longer than they should have?',
      depth: 2,
      parentQuestionId: 'ac_access_removal_drill_1',
      category: 'access_removal',
      options: [
        AccessControlOption(
          text: 'Not that I am aware of',
          nextQuestionId: 'ac_reflection',
        ),
        AccessControlOption(
          text: 'Possibly, but I am not certain',
          nextQuestionId: 'ac_reflection',
          implementationUncertainty: true,
          uncertaintyArea: 'Historical access removal timeliness',
        ),
        AccessControlOption(
          text: 'Yes, this has happened before',
          nextQuestionId: 'ac_reflection',
          implementationUncertainty: true,
          uncertaintyArea: 'Historical access removal timeliness',
        ),
      ],
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // LAYER 3: REFLECTION QUESTION
    // ═══════════════════════════════════════════════════════════════════════

    // Question 6: Organizational Consistency Reflection (Layer 3)
    AccessControlQuestion(
      id: 'ac_reflection',
      question:
          'If different people in your organization answered these same questions, would they give similar answers?',
      isReflective: true,
      depth: 0,
      category: 'reflection',
      options: [
        AccessControlOption(
          text: 'Yes, I believe everyone would answer similarly',
        ),
        AccessControlOption(
          text: 'Most answers would be similar, but some might differ',
          interpretationUncertainty: true,
          uncertaintyArea: 'Organizational consistency',
        ),
        AccessControlOption(
          text: 'I expect there would be noticeable differences',
          interpretationUncertainty: true,
          implementationUncertainty: true,
          uncertaintyArea: 'Organizational consistency',
        ),
        AccessControlOption(
          text: 'I am not sure how others would answer',
          indicatesUncertainty: true,
          interpretationUncertainty: true,
          uncertaintyArea: 'Organizational consistency',
        ),
      ],
    ),
  ];

  /// Suggested follow-up questions based on uncertainty areas
  static const Map<String, List<String>> followUpQuestionsByArea = {
    'governance': [
      'Who has final authority for CJIS access decisions?',
      'Is the access governance structure documented?',
      'How are access decisions communicated to stakeholders?',
    ],
    'responsibility': [
      'Who formally approves CJIS access in your agency?',
      'Is the access approval process documented?',
      'Would agency leadership and IT describe this process the same way?',
    ],
    'access_removal': [
      'Is there a checklist or process that runs when staff leave?',
      'How is HR connected to the access removal process?',
      'When was the last time access was reviewed for accuracy?',
    ],
    'remote_access': [
      'Is remote access handled consistently across users?',
      'What authentication methods are required for remote access?',
      'Are remote devices subject to the same security requirements?',
    ],
    'mixed_use': [
      'Are mixed-use workstations identified and documented?',
      'What controls separate CJIS activities from other uses?',
      'Has this configuration been approved by security personnel?',
    ],
    'reflection': [
      'Would different staff describe access practices consistently?',
      'Are access procedures documented for reference?',
      'When were access practices last reviewed?',
    ],
  };

  /// Default suggested follow-up questions
  static const List<String> defaultFollowUpQuestions = [
    'Who formally approves CJIS access?',
    'Is the access change process documented?',
    'Would agency leadership and IT describe this process the same way?',
    'When was the last time access practices were reviewed?',
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
