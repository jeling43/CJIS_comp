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
      cjisPolicyReferences: [
        CJISPolicyReference(
          sectionNumber: '5.2',
          plainLanguageInterpretation: 'Access Control requires agencies to limit system and data access to authorized users only, implement role-based permissions, and regularly review who has access to what.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.2.1',
          plainLanguageInterpretation: 'Identification and Authentication ensures each user has a unique identifier and proper authentication before accessing CJIS systems.',
        ),
      ],
      riskContext: RiskContext(
        title: 'Why this matters',
        riskPoints: [
          'Unauthorized access to criminal justice information can compromise ongoing investigations and public safety',
          'Improper access controls increase the risk of data breaches and potential legal liability',
          'Lack of proper user accountability makes it difficult to track who accessed what information and when',
          'Overly permissive access creates insider threat vulnerabilities',
        ],
      ),
      commonFailures: [
        CommonFailurePattern(
          pattern: 'Shared accounts',
          description: 'Multiple users sharing a single login defeats accountability and audit trails',
        ),
        CommonFailurePattern(
          pattern: 'Orphaned accounts',
          description: 'Former employees or transferred staff retaining system access',
        ),
        CommonFailurePattern(
          pattern: 'Over-provisioned permissions',
          description: 'Users having broader access than needed for their job functions',
        ),
        CommonFailurePattern(
          pattern: 'Infrequent access reviews',
          description: 'Failing to periodically verify that user access remains appropriate',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen: 'Your agency has high staff turnover, uses contractor personnel, or has interconnected systems with multiple access points',
        lowerRiskWhen: 'You have a stable workforce, clear role definitions, and automated access management tools',
      ),
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
      cjisPolicyReferences: [
        CJISPolicyReference(
          sectionNumber: '5.6',
          plainLanguageInterpretation: 'Advanced Authentication (AA) mandates multi-factor authentication for all access to CJIS systems, combining something you know (password) with something you have (token) or something you are (biometric).',
        ),
        CJISPolicyReference(
          sectionNumber: '5.6.2.2',
          plainLanguageInterpretation: 'Specifies acceptable authentication factors including hardware tokens, software tokens, biometrics, and out-of-band authentication methods.',
        ),
      ],
      riskContext: RiskContext(
        title: 'Risk if ignored',
        riskPoints: [
          'Single-factor authentication (password only) is vulnerable to phishing, credential stuffing, and password reuse attacks',
          'Compromised credentials can lead to unauthorized access to sensitive criminal justice data',
          'Non-compliance with MFA requirements can result in loss of CJIS access for your entire agency',
          'Weak authentication increases the likelihood of a data breach with significant legal and reputational consequences',
        ],
      ),
      commonFailures: [
        CommonFailurePattern(
          pattern: 'MFA only for remote access',
          description: 'Implementing MFA for VPN users but not for local network access',
        ),
        CommonFailurePattern(
          pattern: 'Weak second factors',
          description: 'Relying solely on SMS codes which are vulnerable to SIM swapping attacks',
        ),
        CommonFailurePattern(
          pattern: 'MFA fatigue attacks',
          description: 'Lack of rate limiting on MFA prompts allowing attackers to spam users until they approve',
        ),
        CommonFailurePattern(
          pattern: 'No backup authentication',
          description: 'Failing to provide secure backup methods when primary MFA device is unavailable',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen: 'Your agency allows remote access, has interconnected systems, or has experienced password-related security incidents',
        lowerRiskWhen: 'You have implemented hardware tokens or biometric authentication with proper backup procedures',
      ),
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
      cjisPolicyReferences: [
        CJISPolicyReference(
          sectionNumber: '5.10',
          plainLanguageInterpretation: 'Information Exchange requires encryption of CJIS data in transit using TLS 1.2 or higher, protecting data as it moves between systems or across networks.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.10.1.2',
          plainLanguageInterpretation: 'Specifies encryption standards for data at rest, requiring FIPS 140-2 validated encryption modules when storing CJIS data.',
        ),
      ],
      riskContext: RiskContext(
        title: 'Why this matters',
        riskPoints: [
          'Unencrypted CJIS data at rest can be accessed if storage media is stolen, lost, or improperly disposed',
          'Data transmitted without encryption can be intercepted and read by unauthorized parties',
          'Poor key management can render encryption ineffective if keys are compromised or easily guessed',
          'Data retention violations can lead to compliance issues and increased liability from retaining data longer than necessary',
        ],
      ),
      commonFailures: [
        CommonFailurePattern(
          pattern: 'Unencrypted backup media',
          description: 'Database backups stored on tapes or drives without encryption',
        ),
        CommonFailurePattern(
          pattern: 'Outdated TLS versions',
          description: 'Using TLS 1.0 or 1.1 which have known vulnerabilities',
        ),
        CommonFailurePattern(
          pattern: 'Keys stored with encrypted data',
          description: 'Encryption keys stored on the same system as the encrypted data',
        ),
        CommonFailurePattern(
          pattern: 'No encryption for mobile devices',
          description: 'Laptops, tablets, or mobile devices containing CJIS data without full-disk encryption',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen: 'Your agency uses mobile devices, creates frequent backups, or exchanges data with multiple external agencies',
        lowerRiskWhen: 'All storage is encrypted, you use centralized key management, and have documented encryption procedures',
      ),
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
      cjisPolicyReferences: [
        CJISPolicyReference(
          sectionNumber: '5.2.1',
          plainLanguageInterpretation: 'Identification and Authentication requires unique user accounts and ensures users only have access to the information and functions they need for their specific job duties.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.2.2',
          plainLanguageInterpretation: 'Password Policy establishes minimum standards for password strength and management tied to user roles and responsibilities.',
        ),
      ],
      riskContext: RiskContext(
        title: 'Why this matters',
        riskPoints: [
          'Excessive privileges increase the blast radius if an account is compromised',
          'Users with more access than needed create unnecessary insider threat risk',
          'Lack of separation of duties enables fraud and makes it harder to detect policy violations',
          'Poorly defined roles lead to inconsistent access patterns and difficulty managing permissions at scale',
        ],
      ),
      commonFailures: [
        CommonFailurePattern(
          pattern: 'Admin rights for everyone',
          description: 'Granting administrative privileges to users who only need standard access',
        ),
        CommonFailurePattern(
          pattern: 'Role accumulation',
          description: 'Users accumulating permissions over time as they change positions without revoking old access',
        ),
        CommonFailurePattern(
          pattern: 'No separation of critical functions',
          description: 'Same person able to both create and approve sensitive actions',
        ),
        CommonFailurePattern(
          pattern: 'Generic role definitions',
          description: 'Overly broad roles like "Officer" that don\'t distinguish between different functional needs',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen: 'Your agency has complex workflows, multiple job functions, or shared systems with other departments',
        lowerRiskWhen: 'Roles are well-documented, regularly reviewed, and aligned with specific job functions',
      ),
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
      cjisPolicyReferences: [
        CJISPolicyReference(
          sectionNumber: '5.14',
          plainLanguageInterpretation: 'Private Contractor/Non-Criminal Justice Agency (NCJ) requires agencies to ensure all vendors, contractors, and cloud service providers handling CJIS data meet the same security standards as law enforcement agencies.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.14.1.1',
          plainLanguageInterpretation: 'Cloud service providers must be FBI CJIS approved and have a signed CJIS Security Addendum documenting their compliance obligations.',
        ),
      ],
      riskContext: RiskContext(
        title: 'Risk if ignored',
        riskPoints: [
          'Unapproved vendors may not meet CJIS security standards, exposing data to breaches',
          'Cloud providers without proper agreements shift liability and compliance risk to your agency',
          'Vendor personnel without proper background checks may access sensitive criminal justice data',
          'Data stored outside authorized locations may violate state, federal, and CJIS requirements',
        ],
      ),
      commonFailures: [
        CommonFailurePattern(
          pattern: 'Consumer cloud services',
          description: 'Using Dropbox, Google Drive, or similar services for CJIS data without FBI approval',
        ),
        CommonFailurePattern(
          pattern: 'Missing security addendum',
          description: 'Contracting with vendors without executing the required CJIS Security Addendum',
        ),
        CommonFailurePattern(
          pattern: 'Incomplete vendor vetting',
          description: 'Not verifying vendor employee background checks and security training',
        ),
        CommonFailurePattern(
          pattern: 'Third-party integrations',
          description: 'Allowing software plugins or integrations that access CJIS data without proper evaluation',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen: 'Your agency relies on cloud services, uses many third-party applications, or has limited in-house IT resources',
        lowerRiskWhen: 'You maintain an approved vendor list, have documented evaluation processes, and regularly audit vendor compliance',
      ),
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
      cjisPolicyReferences: [
        CJISPolicyReference(
          sectionNumber: '5.1',
          plainLanguageInterpretation: 'Information Exchange Agreements and Interconnection Security Agreements establish responsibilities for training personnel who access CJIS systems.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.5',
          plainLanguageInterpretation: 'Security Awareness Training requires annual training for all personnel with access to CJIS data on security policies, procedures, and their responsibilities.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.12',
          plainLanguageInterpretation: 'Personnel Security outlines background check requirements and ongoing security vetting for anyone with access to CJIS systems.',
        ),
      ],
      riskContext: RiskContext(
        title: 'Why this matters',
        riskPoints: [
          'Untrained users are more likely to fall victim to phishing and social engineering attacks',
          'Personnel without proper background checks may pose insider threat risks',
          'Lack of awareness training leads to inadvertent policy violations and security incidents',
          'Inadequate incident response training delays detection and containment of security events',
        ],
      ),
      commonFailures: [
        CommonFailurePattern(
          pattern: 'One-time training only',
          description: 'Providing training during onboarding but not conducting required annual refresher training',
        ),
        CommonFailurePattern(
          pattern: 'Generic security training',
          description: 'Using general security training instead of CJIS-specific content',
        ),
        CommonFailurePattern(
          pattern: 'Incomplete background checks',
          description: 'Not conducting fingerprint-based background checks for all personnel with CJIS access',
        ),
        CommonFailurePattern(
          pattern: 'No training documentation',
          description: 'Failing to document who completed training and when, making audit compliance difficult',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen: 'Your agency has high staff turnover, uses contractors or part-time personnel, or has experienced security incidents',
        lowerRiskWhen: 'You have formalized training programs, documented completion tracking, and regular reinforcement of security practices',
      ),
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
