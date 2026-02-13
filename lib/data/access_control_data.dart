import '../models/access_control_models.dart';

/// Data for the Access Control section with adaptive questioning model
class AccessControlData {
  /// Policy references for the View policy references link
  static const List<String> policyReferences = [
    'CJIS Security Policy Section 5.2 - Access Control',
    'CJIS Security Policy Section 5.2.1 - Identification and Authentication',
    'CJIS Security Policy Section 5.5 - Access Control',
    'CJIS Security Policy Section 5.6 - Advanced Authentication',
    'CJIS Security Policy Section 5.10 - Physical Protection',
  ];

  /// The adaptive question flow for Access Control
  /// Follows: Broad baseline → detect uncertainty → drill deeper → reflective ending
  static const List<AccessControlQuestion> questions = [
    // Baseline question 1 - Who grants access
    AccessControlQuestion(
      id: 'ac_baseline_1',
      question:
          'In your agency, who is responsible for granting access to CJIS systems?',
      isBaseline: true,
      depth: 0,
      category: 'responsibility',
      options: [
        AccessControlOption(
          text: 'A single person or role has clear responsibility',
          nextQuestionId: 'ac_baseline_2',
        ),
        AccessControlOption(
          text: 'Multiple people or teams share this responsibility',
          nextQuestionId: 'ac_drill_shared_1',
          indicatesSharedResponsibility: true,
          uncertaintyArea: 'Responsibility for granting and removing access',
        ),
        AccessControlOption(
          text: 'I\'m not sure who handles this',
          nextQuestionId: 'ac_drill_unsure_1',
          indicatesUncertainty: true,
          uncertaintyArea: 'Responsibility for granting and removing access',
        ),
      ],
    ),

    // Drill-down for shared responsibility
    AccessControlQuestion(
      id: 'ac_drill_shared_1',
      question:
          'When responsibility is shared, is there documentation that describes who handles which parts?',
      depth: 1,
      parentQuestionId: 'ac_baseline_1',
      category: 'responsibility',
      options: [
        AccessControlOption(
          text: 'Yes, there is clear documentation',
          nextQuestionId: 'ac_baseline_2',
        ),
        AccessControlOption(
          text: 'There may be documentation, but I haven\'t seen it',
          nextQuestionId: 'ac_baseline_2',
          indicatesUncertainty: true,
          uncertaintyArea: 'Documentation of access responsibilities',
        ),
        AccessControlOption(
          text: 'No, it\'s based on how things have always been done',
          nextQuestionId: 'ac_drill_shared_2',
          indicatesUncertainty: true,
          uncertaintyArea: 'Documentation of access responsibilities',
        ),
      ],
    ),

    // Further drill-down
    AccessControlQuestion(
      id: 'ac_drill_shared_2',
      question:
          'If you asked three different people in your agency who grants CJIS access, would they give the same answer?',
      depth: 2,
      parentQuestionId: 'ac_drill_shared_1',
      category: 'responsibility',
      options: [
        AccessControlOption(
          text: 'Yes, everyone would say the same thing',
          nextQuestionId: 'ac_baseline_2',
        ),
        AccessControlOption(
          text: 'They might give different answers',
          nextQuestionId: 'ac_baseline_2',
          indicatesUncertainty: true,
          uncertaintyArea: 'Consistent understanding of access responsibilities',
        ),
        AccessControlOption(
          text: 'I\'m not sure',
          nextQuestionId: 'ac_baseline_2',
          indicatesUncertainty: true,
          uncertaintyArea: 'Consistent understanding of access responsibilities',
        ),
      ],
    ),

    // Drill-down for "not sure"
    AccessControlQuestion(
      id: 'ac_drill_unsure_1',
      question:
          'If you needed to get CJIS access for a new employee today, who would you contact?',
      depth: 1,
      parentQuestionId: 'ac_baseline_1',
      category: 'responsibility',
      options: [
        AccessControlOption(
          text: 'I know exactly who to contact',
          nextQuestionId: 'ac_baseline_2',
        ),
        AccessControlOption(
          text: 'I would ask around to find out',
          nextQuestionId: 'ac_baseline_2',
          indicatesUncertainty: true,
          uncertaintyArea: 'Process for requesting new access',
        ),
        AccessControlOption(
          text: 'I would need to look it up or ask IT',
          nextQuestionId: 'ac_baseline_2',
          indicatesUncertainty: true,
          uncertaintyArea: 'Process for requesting new access',
        ),
      ],
    ),

    // Baseline question 2 - Access removal
    AccessControlQuestion(
      id: 'ac_baseline_2',
      question:
          'When someone leaves your agency or changes roles, how quickly is their CJIS access typically removed or adjusted?',
      isBaseline: true,
      depth: 0,
      category: 'access_changes',
      options: [
        AccessControlOption(
          text: 'Same day or within 24 hours',
          nextQuestionId: 'ac_baseline_3',
        ),
        AccessControlOption(
          text: 'Within a few days',
          nextQuestionId: 'ac_drill_removal_1',
        ),
        AccessControlOption(
          text: 'It varies or I\'m not sure',
          nextQuestionId: 'ac_drill_removal_1',
          indicatesUncertainty: true,
          uncertaintyArea: 'What happens when staff roles change',
        ),
      ],
    ),

    // Drill-down for access removal
    AccessControlQuestion(
      id: 'ac_drill_removal_1',
      question:
          'Is there a defined process that triggers access removal when someone leaves?',
      depth: 1,
      parentQuestionId: 'ac_baseline_2',
      category: 'access_changes',
      options: [
        AccessControlOption(
          text: 'Yes, HR or management automatically notifies the right people',
          nextQuestionId: 'ac_baseline_3',
        ),
        AccessControlOption(
          text: 'It depends on someone remembering to do it',
          nextQuestionId: 'ac_baseline_3',
          indicatesUncertainty: true,
          uncertaintyArea: 'Process for removing access when staff leave',
        ),
        AccessControlOption(
          text: 'I\'m not sure how it works',
          nextQuestionId: 'ac_baseline_3',
          indicatesUncertainty: true,
          uncertaintyArea: 'Process for removing access when staff leave',
        ),
      ],
    ),

    // Baseline question 3 - Remote access
    AccessControlQuestion(
      id: 'ac_baseline_3',
      question: 'Does your agency allow remote access to CJIS systems?',
      isBaseline: true,
      depth: 0,
      category: 'remote_access',
      options: [
        AccessControlOption(
          text: 'Yes, from approved devices and locations',
          nextQuestionId: 'ac_drill_remote_1',
        ),
        AccessControlOption(
          text: 'Yes, but I\'m not sure of the exact rules',
          nextQuestionId: 'ac_drill_remote_2',
          indicatesUncertainty: true,
          uncertaintyArea: 'How remote access is verified',
        ),
        AccessControlOption(
          text: 'No, access is only from within our facilities',
          nextQuestionId: 'ac_baseline_4',
        ),
        AccessControlOption(
          text: 'I\'m not sure',
          nextQuestionId: 'ac_drill_remote_2',
          indicatesUncertainty: true,
          uncertaintyArea: 'How remote access is verified',
        ),
      ],
    ),

    // Drill-down for remote access (approved)
    AccessControlQuestion(
      id: 'ac_drill_remote_1',
      question:
          'How is remote access verified before someone connects to CJIS systems?',
      depth: 1,
      parentQuestionId: 'ac_baseline_3',
      category: 'remote_access',
      options: [
        AccessControlOption(
          text: 'VPN with multi-factor authentication',
          nextQuestionId: 'ac_baseline_4',
        ),
        AccessControlOption(
          text: 'Username and password only',
          nextQuestionId: 'ac_baseline_4',
          indicatesUncertainty: true,
          uncertaintyArea: 'Remote access authentication methods',
        ),
        AccessControlOption(
          text: 'I\'m not sure of the technical details',
          nextQuestionId: 'ac_baseline_4',
          indicatesUncertainty: true,
          uncertaintyArea: 'How remote access is verified',
        ),
      ],
    ),

    // Drill-down for remote access (uncertain)
    AccessControlQuestion(
      id: 'ac_drill_remote_2',
      question:
          'Is remote access handled consistently across all users who need it?',
      depth: 1,
      parentQuestionId: 'ac_baseline_3',
      category: 'remote_access',
      options: [
        AccessControlOption(
          text: 'Yes, everyone follows the same process',
          nextQuestionId: 'ac_baseline_4',
        ),
        AccessControlOption(
          text: 'Different people may have different arrangements',
          nextQuestionId: 'ac_baseline_4',
          indicatesSharedResponsibility: true,
          uncertaintyArea: 'Consistency of remote access practices',
        ),
        AccessControlOption(
          text: 'I\'m not sure',
          nextQuestionId: 'ac_baseline_4',
          indicatesUncertainty: true,
          uncertaintyArea: 'Consistency of remote access practices',
        ),
      ],
    ),

    // Baseline question 4 - Shared access
    AccessControlQuestion(
      id: 'ac_baseline_4',
      question:
          'Does each person who accesses CJIS systems have their own unique login credentials?',
      isBaseline: true,
      depth: 0,
      category: 'individual_access',
      options: [
        AccessControlOption(
          text: 'Yes, everyone has their own login',
          nextQuestionId: 'ac_reflective_1',
        ),
        AccessControlOption(
          text:
              'Most people do, but there may be some shared accounts for convenience',
          nextQuestionId: 'ac_drill_shared_accounts_1',
          indicatesUncertainty: true,
          uncertaintyArea: 'Individual accountability for CJIS access',
        ),
        AccessControlOption(
          text: 'Some systems use shared logins',
          nextQuestionId: 'ac_drill_shared_accounts_1',
          indicatesUncertainty: true,
          uncertaintyArea: 'Individual accountability for CJIS access',
        ),
        AccessControlOption(
          text: 'I\'m not sure',
          nextQuestionId: 'ac_reflective_1',
          indicatesUncertainty: true,
          uncertaintyArea: 'Individual accountability for CJIS access',
        ),
      ],
    ),

    // Drill-down for shared accounts
    AccessControlQuestion(
      id: 'ac_drill_shared_accounts_1',
      question:
          'For shared accounts, if something went wrong, could you determine which specific person was using the system at that time?',
      depth: 1,
      parentQuestionId: 'ac_baseline_4',
      category: 'individual_access',
      options: [
        AccessControlOption(
          text: 'Yes, we have other ways to track this',
          nextQuestionId: 'ac_reflective_1',
        ),
        AccessControlOption(
          text: 'It would be difficult to determine',
          nextQuestionId: 'ac_reflective_1',
          indicatesUncertainty: true,
          uncertaintyArea: 'Ability to track individual actions',
        ),
        AccessControlOption(
          text: 'No, we wouldn\'t be able to tell',
          nextQuestionId: 'ac_reflective_1',
          indicatesUncertainty: true,
          uncertaintyArea: 'Ability to track individual actions',
        ),
      ],
    ),

    // Reflective question - end of flow
    AccessControlQuestion(
      id: 'ac_reflective_1',
      question:
          'Based on your answers, were there any questions where you felt uncertain or would want to confirm with someone else?',
      isReflective: true,
      depth: 0,
      options: [
        AccessControlOption(
          text:
              'No, I feel confident about my understanding of how access control works here',
        ),
        AccessControlOption(
          text:
              'A few areas I\'d like to confirm, but nothing major',
          indicatesUncertainty: true,
          uncertaintyArea: 'Overall confidence in access control understanding',
        ),
        AccessControlOption(
          text:
              'Yes, several areas would benefit from clarification',
          indicatesUncertainty: true,
          uncertaintyArea: 'Overall confidence in access control understanding',
        ),
      ],
    ),
  ];

  /// Suggested follow-up questions based on uncertainty areas
  static const Map<String, List<String>> followUpQuestionsByArea = {
    'responsibility': [
      'Who formally approves CJIS access in your agency?',
      'Is the access approval process documented?',
      'Would agency leadership and IT describe this process the same way?',
    ],
    'access_changes': [
      'Is there a checklist or process that runs when staff leave?',
      'How is HR connected to the access removal process?',
      'When was the last time access was reviewed for accuracy?',
    ],
    'remote_access': [
      'Is remote access handled consistently across users?',
      'What authentication methods are required for remote access?',
      'Are remote devices subject to the same security requirements?',
    ],
    'individual_access': [
      'Are there any shared accounts that should be converted to individual accounts?',
      'How do you track who did what when accounts are shared?',
      'What circumstances led to shared accounts being used?',
    ],
  };

  /// Default suggested follow-up questions
  static const List<String> defaultFollowUpQuestions = [
    'Who formally approves CJIS access?',
    'Is the access change process documented?',
    'Would agency leadership and IT describe this process the same way?',
    'Is remote access handled consistently across users?',
  ];

  /// Calculate the result based on responses
  static AccessControlReflectionResult calculateResult(
    List<AccessControlResponse> responses,
  ) {
    // Count uncertainty signals
    int uncertaintyCount = 0;
    int sharedResponsibilityCount = 0;
    final Set<String> uncertaintyAreas = {};

    for (final response in responses) {
      if (response.indicatesUncertainty) {
        uncertaintyCount++;
        if (response.uncertaintyArea != null) {
          uncertaintyAreas.add(response.uncertaintyArea!);
        }
      }
      if (response.indicatesSharedResponsibility) {
        sharedResponsibilityCount++;
      }
    }

    // Determine clarity level (internal logic, not shown as score)
    ClarityLevel clarityLevel;
    if (uncertaintyCount == 0 && sharedResponsibilityCount == 0) {
      clarityLevel = ClarityLevel.generallyClear;
    } else if (uncertaintyCount <= 2) {
      clarityLevel = ClarityLevel.reviewRecommended;
    } else {
      clarityLevel = ClarityLevel.earlyClarificationRecommended;
    }

    // Determine clarification priority
    ClarificationPriority priority;
    if (uncertaintyCount == 0 && sharedResponsibilityCount == 0) {
      priority = ClarificationPriority.standard;
    } else if (uncertaintyCount <= 2 && sharedResponsibilityCount <= 1) {
      priority = ClarificationPriority.elevated;
    } else {
      priority = ClarificationPriority.focused;
    }

    // Build suggested follow-up questions based on uncertainty areas
    final List<String> followUpQuestions = [];
    for (final area in uncertaintyAreas) {
      // Find category from the area text
      for (final entry in followUpQuestionsByArea.entries) {
        if (followUpQuestions.length < 4) {
          followUpQuestions.addAll(entry.value.take(2));
        }
      }
    }

    // Fall back to defaults if no specific areas identified
    if (followUpQuestions.isEmpty) {
      followUpQuestions.addAll(defaultFollowUpQuestions);
    }

    // Build summary text
    String summaryText;
    if (clarityLevel == ClarityLevel.generallyClear) {
      summaryText =
          'Based on your responses, your understanding of access control practices appears consistent. This does not indicate compliance or non-compliance. Consider periodic reviews to ensure practices remain aligned.';
    } else if (clarityLevel == ClarityLevel.reviewRecommended) {
      summaryText =
          'Based on your responses, there are areas where additional clarification may be helpful. This does not indicate non-compliance. It highlights places where assumptions or shared responsibilities may benefit from confirmation.';
    } else {
      summaryText =
          'Based on your responses, several areas may benefit from early clarification. This does not indicate non-compliance. It suggests that confirming these practices with appropriate stakeholders could help ensure consistent understanding.';
    }

    return AccessControlReflectionResult(
      clarityLevel: clarityLevel,
      clarificationPriority: priority,
      uncertaintyAreas: uncertaintyAreas.toList(),
      suggestedFollowUpQuestions: followUpQuestions.toSet().toList().take(4).toList(),
      summaryText: summaryText,
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
}
