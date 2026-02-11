import '../models/guidance_models.dart';

class GuidanceData {
  static final List<GuidanceCategory> categories = [
    const GuidanceCategory(
      id: 'access_control',
      title: 'Access Control',
      description:
          'Guidelines for managing and controlling access to CJIS systems and data',
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
          plainLanguageInterpretation:
              'Access Control requires agencies to limit system and data access to authorized users only, implement role-based permissions, and regularly review who has access to what.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.2.1',
          plainLanguageInterpretation:
              'Identification and Authentication ensures each user has a unique identifier and proper authentication before accessing CJIS systems.',
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
          description:
              'Multiple users sharing a single login defeats accountability and audit trails',
        ),
        CommonFailurePattern(
          pattern: 'Orphaned accounts',
          description:
              'Former employees or transferred staff retaining system access',
        ),
        CommonFailurePattern(
          pattern: 'Over-provisioned permissions',
          description:
              'Users having broader access than needed for their job functions',
        ),
        CommonFailurePattern(
          pattern: 'Infrequent access reviews',
          description:
              'Failing to periodically verify that user access remains appropriate',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen:
            'Your agency has high staff turnover, uses contractor personnel, or has interconnected systems with multiple access points',
        lowerRiskWhen:
            'You have a stable workforce, clear role definitions, and automated access management tools',
      ),
      guidedPrompts: GuidedPrompts(
        introduction:
            'These plain-language questions help you understand how access to CJIS systems works in practice. Questions are designed to surface assumptions, clarify responsibility, and highlight common risk areas without requiring technical knowledge. There are no right or wrong answers. "Not sure" is a valid response and often indicates an area that may need follow-up.',
        sections: [
          GuidedPromptSection(
            title: 'Who uses CJIS systems',
            questions: [
              'Who in your agency uses CJIS systems as part of their job?',
              'Are there people who still have CJIS access but rarely need it?',
              'If someone\'s job changed, would their CJIS access change automatically?',
            ],
            context: 'If you\'re unsure, that\'s useful to know.',
          ),
          GuidedPromptSection(
            title: 'Individual access vs shared access',
            questions: [
              'Does each person use their own login to access CJIS systems?',
              'Are shared logins ever used to save time during busy periods?',
              'If something went wrong, could you tell which person accessed CJIS data?',
            ],
            context: 'Shared access is common in small agencies. These questions help clarify how access is actually used.',
          ),
          GuidedPromptSection(
            title: 'How people get to CJIS systems',
            questions: [
              'Do people access CJIS systems only from inside the building, or also from home or remotely?',
              'Once someone is connected, can they reach CJIS systems right away?',
              'If someone can access email or reports, does that same access allow them to reach CJIS systems?',
            ],
            context: 'If the answer depends on the situation, that\'s worth exploring further.',
          ),
          GuidedPromptSection(
            title: 'Booking and records computers',
            questions: [
              'Is there a computer used for booking or records that accesses CJIS data?',
              'Can that same computer also be used to browse the internet or check email?',
              'Is that computer shared by more than one person?',
            ],
            context: 'Mixed-use computers are common and can create access paths people don\'t always think about.',
          ),
          GuidedPromptSection(
            title: 'Shared printers and other devices',
            questions: [
              'Is the printer used for CJIS-related work shared with other computers?',
              'Can computers that do not access CJIS data send jobs to that printer?',
              'Are scanners, shared folders, or other tools connected to CJIS computers also used elsewhere?',
            ],
            context: 'Shared devices can connect systems in ways that aren\'t obvious.',
          ),
          GuidedPromptSection(
            title: 'Other access paths',
            questions: [
              'Can another computer connect to a CJIS computer to help with troubleshooting or support?',
              'Are there tools that allow remote access to CJIS computers?',
              'If another computer on the network had a problem, could it reach CJIS systems?',
            ],
            context: 'These questions help identify access paths that exist for convenience.',
          ),
          GuidedPromptSection(
            title: 'Who is responsible',
            questions: [
              'Who decides which people or systems are allowed to access CJIS systems?',
              'Is that decision made by your agency, central IT, a vendor, or more than one group?',
              'If something needed to change, would you know who to contact?',
            ],
            context: 'Unclear responsibility is common and important to identify.',
          ),
          GuidedPromptSection(
            title: 'When access should change',
            questions: [
              'What happens to CJIS access when someone changes roles?',
              'What happens when someone leaves the agency?',
              'How quickly would access be removed?',
            ],
            context: 'Delays often happen when responsibility is unclear.',
          ),
          GuidedPromptSection(
            title: 'Consistency check',
            questions: [
              'If you asked three different people these questions, would you expect the same answers?',
              'Are these answers written down anywhere, or based on how things have always worked?',
            ],
            context: 'Different answers often point to hidden risk.',
          ),
        ],
        higherRiskSituations: [
          'CJIS computers used for general browsing or email',
          'Shared printers or devices connecting CJIS and non-CJIS systems',
          'Access rules that are assumed rather than confirmed',
          'Responsibility split across teams without clear ownership',
        ],
        lowerRiskSituations: [
          'CJIS access limited to specific roles and systems',
          'Shared devices intentionally restricted or reviewed',
          'Clear understanding of who controls access decisions',
          'Access changes handled consistently and promptly',
        ],
        policySections: ['5.5', '5.6', '5.10'],
      ),
    ),
    const GuidanceCategory(
      id: 'authentication_mfa',
      title: 'Authentication and MFA',
      description:
          'Multi-factor authentication requirements and best practices',
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
          plainLanguageInterpretation:
              'Advanced Authentication (AA) mandates multi-factor authentication for all access to CJIS systems, combining something you know (password) with something you have (token) or something you are (biometric).',
        ),
        CJISPolicyReference(
          sectionNumber: '5.6.2.2',
          plainLanguageInterpretation:
              'Specifies acceptable authentication factors including hardware tokens, software tokens, biometrics, and out-of-band authentication methods.',
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
          description:
              'Implementing MFA for VPN users but not for local network access',
        ),
        CommonFailurePattern(
          pattern: 'Weak second factors',
          description:
              'Relying solely on SMS codes which are vulnerable to SIM swapping attacks',
        ),
        CommonFailurePattern(
          pattern: 'MFA fatigue attacks',
          description:
              'Lack of rate limiting on MFA prompts allowing attackers to spam users until they approve',
        ),
        CommonFailurePattern(
          pattern: 'No backup authentication',
          description:
              'Failing to provide secure backup methods when primary MFA device is unavailable',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen:
            'Your agency allows remote access, has interconnected systems, or has experienced password-related security incidents',
        lowerRiskWhen:
            'You have implemented hardware tokens or biometric authentication with proper backup procedures',
      ),
      guidedPrompts: GuidedPrompts(
        introduction:
            'These questions help you think through how people prove who they are when accessing CJIS systems. There are no right or wrong answers. "Not sure" is a valid response and often highlights an area worth exploring with IT or leadership.',
        sections: [
          GuidedPromptSection(
            title: 'How people log in',
            questions: [
              'When someone logs into a CJIS system, do they use just a password, or is there an extra step like a code or card?',
              'If you\'re not sure whether there\'s an extra step, who would you ask to find out?',
            ],
            context: 'An extra step beyond a password is often called multi-factor authentication. If you\'re unsure what\'s in place, that\'s worth clarifying.',
          ),
          GuidedPromptSection(
            title: 'Logging in from different places',
            questions: [
              'Does logging in work the same way whether someone is at the office or working from home?',
              'If there\'s a difference, do you know why?',
            ],
            context: 'Sometimes extra security is only used remotely. Understanding the difference helps clarify what\'s protected.',
          ),
          GuidedPromptSection(
            title: 'When the usual method doesn\'t work',
            questions: [
              'If someone loses their phone or card, how do they get back into the system?',
              'Has this situation come up before, and how was it handled?',
            ],
            context: 'Backup options are important. If there\'s no clear process, access could be delayed—or shortcuts might be used.',
          ),
          GuidedPromptSection(
            title: 'Passwords and updates',
            questions: [
              'Are people asked to change their password regularly, or do passwords stay the same for a long time?',
              'If someone forgot their password, how would they reset it?',
            ],
            context: 'Password habits can affect security. If passwords rarely change or resets are informal, that\'s useful to know.',
          ),
          GuidedPromptSection(
            title: 'Who manages authentication',
            questions: [
              'Who decides how logins work—your agency, central IT, or a vendor?',
              'If you wanted to change how logins work, would you know who to contact?',
            ],
            context: 'Knowing who controls authentication helps when questions or changes come up.',
          ),
        ],
        higherRiskSituations: [
          'Only a password is used to access CJIS systems',
          'Remote access works differently from in-office access with no clear reason',
          'No backup plan exists when the usual login method fails',
          'Passwords rarely change or are shared among staff',
        ],
        lowerRiskSituations: [
          'An extra step like a code or card is required for all logins',
          'There\'s a clear backup process if someone can\'t log in the usual way',
          'Password changes happen regularly and resets follow a defined process',
          'There\'s a clear understanding of who manages login security',
        ],
        policySections: ['5.6', '5.6.2.2'],
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
          plainLanguageInterpretation:
              'Information Exchange requires encryption of CJIS data in transit using TLS 1.2 or higher, protecting data as it moves between systems or across networks.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.10.1.2',
          plainLanguageInterpretation:
              'Specifies encryption standards for data at rest, requiring FIPS 140-2 validated encryption modules when storing CJIS data.',
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
          description:
              'Database backups stored on tapes or drives without encryption',
        ),
        CommonFailurePattern(
          pattern: 'Outdated TLS versions',
          description: 'Using TLS 1.0 or 1.1 which have known vulnerabilities',
        ),
        CommonFailurePattern(
          pattern: 'Keys stored with encrypted data',
          description:
              'Encryption keys stored on the same system as the encrypted data',
        ),
        CommonFailurePattern(
          pattern: 'No encryption for mobile devices',
          description:
              'Laptops, tablets, or mobile devices containing CJIS data without full-disk encryption',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen:
            'Your agency uses mobile devices, creates frequent backups, or exchanges data with multiple external agencies',
        lowerRiskWhen:
            'All storage is encrypted, you use centralized key management, and have documented encryption procedures',
      ),
      guidedPrompts: GuidedPrompts(
        introduction:
            'These questions help you think through how CJIS data is stored and protected. There are no right or wrong answers. "Not sure" is a valid response and often indicates an area worth discussing with IT.',
        sections: [
          GuidedPromptSection(
            title: 'Where data is stored',
            questions: [
              'Do you know where CJIS data is stored—on local computers, a server, or somewhere in the cloud?',
              'If data is stored in multiple places, are you confident all locations are equally protected?',
            ],
            context: 'Knowing where data lives is the first step to understanding how it\'s protected.',
          ),
          GuidedPromptSection(
            title: 'Laptops and mobile devices',
            questions: [
              'Are there laptops, tablets, or phones that can access or store CJIS data?',
              'If a device were lost or stolen, would the data on it be protected?',
            ],
            context: 'Mobile devices are convenient but can be lost. If you\'re unsure how they\'re protected, it\'s worth asking.',
          ),
          GuidedPromptSection(
            title: 'Backups and copies',
            questions: [
              'Are backups made of CJIS data, and do you know where those backups are kept?',
              'Are backups protected the same way as the original data?',
            ],
            context: 'Backups are often overlooked. If they\'re stored on tapes or drives without protection, that\'s a potential gap.',
          ),
          GuidedPromptSection(
            title: 'Sending data to others',
            questions: [
              'When CJIS data is sent to another agency or system, do you know if it\'s protected during transfer?',
              'Is email ever used to send CJIS-related information?',
            ],
            context: 'Data can be exposed while moving between systems. If email is used, that\'s worth exploring further.',
          ),
          GuidedPromptSection(
            title: 'Old data and disposal',
            questions: [
              'When computers or drives are replaced, what happens to the CJIS data that was on them?',
              'Is there a clear process for erasing or destroying old storage devices?',
            ],
            context: 'Old equipment can still contain sensitive data. A clear disposal process helps prevent accidental exposure.',
          ),
        ],
        higherRiskSituations: [
          'CJIS data is stored in multiple locations without consistent protection',
          'Laptops or mobile devices can access CJIS data and may not be protected if lost',
          'Backups are made but not protected the same way as the original data',
          'Email is used to send CJIS-related information',
        ],
        lowerRiskSituations: [
          'There\'s a clear understanding of where CJIS data is stored',
          'Mobile devices are protected and there\'s a plan if one is lost',
          'Backups are protected and stored securely',
          'Old equipment is erased or destroyed before disposal',
        ],
        policySections: ['5.10', '5.10.1.2'],
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
          plainLanguageInterpretation:
              'Identification and Authentication requires unique user accounts and ensures users only have access to the information and functions they need for their specific job duties.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.2.2',
          plainLanguageInterpretation:
              'Password Policy establishes minimum standards for password strength and management tied to user roles and responsibilities.',
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
          description:
              'Granting administrative privileges to users who only need standard access',
        ),
        CommonFailurePattern(
          pattern: 'Role accumulation',
          description:
              'Users accumulating permissions over time as they change positions without revoking old access',
        ),
        CommonFailurePattern(
          pattern: 'No separation of critical functions',
          description:
              'Same person able to both create and approve sensitive actions',
        ),
        CommonFailurePattern(
          pattern: 'Generic role definitions',
          description:
              'Overly broad roles like "Officer" that don\'t distinguish between different functional needs',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen:
            'Your agency has complex workflows, multiple job functions, or shared systems with other departments',
        lowerRiskWhen:
            'Roles are well-documented, regularly reviewed, and aligned with specific job functions',
      ),
      guidedPrompts: GuidedPrompts(
        introduction:
            'These questions help you think through who can do what in your CJIS systems. There are no right or wrong answers. "Not sure" is a valid response and often points to areas worth reviewing.',
        sections: [
          GuidedPromptSection(
            title: 'Who can access what',
            questions: [
              'Does everyone who uses CJIS systems have the same level of access, or does it vary by job?',
              'If access varies, how is it decided who gets which level?',
            ],
            context: 'When everyone has the same access, it\'s harder to limit what someone can reach if there\'s a problem.',
          ),
          GuidedPromptSection(
            title: 'Changes in roles',
            questions: [
              'When someone moves to a different position, does their access change to match?',
              'Could someone who changed roles still access things they no longer need?',
            ],
            context: 'Access that doesn\'t change when roles change can create gaps. If you\'re not sure, that\'s worth checking.',
          ),
          GuidedPromptSection(
            title: 'Sensitive actions',
            questions: [
              'Are there actions in the system that require approval or a second person to complete?',
              'Could one person both create and approve something sensitive without anyone else involved?',
            ],
            context: 'Separating responsibilities helps catch mistakes and prevent misuse.',
          ),
          GuidedPromptSection(
            title: 'Reviewing access',
            questions: [
              'Is there ever a review to check whether people still need the access they have?',
              'If there\'s no regular review, how would you know if someone has more access than they need?',
            ],
            context: 'Periodic reviews help ensure access stays appropriate as people and jobs change.',
          ),
          GuidedPromptSection(
            title: 'Documentation',
            questions: [
              'Is there a written list or record of what access each role or person has?',
              'If you needed to explain who has access to what, could you find that information easily?',
            ],
            context: 'Written records make it easier to answer questions and spot issues.',
          ),
        ],
        higherRiskSituations: [
          'Everyone has the same level of access regardless of job function',
          'Access doesn\'t change when someone\'s role changes',
          'One person can complete sensitive actions without oversight',
          'There\'s no regular review of who has access to what',
        ],
        lowerRiskSituations: [
          'Access is based on what each role actually needs',
          'Access changes when someone moves to a new position',
          'Sensitive actions require approval or a second person',
          'There\'s a written record of who has access to what',
        ],
        policySections: ['5.2.1', '5.2.2'],
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
          plainLanguageInterpretation:
              'Private Contractor/Non-Criminal Justice Agency (NCJ) requires agencies to ensure all vendors, contractors, and cloud service providers handling CJIS data meet the same security standards as law enforcement agencies.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.14.1.1',
          plainLanguageInterpretation:
              'Cloud service providers must be FBI CJIS approved and have a signed CJIS Security Addendum documenting their compliance obligations.',
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
          description:
              'Using Dropbox, Google Drive, or similar services for CJIS data without FBI approval',
        ),
        CommonFailurePattern(
          pattern: 'Missing security addendum',
          description:
              'Contracting with vendors without executing the required CJIS Security Addendum',
        ),
        CommonFailurePattern(
          pattern: 'Incomplete vendor vetting',
          description:
              'Not verifying vendor employee background checks and security training',
        ),
        CommonFailurePattern(
          pattern: 'Third-party integrations',
          description:
              'Allowing software plugins or integrations that access CJIS data without proper evaluation',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen:
            'Your agency relies on cloud services, uses many third-party applications, or has limited in-house IT resources',
        lowerRiskWhen:
            'You maintain an approved vendor list, have documented evaluation processes, and regularly audit vendor compliance',
      ),
      guidedPrompts: GuidedPrompts(
        introduction:
            'These questions help you think through how outside companies and cloud services fit into your CJIS environment. There are no right or wrong answers. "Not sure" is a valid response and often highlights areas worth discussing with IT or leadership.',
        sections: [
          GuidedPromptSection(
            title: 'Outside companies and services',
            questions: [
              'Does your agency use any cloud services or outside companies to store, access, or manage CJIS data?',
              'If you\'re not sure, who would know?',
            ],
            context: 'Cloud services and vendors are common. Knowing who handles your data is the first step to understanding risk.',
          ),
          GuidedPromptSection(
            title: 'Vendor access to data',
            questions: [
              'Do any vendors or IT support staff outside your agency have access to CJIS systems or data?',
              'If so, do you know whether they went through background checks?',
            ],
            context: 'Anyone who touches CJIS data should meet certain standards. If you\'re unsure, it\'s worth verifying.',
          ),
          GuidedPromptSection(
            title: 'Agreements and approvals',
            questions: [
              'When your agency starts using a new service or vendor, is there a process to review whether it\'s appropriate for CJIS data?',
              'Are there signed agreements in place that address security responsibilities?',
            ],
            context: 'Written agreements help clarify who is responsible for what. If you don\'t know if they exist, that\'s useful to find out.',
          ),
          GuidedPromptSection(
            title: 'Where data is located',
            questions: [
              'Do you know where your CJIS data is physically stored—whether it\'s in your building, a data center, or somewhere else?',
              'If data is stored outside your agency, do you know which company or location?',
            ],
            context: 'Data location matters for legal and security reasons. If it\'s unclear, it\'s worth clarifying.',
          ),
          GuidedPromptSection(
            title: 'Ongoing oversight',
            questions: [
              'Once a vendor or service is in use, does anyone check whether they continue to meet security expectations?',
              'If a vendor had a security incident, how would you find out?',
            ],
            context: 'Ongoing oversight helps catch problems before they affect your agency.',
          ),
        ],
        higherRiskSituations: [
          'Vendors or cloud services access CJIS data without background checks',
          'No signed agreements address security responsibilities',
          'Data location is unknown or unclear',
          'There\'s no ongoing review of vendor security practices',
        ],
        lowerRiskSituations: [
          'There\'s a clear list of which vendors and services handle CJIS data',
          'Vendor staff who access CJIS data have completed background checks',
          'Written agreements address security responsibilities',
          'Someone checks on vendor security practices periodically',
        ],
        policySections: ['5.14', '5.14.1.1'],
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
          plainLanguageInterpretation:
              'Information Exchange Agreements and Interconnection Security Agreements establish responsibilities for training personnel who access CJIS systems.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.5',
          plainLanguageInterpretation:
              'Security Awareness Training requires annual training for all personnel with access to CJIS data on security policies, procedures, and their responsibilities.',
        ),
        CJISPolicyReference(
          sectionNumber: '5.12',
          plainLanguageInterpretation:
              'Personnel Security outlines background check requirements and ongoing security vetting for anyone with access to CJIS systems.',
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
          description:
              'Providing training during onboarding but not conducting required annual refresher training',
        ),
        CommonFailurePattern(
          pattern: 'Generic security training',
          description:
              'Using general security training instead of CJIS-specific content',
        ),
        CommonFailurePattern(
          pattern: 'Incomplete background checks',
          description:
              'Not conducting fingerprint-based background checks for all personnel with CJIS access',
        ),
        CommonFailurePattern(
          pattern: 'No training documentation',
          description:
              'Failing to document who completed training and when, making audit compliance difficult',
        ),
      ],
      priorityGuidance: PriorityGuidance(
        higherRiskWhen:
            'Your agency has high staff turnover, uses contractors or part-time personnel, or has experienced security incidents',
        lowerRiskWhen:
            'You have formalized training programs, documented completion tracking, and regular reinforcement of security practices',
      ),
      guidedPrompts: GuidedPrompts(
        introduction:
            'These questions help you think through how your agency prepares people to work with CJIS systems. There are no right or wrong answers. "Not sure" is a valid response and often points to areas worth reviewing.',
        sections: [
          GuidedPromptSection(
            title: 'Security training',
            questions: [
              'Do people who access CJIS systems receive training on security practices?',
              'Is training a one-time event, or does it happen regularly?',
            ],
            context: 'Regular training helps people remember what to do—and what not to do.',
          ),
          GuidedPromptSection(
            title: 'Background checks',
            questions: [
              'Does everyone with access to CJIS systems go through a background check?',
              'If someone joined recently, would you know whether their background check was completed before they got access?',
            ],
            context: 'Background checks help ensure people are cleared before they access sensitive data.',
          ),
          GuidedPromptSection(
            title: 'New staff and role changes',
            questions: [
              'When someone new joins or changes roles, is there a process to ensure they receive the right training?',
              'How quickly does training happen after someone starts?',
            ],
            context: 'Delays in training can leave gaps. If there\'s no clear process, that\'s worth exploring.',
          ),
          GuidedPromptSection(
            title: 'Tracking and records',
            questions: [
              'Is there a record of who has completed training and when?',
              'If someone asked for proof of training, could you find it easily?',
            ],
            context: 'Good records make it easier to answer questions and stay on track.',
          ),
          GuidedPromptSection(
            title: 'Responding to problems',
            questions: [
              'If something went wrong—like a suspicious email or a potential breach—would staff know what to do?',
              'Is there a clear person or process to report security concerns to?',
            ],
            context: 'Knowing how to respond to problems helps limit damage when issues arise.',
          ),
        ],
        higherRiskSituations: [
          'Training only happens once and isn\'t repeated',
          'Background checks aren\'t completed before people get access',
          'There\'s no clear record of who has been trained',
          'Staff wouldn\'t know what to do if something went wrong',
        ],
        lowerRiskSituations: [
          'Training happens regularly for everyone with CJIS access',
          'Background checks are completed before access is granted',
          'There\'s a clear record of training completion',
          'Staff know how to report security concerns',
        ],
        policySections: ['5.1', '5.5', '5.12'],
      ),
    ),
  ];

  static Map<String, List<GuidanceQuestion>> categoryQuestions = {
    'access_control': [
      const GuidanceQuestion(
        id: 'ac_q1',
        question:
            'Does your organization have documented access control policies?',
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
