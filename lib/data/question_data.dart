import '../models/question_models.dart';

/// Predefined question flows for Access Control and Authentication & MFA
class QuestionData {
  // ─── Domains ──────────────────────────────────────────────────────────────

  static const List<Domain> domains = [
    Domain(id: 'access_control', title: 'Access Control', icon: '🔐'),
    Domain(id: 'auth_mfa', title: 'Authentication & MFA', icon: '🔑'),
  ];

  // ─── Access Control Flow ─────────────────────────────────────────────────

  static final DomainFlow accessControlFlow = DomainFlow(
    domainId: 'access_control',
    primaryQuestionIds: [
      'ac_q1',
      'ac_q2',
      'ac_q3',
      'ac_q4',
      'ac_q5',
      'ac_q6',
    ],
    defaultGuidance: const GuidanceItem(
      meaning: 'Your answers suggest generally sound access control practices.',
      risk: 'Continue to review access periodically to catch any gaps early.',
      whereToLook: 'Review your existing access management records and documentation.',
      whatToCheck: 'Confirm that access review procedures are written down and actively followed.',
      firstStep: 'Document your current practices and schedule regular access reviews.',
      cjisReference: 'CJIS 5.5',
    ),
    combinedInsights: const [
      CombinedInsight(
        triggerQuestionIds: {'ac_q1', 'ac_q2'},
        insight:
            'Shared logins combined with shared accounts eliminate individual accountability for all system actions.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'ac_q3', 'ac_q6'},
        insight:
            'Excess permissions combined with informal access grants create untracked exposure to sensitive data.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'ac_q4', 'ac_q5'},
        insight:
            'Active orphaned accounts accessible from shared devices represent a critical vulnerability window.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'ac_q1', 'ac_q6'},
        insight:
            'Shared logins and untracked access grants make it nearly impossible to determine who did what.',
      ),
    ],
    questions: {
      // Primary Q1
      'ac_q1': const FlowQuestion(
        id: 'ac_q1',
        primaryIndex: 1,
        text: 'Does each user have their own login?',
        answers: [
          FlowAnswer(text: 'Yes'),
          FlowAnswer(
            text: 'No',
            guidance: GuidanceItem(
              meaning: 'Shared logins make it impossible to tie actions to a specific person.',
              risk: 'Loss of individual accountability is a common audit finding.',
              whereToLook: 'Review current user account lists in your systems.',
              whatToCheck: 'Look for accounts used by more than one person.',
              firstStep: 'Identify where individual logins are not used and create a plan to assign them.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about individual logins suggests account management may not be documented.',
              risk: 'Undocumented practices make audits and incident response harder.',
              whereToLook: 'Check with IT for a list of current user accounts.',
              whatToCheck: 'Look for accounts that are shared or lack a single named owner.',
              firstStep: 'Verify with your IT team whether every user has a unique account.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // Primary Q2
      'ac_q2': const FlowQuestion(
        id: 'ac_q2',
        primaryIndex: 2,
        text: 'Do multiple people ever use the same account?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            followUpQuestionId: 'ac_b1',
            guidance: GuidanceItem(
              meaning: 'Actions cannot be tied to a specific person when accounts are shared.',
              risk: 'Shared accounts are a common audit issue and create accountability gaps.',
              whereToLook: 'Review system access logs and account lists.',
              whatToCheck: 'Look for accounts with multiple active users.',
              firstStep: 'Identify where shared accounts are used and begin transitioning to individual accounts.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(text: 'No'),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            followUpQuestionId: 'ac_b1',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about shared account usage suggests account management may not be tracked.',
              risk: 'Untracked shared accounts create accountability gaps that are difficult to uncover.',
              whereToLook: 'Check with IT for a current list of user accounts and how they are assigned.',
              whatToCheck: 'Look for any accounts that appear to be used by more than one person.',
              firstStep: 'Ask IT whether shared accounts exist and, if so, who is responsible for each.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // Branch: shared account responsibility
      'ac_b1': const FlowQuestion(
        id: 'ac_b1',
        text: 'Who is responsible when actions are taken on that account?',
        answers: [
          FlowAnswer(text: 'A designated person'),
          FlowAnswer(
            text: 'No one specific',
            diagnosticFlag: 'Responsibility is unclear',
            guidance: GuidanceItem(
              meaning: 'Without a designated owner, accountability for shared account activity is unclear.',
              risk: 'This gap makes it difficult to investigate incidents or unauthorized access.',
              whereToLook: 'Review shared account records and any existing ownership documentation.',
              whatToCheck: 'Confirm each account has a specific person assigned as the responsible owner.',
              firstStep: 'Assign a named owner to every shared account and document it.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Responsibility is unclear',
            guidance: GuidanceItem(
              meaning: 'If you cannot identify who owns a shared account, responsibility is effectively unassigned.',
              risk: 'Unclear ownership means no one is accountable when issues arise.',
              whereToLook: 'Ask department heads which shared accounts their team uses.',
              whatToCheck: 'Confirm that each shared account has a named point of contact.',
              firstStep: 'Determine and document who is responsible for each shared account.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // Primary Q3
      'ac_q3': const FlowQuestion(
        id: 'ac_q3',
        primaryIndex: 3,
        text: 'Do users have access they don\'t need for their job?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            guidance: GuidanceItem(
              meaning: 'Excess access increases the attack surface if an account is compromised.',
              risk: 'Over-provisioned permissions are a leading cause of insider threat incidents.',
              whereToLook: 'Review access permission lists for each user role.',
              whatToCheck: 'Look for permissions that go beyond what a role requires day-to-day.',
              firstStep: 'Conduct an access review and remove permissions not required for each role.',
              cjisReference: 'CJIS 5.5.2.1',
            ),
          ),
          FlowAnswer(text: 'No'),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            followUpQuestionId: 'ac_b2',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about excess access suggests permissions may not be actively managed.',
              risk: 'Unreviewed permissions allow access to accumulate beyond what roles require.',
              whereToLook: 'Review any existing role or permission documentation with your IT team.',
              whatToCheck: 'Look for users with access that goes beyond what their daily job requires.',
              firstStep: 'Ask IT to pull a current permission report so you can review who has access to what.',
              cjisReference: 'CJIS 5.5.2.1',
            ),
          ),
        ],
      ),

      // Branch: access review capability
      'ac_b2': const FlowQuestion(
        id: 'ac_b2',
        text: 'Do you have a way to review who has access to what?',
        answers: [
          FlowAnswer(text: 'Yes'),
          FlowAnswer(
            text: 'No',
            guidance: GuidanceItem(
              meaning: 'Without an access review process, excess permissions can go undetected.',
              risk: 'Unreviewed access is one of the most common CJIS audit findings.',
              whereToLook: 'Check whether any written process exists for reviewing user access.',
              whatToCheck: 'Confirm who is responsible for reviewing access and how often it happens.',
              firstStep: 'Put a periodic access review process in place, even if done manually.',
              cjisReference: 'CJIS 5.5.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about access review capability suggests the process may not be established.',
              risk: 'Gaps in access review make it hard to enforce least-privilege.',
              whereToLook: 'Ask IT or your supervisor if an access review process exists.',
              whatToCheck: 'Look for documentation or meeting records showing past access reviews.',
              firstStep: 'Ask your IT team to document how access is reviewed and how often.',
              cjisReference: 'CJIS 5.5.2.1',
            ),
          ),
        ],
      ),

      // Primary Q4
      'ac_q4': const FlowQuestion(
        id: 'ac_q4',
        primaryIndex: 4,
        text: 'Are accounts removed or disabled when someone leaves?',
        answers: [
          FlowAnswer(text: 'Yes'),
          FlowAnswer(
            text: 'No',
            followUpQuestionId: 'ac_b3',
            guidance: GuidanceItem(
              meaning: 'Former employees retaining active accounts is a critical access control gap.',
              risk: 'Orphaned accounts can be exploited to gain unauthorized access to CJIS systems.',
              whereToLook: 'Review HR departure records alongside active system accounts.',
              whatToCheck: 'Look for active accounts belonging to people who no longer work there.',
              firstStep: 'Establish an off-boarding checklist that includes immediate account deactivation.',
              cjisReference: 'CJIS 5.5.2.3',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            followUpQuestionId: 'ac_b3',
            guidance: GuidanceItem(
              meaning: 'Not knowing whether accounts are removed when staff leave suggests no off-boarding process exists.',
              risk: 'Former employee accounts left active create an unauthorized access risk.',
              whereToLook: 'Compare HR departure records against the list of currently active accounts.',
              whatToCheck: 'Look for active accounts belonging to people who no longer work at the agency.',
              firstStep: 'Ask IT to cross-reference active accounts with current staff to identify any orphaned accounts.',
              cjisReference: 'CJIS 5.5.2.3',
            ),
          ),
        ],
      ),

      // Branch: orphaned account duration
      'ac_b3': const FlowQuestion(
        id: 'ac_b3',
        text: 'How long do old accounts usually stay active?',
        answers: [
          FlowAnswer(text: 'Less than a day'),
          FlowAnswer(text: '1–7 days'),
          FlowAnswer(
            text: 'More than a week',
            guidance: GuidanceItem(
              meaning: 'Accounts active for over a week after departure represent a prolonged exposure window.',
              risk: 'Extended orphaned accounts are frequently flagged in CJIS audits.',
              whereToLook: 'Review off-boarding records to see when accounts were disabled.',
              whatToCheck: 'Compare departure dates to account deactivation dates.',
              firstStep: 'Set a policy to disable accounts on the last day of employment.',
              cjisReference: 'CJIS 5.5.2.3',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'Not knowing how long former accounts stay active suggests no formal off-boarding process.',
              risk: 'Unknown retention periods mean orphaned accounts could persist indefinitely.',
              whereToLook: 'Check whether a formal off-boarding checklist exists.',
              whatToCheck: 'Confirm that IT receives timely notice when employees leave.',
              firstStep: 'Work with IT to define and enforce account deactivation timelines.',
              cjisReference: 'CJIS 5.5.2.3',
            ),
          ),
        ],
      ),

      // Primary Q5
      'ac_q5': const FlowQuestion(
        id: 'ac_q5',
        primaryIndex: 5,
        text: 'Can users access CJIS systems from shared or public computers?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            guidance: GuidanceItem(
              meaning: 'Shared or public computers can expose credentials and session data.',
              risk: 'Access from unmanaged devices is difficult to secure and audit.',
              whereToLook: 'Review where CJIS logins are occurring across your agency.',
              whatToCheck: 'Look for logins coming from shared workstations, kiosks, or personal devices.',
              firstStep: 'Restrict CJIS access to agency-managed devices with endpoint controls.',
              cjisReference: 'CJIS 5.5.6',
            ),
          ),
          FlowAnswer(text: 'No'),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'Uncertainty suggests device-level access controls may not be defined.',
              risk: 'Without clear device policies, CJIS data could be accessed from unsecured endpoints.',
              whereToLook: 'Check whether a written device access policy exists for CJIS systems.',
              whatToCheck: 'Confirm which device types are approved and whether that list is enforced.',
              firstStep: 'Clarify your device policy and confirm which devices are permitted.',
              cjisReference: 'CJIS 5.5.6',
            ),
          ),
        ],
      ),

      // Primary Q6
      'ac_q6': const FlowQuestion(
        id: 'ac_q6',
        primaryIndex: 6,
        text: 'Is access ever granted informally (verbal or email) without tracking?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Informal access grants bypass the audit trail and accountability controls.',
              risk: 'Untracked grants are invisible to auditors and incident responders.',
              whereToLook: 'Review how access requests are currently submitted and recorded.',
              whatToCheck: 'Look for access changes made verbally or via email without a written record.',
              firstStep: 'Require all access changes to go through a formal, logged request process.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(text: 'No'),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: "If you're unsure whether access is tracked, it may not be consistently enforced.",
              risk: 'Inconsistent tracking creates blind spots in your access management posture.',
              whereToLook: 'Ask IT how access change requests are submitted and stored.',
              whatToCheck: 'Look for a log or ticket system where access requests are recorded.',
              firstStep: 'Confirm with your IT team how access requests and approvals are recorded.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),
    },
  );

  // ─── Authentication & MFA Flow ────────────────────────────────────────────

  static final DomainFlow authMfaFlow = DomainFlow(
    domainId: 'auth_mfa',
    primaryQuestionIds: [
      'mfa_q1',
      'mfa_q2',
      'mfa_q3',
      'mfa_q4',
      'mfa_q5',
      'mfa_q6',
    ],
    defaultGuidance: const GuidanceItem(
      meaning: 'Your answers suggest generally strong authentication practices.',
      risk: 'Periodically re-evaluate MFA coverage as systems and users change.',
      whereToLook: 'Review your current authentication policy documentation.',
      whatToCheck: 'Confirm that all systems and users covered by CJIS requirements have MFA enabled.',
      firstStep: 'Document your current MFA policy and review it at least annually.',
      cjisReference: 'CJIS 5.6.2.2',
    ),
    combinedInsights: const [
      CombinedInsight(
        triggerQuestionIds: {'mfa_q1', 'mfa_q5'},
        insight:
            'Lack of MFA across both remote and internal access leaves systems vulnerable to credential-based attacks.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'mfa_q3', 'mfa_q4'},
        insight:
            'Shared and simple passwords together severely undermine authentication security.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'mfa_q1', 'mfa_q3'},
        insight:
            'Password sharing without MFA means a single compromised credential gives unrestricted access.',
      ),
    ],
    questions: {
      // Primary Q1
      'mfa_q1': const FlowQuestion(
        id: 'mfa_q1',
        primaryIndex: 1,
        text: 'Is multi-factor authentication required for remote access?',
        answers: [
          FlowAnswer(text: 'Yes'),
          FlowAnswer(
            text: 'No',
            guidance: GuidanceItem(
              meaning: 'Without MFA for remote access, a stolen password is enough to gain entry.',
              risk: 'Password-only remote access is a high-risk configuration for CJIS systems.',
              whereToLook: 'Review how remote access is currently configured and granted.',
              whatToCheck: 'Confirm whether a second verification step is required for any remote login.',
              firstStep: 'Prioritize enabling MFA for all remote access paths immediately.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about MFA enforcement suggests the policy may not be consistently applied.',
              risk: 'Gaps in MFA coverage are a top target in credential-based attacks.',
              whereToLook: 'Check with IT for documentation of your remote access authentication requirements.',
              whatToCheck: 'Look for any systems that allow remote login with only a username and password.',
              firstStep: 'Confirm with your IT team which remote access methods require MFA.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // Primary Q2
      'mfa_q2': const FlowQuestion(
        id: 'mfa_q2',
        primaryIndex: 2,
        text: 'Is MFA required for all users or only some?',
        answers: [
          FlowAnswer(text: 'All users'),
          FlowAnswer(
            text: 'Only some',
            followUpQuestionId: 'mfa_b1',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Partial MFA coverage means some accounts remain protected only by a password.',
              risk: 'Excluded users can become the weakest link in your authentication posture.',
              whereToLook: 'Review the list of users and systems subject to MFA requirements.',
              whatToCheck: 'Look for accounts or system roles that are exempt from MFA.',
              firstStep: 'Identify which users or systems are excluded and expand MFA coverage.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not required',
            guidance: GuidanceItem(
              meaning: 'Access depends entirely on a password when MFA is not required.',
              risk: 'Password compromise can lead directly to unauthorized CJIS system access.',
              whereToLook: 'Review authentication settings for each system that handles CJIS data.',
              whatToCheck: 'Confirm which systems currently have no MFA requirement in place.',
              firstStep: 'Identify systems without MFA and create a plan to enforce it.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            followUpQuestionId: 'mfa_b1',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about MFA coverage scope suggests the policy may not be clearly documented.',
              risk: 'Gaps in MFA coverage leave accounts protected only by a password.',
              whereToLook: 'Ask IT for documentation covering which users and systems require MFA.',
              whatToCheck: 'Look for any user groups or system roles that may be exempt from MFA requirements.',
              firstStep: 'Request a complete list of who is and is not subject to MFA requirements.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // Branch: which systems/users not covered by MFA
      'mfa_b1': const FlowQuestion(
        id: 'mfa_b1',
        text: 'Which systems or users are not covered by MFA?',
        answers: [
          FlowAnswer(text: 'Internal users only'),
          FlowAnswer(text: 'Specific systems'),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'Not knowing which systems lack MFA means gaps may exist without visibility.',
              risk: 'Unknown coverage gaps prevent you from prioritizing remediation.',
              whereToLook: 'Ask IT for an inventory of all systems that access or process CJIS data.',
              whatToCheck: 'Confirm which of those systems currently enforce a second factor at login.',
              firstStep: 'Work with IT to produce a complete map of which systems enforce MFA.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // Primary Q3
      'mfa_q3': const FlowQuestion(
        id: 'mfa_q3',
        primaryIndex: 3,
        text: 'Do users ever share passwords?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            followUpQuestionId: 'mfa_b2',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Shared passwords eliminate individual accountability for system actions.',
              risk: 'Password sharing undermines both authentication integrity and auditability.',
              whereToLook: 'Review your current password and acceptable use policies.',
              whatToCheck: 'Confirm whether the policy explicitly prohibits sharing credentials.',
              firstStep: 'Prohibit password sharing through policy and reinforce it with training.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(text: 'No'),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            followUpQuestionId: 'mfa_b2',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about password sharing suggests no clear prohibition or enforcement exists.',
              risk: 'Shared passwords eliminate individual accountability and undermine authentication controls.',
              whereToLook: 'Review your current acceptable use and password policies.',
              whatToCheck: 'Confirm whether the policy explicitly prohibits sharing credentials and whether it is enforced.',
              firstStep: 'Ask staff and IT whether sharing passwords is occurring and document the findings.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // Branch: how actions are tied to a person when passwords are shared
      'mfa_b2': const FlowQuestion(
        id: 'mfa_b2',
        text: 'How are actions tied to a specific person?',
        answers: [
          FlowAnswer(text: 'Through logs and timestamps'),
          FlowAnswer(
            text: "They aren't",
            diagnosticFlag: 'Responsibility is unclear',
            guidance: GuidanceItem(
              meaning: 'Without tying actions to individuals, there is no accountability trail.',
              risk: 'This creates a critical gap for incident investigation and audit response.',
              whereToLook: 'Review system audit logs to see whether actions are tied to named individuals.',
              whatToCheck: 'Look for log entries that show generic or shared account activity.',
              firstStep: 'Implement individual credentials and audit logging tied to each user.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Responsibility is unclear',
            guidance: GuidanceItem(
              meaning: 'If you are unsure how actions are traced to individuals, accountability may be missing.',
              risk: 'Without clear attribution, investigations cannot determine who accessed what.',
              whereToLook: 'Ask IT to show a sample audit log entry and explain what it records.',
              whatToCheck: 'Confirm that every logged action includes the specific user who performed it.',
              firstStep: 'Confirm with IT how user actions are logged and attributed.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // Primary Q4
      'mfa_q4': const FlowQuestion(
        id: 'mfa_q4',
        primaryIndex: 4,
        text: 'Are default or simple passwords ever used?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Default and simple passwords are among the most exploited vulnerabilities.',
              risk: 'Attackers routinely test default credentials as a first step in unauthorized access.',
              whereToLook: 'Review your current password policy and any system default credential documentation.',
              whatToCheck: 'Look for systems that still use factory-set or easily guessable passwords.',
              firstStep: 'Enforce a password policy requiring complexity and change defaults on all systems.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(text: 'No'),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about password strength suggests no enforced password policy exists.',
              risk: 'Without enforcement, weak passwords are likely present across systems.',
              whereToLook: 'Check whether a written password complexity policy exists.',
              whatToCheck: 'Confirm whether password complexity rules are enforced automatically by the system.',
              firstStep: 'Audit passwords on critical systems and enforce a complexity policy.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // Primary Q5
      'mfa_q5': const FlowQuestion(
        id: 'mfa_q5',
        primaryIndex: 5,
        text: 'Can users log in without MFA on internal systems?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            followUpQuestionId: 'mfa_b3',
            guidance: GuidanceItem(
              meaning: 'Internal systems without MFA rely solely on network perimeter for protection.',
              risk: 'An insider or attacker already on the network can access CJIS systems with just a password.',
              whereToLook: 'Review authentication settings for internally accessible CJIS systems.',
              whatToCheck: 'Look for internal applications that allow login with only a username and password.',
              firstStep: 'Extend MFA requirements to internal system access, not just remote access.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(text: 'No'),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            followUpQuestionId: 'mfa_b3',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about internal MFA requirements suggests authentication policy may not cover all access paths.',
              risk: 'If internal access does not require MFA, any compromised internal device becomes a direct entry point.',
              whereToLook: 'Review authentication configurations for internally accessible CJIS systems.',
              whatToCheck: 'Confirm whether any internal application allows login with only a username and password.',
              firstStep: 'Ask IT to confirm which internal systems enforce MFA and which do not.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // Branch: internal network access without second factor
      'mfa_b3': const FlowQuestion(
        id: 'mfa_b3',
        text: 'Could someone inside the network access CJIS systems without a second factor?',
        answers: [
          FlowAnswer(text: 'No, MFA is always required'),
          FlowAnswer(
            text: 'Yes, once on the network',
            guidance: GuidanceItem(
              meaning: 'Network-level trust without MFA means any internal machine is a potential entry point.',
              risk: 'Lateral movement inside the network is a common attack path against CJIS data.',
              whereToLook: 'Review whether MFA is enforced at the application login screen, not just at network entry.',
              whatToCheck: 'Confirm that being on the internal network alone does not bypass MFA requirements.',
              firstStep: 'Apply MFA at the application layer regardless of network location.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'If internal MFA requirements are unclear, the network perimeter may be the only barrier.',
              risk: 'Uncertainty here means an attacker on the internal network may face no second factor.',
              whereToLook: 'Ask IT to confirm how each internal CJIS application handles authentication.',
              whatToCheck: 'Look for any application that grants access after a single password entry on the internal network.',
              firstStep: 'Verify with IT whether MFA is enforced on every application regardless of network.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // Primary Q6
      'mfa_q6': const FlowQuestion(
        id: 'mfa_q6',
        primaryIndex: 6,
        text: 'Is login access tied to a specific device or location?',
        answers: [
          FlowAnswer(text: 'Yes'),
          FlowAnswer(
            text: 'No',
            guidance: GuidanceItem(
              meaning: 'Without device or location binding, credentials alone grant access from anywhere.',
              risk: 'Stolen credentials can be used from any location without additional controls.',
              whereToLook: 'Review your current authentication and access policy for location or device rules.',
              whatToCheck: 'Confirm whether login attempts from unusual locations trigger any alert or block.',
              firstStep: 'Consider implementing device certificates or location-based access controls.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Lack of visibility in this area',
            guidance: GuidanceItem(
              meaning: 'Uncertainty suggests conditional access policies may not be in place.',
              risk: 'Without conditional access, authentication context cannot be verified.',
              whereToLook: 'Ask IT whether any rules restrict logins based on device type or physical location.',
              whatToCheck: 'Look for a policy document or system configuration that defines where logins are permitted from.',
              firstStep: 'Confirm with IT whether device or location restrictions are enforced on logins.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),
    },
  );

  // ─── Lookup helpers ───────────────────────────────────────────────────────

  static final Map<String, DomainFlow> _flows = {
    'access_control': accessControlFlow,
    'auth_mfa': authMfaFlow,
  };

  static DomainFlow? getFlow(String domainId) => _flows[domainId];
}
