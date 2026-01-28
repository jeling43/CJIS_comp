import '../models/guidance_models.dart';

class GuidanceData {
  static final List<GuidanceCategory> categories = [
    const GuidanceCategory(
      id: 'access_control',
      title: 'Access Control',
      description: 'Guidelines for managing and controlling access to CJIS systems and data',
      icon: '🔐',
      keyPoints: [
        'Implement role-based access control',
        'Regular access reviews and audits',
        'Principle of least privilege',
        'Access termination procedures',
      ],
      policyReference: 'CJIS Security Policy Section 5.2',
    ),
    const GuidanceCategory(
      id: 'authentication_mfa',
      title: 'Authentication and MFA',
      description: 'Multi-factor authentication requirements and best practices',
      icon: '🔑',
      keyPoints: [
        'Two-factor authentication required',
        'Password complexity requirements',
        'Biometric authentication options',
        'Authentication token management',
      ],
      policyReference: 'CJIS Security Policy Section 5.6',
    ),
    const GuidanceCategory(
      id: 'data_storage',
      title: 'Data Storage and Encryption',
      description: 'Requirements for storing and encrypting CJIS data',
      icon: '💾',
      keyPoints: [
        'Encryption at rest requirements',
        'Encryption in transit (TLS/SSL)',
        'Key management procedures',
        'Data retention policies',
      ],
      policyReference: 'CJIS Security Policy Section 5.10',
    ),
    const GuidanceCategory(
      id: 'user_roles',
      title: 'User Roles and Least Privilege',
      description: 'Implementing least privilege and proper role assignment',
      icon: '👥',
      keyPoints: [
        'Define clear role hierarchies',
        'Separation of duties',
        'Regular privilege reviews',
        'Document role assignments',
      ],
      policyReference: 'CJIS Security Policy Section 5.2.1',
    ),
    const GuidanceCategory(
      id: 'cloud_vendor',
      title: 'Cloud and Vendor Considerations',
      description: 'Requirements for cloud services and third-party vendors',
      icon: '☁️',
      keyPoints: [
        'FBI CJIS Division approval required',
        'Security addendum requirements',
        'Vendor background checks',
        'Data location restrictions',
      ],
      policyReference: 'CJIS Security Policy Section 5.14',
    ),
    const GuidanceCategory(
      id: 'training',
      title: 'Training and Personnel Security',
      description: 'Personnel security and training requirements',
      icon: '📚',
      keyPoints: [
        'Security awareness training',
        'Background investigations',
        'Annual training requirements',
        'Incident response training',
      ],
      policyReference: 'CJIS Security Policy Section 5.1',
    ),
  ];

  static Map<String, List<GuidanceQuestion>> categoryQuestions = {
    'access_control': [
      const GuidanceQuestion(
        id: 'ac_q1',
        question: 'Does your organization have documented access control policies?',
        options: [
          AnswerOption(
            text: 'Yes, fully documented and current',
            nextQuestionId: 'ac_q2',
          ),
          AnswerOption(
            text: 'Partially documented',
            result: GuidanceResult(
              title: 'Documentation Gap Identified',
              description:
                  'Having incomplete access control documentation creates compliance risks.',
              riskAreas: [
                'Inconsistent access management',
                'Audit findings',
                'Policy enforcement challenges',
              ],
              recommendations: [
                'Complete documentation of all access control policies',
                'Define roles and responsibilities clearly',
                'Establish review and update procedures',
                'Train staff on documented policies',
              ],
              policyReference: 'CJIS Security Policy Section 5.2',
            ),
          ),
          AnswerOption(
            text: 'No documentation',
            result: GuidanceResult(
              title: 'Critical Documentation Gap',
              description:
                  'Lacking documented access control policies is a significant compliance issue.',
              riskAreas: [
                'Non-compliance with CJIS requirements',
                'Unauthorized access risks',
                'Inability to demonstrate controls',
                'Inconsistent enforcement',
              ],
              recommendations: [
                'Immediately begin documenting access control policies',
                'Review CJIS Security Policy Section 5.2 requirements',
                'Engage leadership for policy approval',
                'Implement training program',
                'Establish regular policy review cycle',
              ],
              policyReference: 'CJIS Security Policy Section 5.2',
            ),
          ),
        ],
      ),
      const GuidanceQuestion(
        id: 'ac_q2',
        question: 'How frequently do you review user access privileges?',
        options: [
          AnswerOption(
            text: 'Quarterly or more often',
            result: GuidanceResult(
              title: 'Good Access Review Practice',
              description:
                  'Regular access reviews help maintain proper access controls.',
              riskAreas: [],
              recommendations: [
                'Continue quarterly reviews',
                'Document all review findings',
                'Promptly address any issues found',
                'Consider automated review tools',
              ],
              policyReference: 'CJIS Security Policy Section 5.2',
            ),
          ),
          AnswerOption(
            text: 'Annually',
            result: GuidanceResult(
              title: 'Consider More Frequent Reviews',
              description:
                  'Annual reviews meet minimum requirements but quarterly is better.',
              riskAreas: [
                'Delayed detection of inappropriate access',
                'Longer window for privilege creep',
              ],
              recommendations: [
                'Consider increasing review frequency to quarterly',
                'Implement automated alerts for suspicious access',
                'Document review procedures clearly',
                'Train reviewers on what to look for',
              ],
              policyReference: 'CJIS Security Policy Section 5.2',
            ),
          ),
          AnswerOption(
            text: 'Less than annually or never',
            result: GuidanceResult(
              title: 'Insufficient Access Review',
              description:
                  'Infrequent or absent access reviews create significant security risks.',
              riskAreas: [
                'Accumulated inappropriate access',
                'Non-compliance with CJIS requirements',
                'Increased insider threat risk',
                'Audit findings',
              ],
              recommendations: [
                'Immediately implement at least annual reviews',
                'Conduct comprehensive access audit',
                'Remove all inappropriate access',
                'Document review procedures',
                'Assign responsibility for reviews',
                'Work toward quarterly review cycle',
              ],
              policyReference: 'CJIS Security Policy Section 5.2',
            ),
          ),
        ],
      ),
    ],
    'authentication_mfa': [
      const GuidanceQuestion(
        id: 'mfa_q1',
        question:
            'Is multi-factor authentication (MFA) implemented for all CJIS system access?',
        options: [
          AnswerOption(
            text: 'Yes, for all users',
            nextQuestionId: 'mfa_q2',
          ),
          AnswerOption(
            text: 'Only for remote access',
            result: GuidanceResult(
              title: 'Partial MFA Implementation',
              description:
                  'CJIS requires MFA for all access, not just remote access.',
              riskAreas: [
                'Non-compliance with CJIS MFA requirements',
                'Increased risk from local access',
                'Inconsistent security posture',
              ],
              recommendations: [
                'Extend MFA to all CJIS system access',
                'Review CJIS Security Policy Section 5.6',
                'Plan phased rollout if needed',
                'Provide user training on MFA',
                'Test MFA implementation thoroughly',
              ],
              policyReference: 'CJIS Security Policy Section 5.6',
            ),
          ),
          AnswerOption(
            text: 'No MFA implemented',
            result: GuidanceResult(
              title: 'Critical MFA Gap',
              description:
                  'Lacking MFA is a serious CJIS compliance violation.',
              riskAreas: [
                'Direct non-compliance with CJIS',
                'High risk of unauthorized access',
                'Credential theft vulnerabilities',
                'Potential compliance suspension',
              ],
              recommendations: [
                'Immediately prioritize MFA implementation',
                'Review CJIS Security Policy Section 5.6 requirements',
                'Select appropriate MFA solution',
                'Plan implementation timeline',
                'Budget for MFA solution if needed',
                'Notify CJIS authorities of remediation plan',
              ],
              policyReference: 'CJIS Security Policy Section 5.6',
            ),
          ),
        ],
      ),
      const GuidanceQuestion(
        id: 'mfa_q2',
        question: 'What type of MFA factors are you using?',
        options: [
          AnswerOption(
            text: 'Hardware tokens or biometrics',
            result: GuidanceResult(
              title: 'Strong MFA Implementation',
              description:
                  'Hardware tokens and biometrics provide strong authentication.',
              riskAreas: [],
              recommendations: [
                'Continue using strong MFA factors',
                'Maintain backup authentication methods',
                'Document MFA procedures',
                'Regularly review MFA logs',
                'Keep MFA systems updated',
              ],
              policyReference: 'CJIS Security Policy Section 5.6',
            ),
          ),
          AnswerOption(
            text: 'SMS or email codes',
            result: GuidanceResult(
              title: 'Consider Stronger MFA',
              description:
                  'SMS/email codes are acceptable but stronger methods are recommended.',
              riskAreas: [
                'SIM swapping attacks',
                'Email account compromise',
                'Network interception risks',
              ],
              recommendations: [
                'Consider upgrading to app-based authenticators',
                'Evaluate hardware token options',
                'Implement additional security monitoring',
                'Educate users on phishing risks',
                'Plan migration to stronger MFA',
              ],
              policyReference: 'CJIS Security Policy Section 5.6',
            ),
          ),
        ],
      ),
    ],
  };

  static GuidanceCategory? getCategoryById(String id) {
    try {
      return categories.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<GuidanceQuestion>? getQuestionsForCategory(String categoryId) {
    return categoryQuestions[categoryId];
  }
}
