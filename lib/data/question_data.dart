import '../models/question_models.dart';

/// Predefined question flows for Access Control and Authentication & MFA.
///
/// Questions are designed to be scenario-driven and guidance-oriented,
/// surfacing real-world failure patterns common in law enforcement and
/// local government environments rather than testing for checkbox compliance.
class QuestionData {
  // ─── Domains ──────────────────────────────────────────────────────────────

  static const List<Domain> domains = [
    Domain(id: 'access_control', title: 'Access Control', icon: '🔐'),
    Domain(id: 'auth_mfa', title: 'Authentication & MFA', icon: '🔑'),
    Domain(id: 'data_storage', title: 'Data Storage & Encryption', icon: '💾'),
    Domain(id: 'user_roles', title: 'User Roles & Least Privilege', icon: '👤'),
    Domain(id: 'cloud_vendor', title: 'Cloud & Vendor Considerations', icon: '☁️'),
    Domain(id: 'training', title: 'Training & Personnel Security', icon: '🎓'),
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
      'ac_q7',
      'ac_q8',
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
            'Shared accounts combined with untracked actions eliminate individual accountability for all system activity.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'ac_q3', 'ac_q6'},
        insight:
            'Informal access granting combined with no formal request process creates a complete absence of access management discipline.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'ac_q4', 'ac_q5'},
        insight:
            'Delayed account deactivation combined with shared device access means orphaned accounts may be reachable from any shared workstation.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'ac_q1', 'ac_q6'},
        insight:
            'Shared accounts and untracked access grants make it nearly impossible to determine who did what and when.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'ac_q7', 'ac_q8'},
        insight:
            'Without regular access reviews and with systems outside central management, permissions accumulate unchecked over time.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'ac_q4', 'ac_q7'},
        insight:
            'Delayed deactivation combined with infrequent reviews means orphaned accounts can persist undetected for extended periods.',
      ),
    ],
    questions: {
      // ── Primary Q1: Unique accounts vs shared/generic ──────────────────
      'ac_q1': const FlowQuestion(
        id: 'ac_q1',
        primaryIndex: 1,
        text:
            'Do all users who access CJIS systems have their own unique account, or are there shared or generic accounts used in practice — for example, during shift changes, at kiosks, or in dispatch?',
        answers: [
          FlowAnswer(text: 'Yes, every user has a unique account'),
          FlowAnswer(
            text: 'No, some accounts are shared',
            followUpQuestionId: 'ac_b1a',
            guidance: GuidanceItem(
              meaning: 'Shared accounts make it impossible to tie actions to a specific person.',
              risk: 'Loss of individual accountability is a common audit finding in law enforcement environments.',
              whereToLook: 'Review current user account lists across all CJIS-connected systems.',
              whatToCheck: 'Look for accounts used by more than one person, especially on shared workstations.',
              firstStep: 'Identify every shared or generic account and create a plan to assign individual logins.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'ac_b1a',
            diagnosticFlag: 'Account uniqueness may not be verified',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about shared accounts suggests account management may not be documented or centrally tracked.',
              risk: 'Undocumented account practices make audits and incident response significantly harder.',
              whereToLook: 'Check with IT for a complete list of current user accounts and their assigned owners.',
              whatToCheck: 'Look for accounts that lack a single named owner or appear to be used by multiple people.',
              firstStep: 'Verify with your IT team whether every user has a unique account and document the results.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Branch: shared account attribution ─────────────────────────────
      'ac_b1a': const FlowQuestion(
        id: 'ac_b1a',
        text:
            'In situations where accounts are shared, what prevents one person\'s actions from being attributed to someone else?',
        answers: [
          FlowAnswer(text: 'Sign-in logs track who is using it at any given time'),
          FlowAnswer(
            text: 'Nothing specific is in place',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Without attribution controls, any action under a shared account could be blamed on the wrong person.',
              risk: 'This creates serious liability during investigations and is a frequent CJIS audit finding.',
              whereToLook: 'Review how shared workstations and accounts are logged and monitored.',
              whatToCheck: 'Confirm whether any mechanism ties specific actions to specific individuals on shared accounts.',
              firstStep: 'Implement sign-in sheets, camera logs, or individual authentication even on shared workstations.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Shared account actions may not be attributable',
            guidance: GuidanceItem(
              meaning: 'If you cannot describe how shared account actions are attributed, the control likely does not exist.',
              risk: 'Unattributed actions on shared accounts undermine accountability and audit readiness.',
              whereToLook: 'Ask IT and supervisors how they currently track who uses shared accounts.',
              whatToCheck: 'Look for any logs, sign-in sheets, or monitoring that ties actions to individuals.',
              firstStep: 'Determine with IT whether any attribution mechanism exists for shared accounts and document findings.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Primary Q2: Tracking individual actions ────────────────────────
      'ac_q2': const FlowQuestion(
        id: 'ac_q2',
        primaryIndex: 2,
        text:
            'When multiple people use the same workstation or system — such as during shift handoffs — how are individual actions tracked back to a specific person?',
        answers: [
          FlowAnswer(
            text: 'Each person logs in with their own credentials before using the system',
          ),
          FlowAnswer(
            text: 'Actions are logged but not always tied to individuals',
            followUpQuestionId: 'ac_b1',
            guidance: GuidanceItem(
              meaning: 'Logs without individual attribution cannot support incident investigation or accountability.',
              risk: 'Shared account activity is a common CJIS audit issue and creates serious accountability gaps.',
              whereToLook: 'Review system access logs and how they record user identity.',
              whatToCheck: 'Look for log entries that show generic or shared account names instead of individual users.',
              firstStep: 'Work with IT to ensure every log entry includes the specific individual who performed the action.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'ac_b1',
            diagnosticFlag: 'Individual action tracking may not be in place',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about action tracking suggests audit logs may not capture individual user identity.',
              risk: 'Untracked actions on shared systems create accountability gaps that are difficult to resolve after the fact.',
              whereToLook: 'Check with IT for a sample of recent access logs from shared workstations.',
              whatToCheck: 'Confirm whether each logged action includes the specific user who performed it.',
              firstStep: 'Ask IT to demonstrate how actions are traced to individuals on shared systems.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Branch: responsibility for shared account actions ──────────────
      'ac_b1': const FlowQuestion(
        id: 'ac_b1',
        text:
            'If actions cannot be individually tracked, who is responsible when something goes wrong on that account?',
        answers: [
          FlowAnswer(text: 'A designated person'),
          FlowAnswer(
            text: 'No one specific',
            diagnosticFlag: 'Responsibility is unclear',
            guidance: GuidanceItem(
              meaning: 'Without a designated owner, accountability for shared account activity is unclear.',
              risk: 'This gap makes it difficult to investigate incidents or unauthorized access.',
              whereToLook: 'Review shared account records and any existing ownership documentation.',
              whatToCheck: 'Confirm each shared account has a specific person assigned as the responsible owner.',
              firstStep: 'Assign a named owner to every shared account and document the assignment.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Responsibility is unclear',
            guidance: GuidanceItem(
              meaning: 'If you cannot identify who owns a shared account, responsibility is effectively unassigned.',
              risk: 'Unclear ownership means no one is accountable when issues arise.',
              whereToLook: 'Ask department heads which shared accounts their team uses and who oversees them.',
              whatToCheck: 'Confirm that each shared account has a named point of contact.',
              firstStep: 'Determine and document who is responsible for each shared account.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Primary Q3: How access is initially granted ────────────────────
      'ac_q3': const FlowQuestion(
        id: 'ac_q3',
        primaryIndex: 3,
        text:
            'How is user access initially requested and approved — through a formal system like a ticket or written request, or through informal methods like a verbal ask or email?',
        answers: [
          FlowAnswer(
            text: 'Through a formal, documented request and approval process',
          ),
          FlowAnswer(
            text: 'Informally — verbal requests or email without a tracking system',
            followUpQuestionId: 'ac_b2',
            guidance: GuidanceItem(
              meaning: 'Informal access grants bypass the audit trail and make it hard to verify who approved what.',
              risk: 'Untracked grants are invisible to auditors and create uncontrolled access pathways.',
              whereToLook: 'Review how access requests are currently submitted and recorded.',
              whatToCheck: 'Look for access changes made through verbal or email requests without a formal record.',
              firstStep: 'Require all access changes to go through a formal, logged request and approval process.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'ac_b2',
            diagnosticFlag: 'Access request process may not be defined',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about access request processes suggests no consistent procedure is in place.',
              risk: 'Without a defined process, access may be granted inconsistently and without documentation.',
              whereToLook: 'Ask IT how access change requests are submitted, approved, and stored.',
              whatToCheck: 'Look for a log or ticketing system where access requests and approvals are recorded.',
              firstStep: 'Confirm with your IT team what process, if any, is used to request and approve access.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Branch: documenting informal access ────────────────────────────
      'ac_b2': const FlowQuestion(
        id: 'ac_b2',
        text:
            'When access is granted informally, how is it documented or reviewed afterward?',
        answers: [
          FlowAnswer(text: 'It is documented after the fact in a log or ticket'),
          FlowAnswer(
            text: 'It is not consistently documented',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Undocumented access grants create gaps that auditors and investigators cannot see.',
              risk: 'Access granted without records can persist indefinitely and may never be reviewed.',
              whereToLook: 'Check whether any written process exists for retroactively documenting informal grants.',
              whatToCheck: 'Look for access changes that exist in the system but have no corresponding request record.',
              firstStep: 'Establish a process for documenting all access grants, even those made informally.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Informal access grants may not be documented',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about documentation suggests informal grants may not be tracked at all.',
              risk: 'Untracked access changes accumulate over time and become difficult to audit.',
              whereToLook: 'Ask IT or supervisors whether informal access changes are logged anywhere.',
              whatToCheck: 'Look for any retroactive documentation process for access requests made outside formal channels.',
              firstStep: 'Work with IT to confirm how informal access changes are currently handled and documented.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Primary Q4: Access removal timeline ────────────────────────────
      'ac_q4': const FlowQuestion(
        id: 'ac_q4',
        primaryIndex: 4,
        text:
            'When an employee leaves or changes roles, what is the typical timeline for removing or adjusting their system access?',
        answers: [
          FlowAnswer(
            text: 'Same day — access is removed or adjusted on the last day',
          ),
          FlowAnswer(
            text: 'It can take several days or longer',
            followUpQuestionId: 'ac_b3',
            guidance: GuidanceItem(
              meaning: 'Delayed deactivation leaves a window where former or reassigned staff retain unnecessary access.',
              risk: 'Orphaned accounts are a critical vulnerability and a frequent CJIS audit finding.',
              whereToLook: 'Review HR departure records alongside active system accounts.',
              whatToCheck: 'Compare departure or role-change dates to when accounts were actually modified.',
              firstStep: 'Establish an off-boarding checklist that includes same-day account deactivation.',
              cjisReference: 'CJIS 5.5.2.3',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'ac_b3',
            diagnosticFlag: 'Off-boarding process may not be defined',
            guidance: GuidanceItem(
              meaning: 'Not knowing the deactivation timeline suggests no formal off-boarding process exists.',
              risk: 'Without a defined timeline, former employee accounts could remain active indefinitely.',
              whereToLook: 'Compare HR departure records against the list of currently active accounts.',
              whatToCheck: 'Look for active accounts belonging to people who no longer work at the agency.',
              firstStep: 'Ask IT to cross-reference active accounts with current staff to identify orphaned accounts.',
              cjisReference: 'CJIS 5.5.2.3',
            ),
          ),
        ],
      ),

      // ── Branch: orphaned account persistence ───────────────────────────
      'ac_b3': const FlowQuestion(
        id: 'ac_b3',
        text:
            'Have there been cases where former employees\' accounts remained active longer than intended — even by a few days?',
        answers: [
          FlowAnswer(text: 'No, accounts are consistently disabled on time'),
          FlowAnswer(
            text: 'Yes, it has happened',
            guidance: GuidanceItem(
              meaning: 'Accounts active beyond departure represent a prolonged, exploitable exposure window.',
              risk: 'Extended orphaned accounts are frequently flagged in CJIS audits and are a common breach vector.',
              whereToLook: 'Review off-boarding records to see when accounts were actually disabled versus departure dates.',
              whatToCheck: 'Compare departure dates to account deactivation dates for the last several terminations.',
              firstStep: 'Set a policy to disable accounts on the last day of employment and verify it with IT.',
              cjisReference: 'CJIS 5.5.2.3',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Orphaned accounts may not be detected',
            guidance: GuidanceItem(
              meaning: 'Not knowing whether orphaned accounts persist suggests no monitoring or verification exists.',
              risk: 'Orphaned accounts that go undetected could be used for unauthorized access at any time.',
              whereToLook: 'Check whether a formal off-boarding checklist exists and whether IT verifies completion.',
              whatToCheck: 'Confirm that IT receives timely notice when employees leave and verifies account deactivation.',
              firstStep: 'Work with IT and HR to implement a verification step that confirms accounts are deactivated promptly.',
              cjisReference: 'CJIS 5.5.2.3',
            ),
          ),
        ],
      ),

      // ── Primary Q5: Access from shared, public, or unmanaged devices ───
      'ac_q5': const FlowQuestion(
        id: 'ac_q5',
        primaryIndex: 5,
        text:
            'Can CJIS systems be accessed from shared, public, or unmanaged devices — such as personal laptops, lobby kiosks, or computers used by multiple departments?',
        answers: [
          FlowAnswer(
            text: 'No, access is restricted to agency-managed devices only',
          ),
          FlowAnswer(
            text: 'Yes, some systems can be reached from shared or unmanaged devices',
            followUpQuestionId: 'ac_b4',
            guidance: GuidanceItem(
              meaning: 'Shared or unmanaged devices can expose credentials and session data to unauthorized users.',
              risk: 'Access from uncontrolled devices is difficult to secure and audit.',
              whereToLook: 'Review where CJIS logins are occurring across your agency.',
              whatToCheck: 'Look for logins coming from shared workstations, kiosks, or personal devices.',
              firstStep: 'Restrict CJIS access to agency-managed devices with endpoint controls.',
              cjisReference: 'CJIS 5.5.6',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'ac_b4',
            diagnosticFlag: 'Device access controls may not be defined',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about device access suggests device-level controls may not be defined or enforced.',
              risk: 'Without clear device policies, CJIS data could be accessed from unsecured endpoints.',
              whereToLook: 'Check whether a written device access policy exists for CJIS systems.',
              whatToCheck: 'Confirm which device types are approved for CJIS access and whether that list is enforced.',
              firstStep: 'Clarify your device policy with IT and confirm which devices are permitted to access CJIS systems.',
              cjisReference: 'CJIS 5.5.6',
            ),
          ),
        ],
      ),

      // ── Branch: controls on shared/unmanaged devices ───────────────────
      'ac_b4': const FlowQuestion(
        id: 'ac_b4',
        text:
            'What controls are in place to prevent misuse or data exposure on those shared or unmanaged devices?',
        answers: [
          FlowAnswer(
            text: 'Session timeouts, screen locks, and restricted permissions are enforced',
          ),
          FlowAnswer(
            text: 'No specific controls beyond standard login',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Without device-level controls, a shared or unmanaged device becomes an easy target for data exposure.',
              risk: 'Credentials or cached data on uncontrolled devices can be accessed by anyone with physical access.',
              whereToLook: 'Review endpoint security configurations for shared or non-agency devices.',
              whatToCheck: 'Confirm whether session timeouts, screen locks, and data-clearing policies are enforced on those devices.',
              firstStep: 'Implement session timeouts, auto-lock, and browser data clearing on any shared or unmanaged device.',
              cjisReference: 'CJIS 5.5.6',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Endpoint security on shared devices may not be configured',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about device controls suggests endpoint security may not be configured or monitored.',
              risk: 'Without visibility into device-level protections, CJIS data may be exposed on unsecured endpoints.',
              whereToLook: 'Ask IT what protections exist on shared or unmanaged devices that access CJIS systems.',
              whatToCheck: 'Look for documentation on endpoint security policies for non-standard devices.',
              firstStep: 'Request an inventory of all device types that access CJIS systems and their security configurations.',
              cjisReference: 'CJIS 5.5.6',
            ),
          ),
        ],
      ),

      // ── Primary Q6: Informal access grants ────────────────────────────
      'ac_q6': const FlowQuestion(
        id: 'ac_q6',
        primaryIndex: 6,
        text:
            'Is access ever granted through informal channels — such as a verbal request, a quick email, or a supervisor telling IT to "add someone" — without being logged in a tracking system?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            followUpQuestionId: 'ac_b5',
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
            followUpQuestionId: 'ac_b5',
            diagnosticFlag: 'Access tracking may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'If you are unsure whether access is tracked, it may not be consistently enforced.',
              risk: 'Inconsistent tracking creates blind spots in your access management posture.',
              whereToLook: 'Ask IT how access change requests are submitted and stored.',
              whatToCheck: 'Look for a log or ticket system where access requests are recorded.',
              firstStep: 'Confirm with your IT team how access requests and approvals are recorded.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Branch: detecting unauthorized informal changes ────────────────
      'ac_b5': const FlowQuestion(
        id: 'ac_b5',
        text:
            'How would you detect an unauthorized or inappropriate access change that was made through an informal request?',
        answers: [
          FlowAnswer(text: 'Regular access reviews would catch it'),
          FlowAnswer(
            text: 'There is no reliable way to detect it',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Without detection capability, unauthorized access changes can persist indefinitely.',
              risk: 'Undetected informal grants are one of the most common pathways to over-provisioned access.',
              whereToLook: 'Review whether periodic access reviews compare current permissions against approved requests.',
              whatToCheck: 'Look for any reconciliation process that compares active access to documented approvals.',
              firstStep: 'Establish a regular access reconciliation process that flags permissions without matching approval records.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Unauthorized access changes may go undetected',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about detection capability suggests unauthorized changes could go unnoticed.',
              risk: 'Without visibility into access changes, informal grants accumulate unchecked.',
              whereToLook: 'Ask IT whether they compare active permissions against approved request records.',
              whatToCheck: 'Confirm whether any process exists to flag access that was never formally requested.',
              firstStep: 'Work with IT to implement a periodic comparison of active access against approval records.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Primary Q7: Access review frequency and ownership ──────────────
      'ac_q7': const FlowQuestion(
        id: 'ac_q7',
        primaryIndex: 7,
        text:
            'How often is user access reviewed to confirm people only have the permissions they need, and who is responsible for conducting that review?',
        answers: [
          FlowAnswer(
            text: 'Reviews happen on a set schedule with a designated owner',
          ),
          FlowAnswer(
            text: 'Reviews happen but not on a regular schedule',
            followUpQuestionId: 'ac_b6',
            guidance: GuidanceItem(
              meaning: 'Irregular reviews allow excess permissions to accumulate between checks.',
              risk: 'Over-provisioned access is a leading cause of insider threat incidents.',
              whereToLook: 'Review any existing access review documentation or meeting records.',
              whatToCheck: 'Look for a schedule, assigned reviewer, and records of past reviews.',
              firstStep: 'Establish a recurring access review with a named owner and documented schedule.',
              cjisReference: 'CJIS 5.5.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure or reviews do not happen',
            followUpQuestionId: 'ac_b6',
            diagnosticFlag: 'Access reviews may not be happening',
            guidance: GuidanceItem(
              meaning: 'No access review process means permissions are likely never validated after initial grant.',
              risk: 'Unreviewed access is one of the most common CJIS audit findings.',
              whereToLook: 'Ask IT or management if any access review process exists.',
              whatToCheck: 'Look for documentation or meeting records showing any past access reviews.',
              firstStep: 'Implement a periodic access review process, even if done manually, and assign a responsible owner.',
              cjisReference: 'CJIS 5.5.2.1',
            ),
          ),
        ],
      ),

      // ── Branch: handling excessive access ──────────────────────────────
      'ac_b6': const FlowQuestion(
        id: 'ac_b6',
        text:
            'When excessive or inappropriate access is discovered, what happens — is it removed immediately, or does it require additional approvals?',
        answers: [
          FlowAnswer(text: 'It is removed immediately and documented'),
          FlowAnswer(
            text: 'Removal requires approvals that can take time',
            guidance: GuidanceItem(
              meaning: 'Delays in removing excess access extend the window of risk after discovery.',
              risk: 'Approval bottlenecks can leave known over-provisioned accounts active for days or weeks.',
              whereToLook: 'Review the process for removing access once a problem is identified.',
              whatToCheck: 'Confirm how long it typically takes from discovery to actual access removal.',
              firstStep: 'Create an expedited removal process for cases where excessive access poses an immediate risk.',
              cjisReference: 'CJIS 5.5.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Excess access remediation process may not be defined',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about the remediation process suggests no defined procedure exists for handling excess access.',
              risk: 'Without a defined response, discovered access issues may not be resolved consistently.',
              whereToLook: 'Ask IT and management what steps are taken when inappropriate access is found.',
              whatToCheck: 'Look for a documented remediation workflow that covers access removal.',
              firstStep: 'Define a clear process for what happens when excess access is identified during a review.',
              cjisReference: 'CJIS 5.5.2.1',
            ),
          ),
        ],
      ),

      // ── Primary Q8: Systems outside central management ─────────────────
      'ac_q8': const FlowQuestion(
        id: 'ac_q8',
        primaryIndex: 8,
        text:
            'Are there any systems that access or store CJIS data where permissions are not centrally managed or regularly audited — for example, standalone databases, legacy applications, or departmental tools?',
        answers: [
          FlowAnswer(
            text: 'No, all systems are centrally managed and audited',
          ),
          FlowAnswer(
            text: 'Yes, some systems are managed separately',
            followUpQuestionId: 'ac_b7',
            guidance: GuidanceItem(
              meaning: 'Systems outside central management often have inconsistent or outdated access controls.',
              risk: 'Unaudited systems are a blind spot where unauthorized access can persist undetected.',
              whereToLook: 'Review your system inventory for any CJIS-connected applications managed outside central IT.',
              whatToCheck: 'Look for standalone databases, legacy tools, or departmental applications with their own access controls.',
              firstStep: 'Create an inventory of all systems that access CJIS data and confirm how each one manages permissions.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'ac_b7',
            diagnosticFlag: 'System inventory may be incomplete',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about which systems are centrally managed suggests a gap in your system inventory.',
              risk: 'Unknown or untracked systems with CJIS access represent an unmanaged attack surface.',
              whereToLook: 'Ask IT for a complete inventory of all systems that access or process CJIS data.',
              whatToCheck: 'Confirm whether each system in the inventory is subject to centralized access management.',
              firstStep: 'Work with IT to inventory all CJIS-connected systems and determine how each manages access.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
        ],
      ),

      // ── Branch: monitoring for unmanaged systems ───────────────────────
      'ac_b7': const FlowQuestion(
        id: 'ac_b7',
        text:
            'How are those separately managed systems monitored for unauthorized access or permission changes?',
        answers: [
          FlowAnswer(text: 'They have their own audit and review process'),
          FlowAnswer(
            text: 'They are not actively monitored',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Unmonitored systems are invisible to your security posture and can harbor unauthorized access.',
              risk: 'An attacker or insider with access to an unmonitored system faces no detection.',
              whereToLook: 'Review access logs and audit capabilities for each separately managed system.',
              whatToCheck: 'Confirm whether those systems generate audit logs and whether anyone reviews them.',
              firstStep: 'Enable logging on all CJIS-connected systems and assign someone to review those logs regularly.',
              cjisReference: 'CJIS 5.5.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Separately managed systems may not be monitored',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about monitoring indicates these systems may be outside your security visibility.',
              risk: 'Systems without monitoring are common entry points in breach investigations.',
              whereToLook: 'Ask the administrators of those systems what logging and review processes are in place.',
              whatToCheck: 'Look for audit logs, access review records, or any monitoring dashboards for those systems.',
              firstStep: 'Contact the administrators of each separately managed system and assess their audit capabilities.',
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
      'mfa_q7',
      'mfa_q8',
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
        triggerQuestionIds: {'mfa_q1', 'mfa_q2'},
        insight:
            'No MFA for remote access combined with MFA bypass on internal systems means credentials alone grant access from virtually anywhere.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'mfa_q3', 'mfa_q4'},
        insight:
            'Shared credentials combined with weak password management severely undermine the entire authentication foundation.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'mfa_q1', 'mfa_q3'},
        insight:
            'Credential sharing without MFA means a single compromised password gives unrestricted access to CJIS systems.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'mfa_q2', 'mfa_q8'},
        insight:
            'Internal MFA bypass combined with no login monitoring creates an invisible attack surface inside the network.',
      ),
      CombinedInsight(
        triggerQuestionIds: {'mfa_q5', 'mfa_q6'},
        insight:
            'Weak account recovery combined with insecure fallback methods creates an exploitable path to bypass primary authentication.',
      ),
    ],
    questions: {
      // ── Primary Q1: MFA for remote access ──────────────────────────────
      'mfa_q1': const FlowQuestion(
        id: 'mfa_q1',
        primaryIndex: 1,
        text:
            'Is MFA required for all remote access to CJIS systems, or are there any exceptions — for example, for specific users, roles, or systems?',
        answers: [
          FlowAnswer(
            text: 'Yes, MFA is required for all remote access without exceptions',
          ),
          FlowAnswer(
            text: 'No, there are some exceptions',
            followUpQuestionId: 'mfa_b1',
            guidance: GuidanceItem(
              meaning: 'Exceptions to MFA for remote access leave specific accounts protected only by a password.',
              risk: 'Password-only remote access paths are high-value targets for credential-based attacks.',
              whereToLook: 'Review how remote access is configured and which accounts are exempt from MFA.',
              whatToCheck: 'Confirm which users, roles, or systems are exempt and whether each exception is documented.',
              firstStep: 'Document every MFA exception and evaluate whether each one is truly necessary.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'mfa_b1',
            diagnosticFlag: 'Remote MFA coverage may not be fully enforced',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about MFA enforcement suggests the policy may not be consistently applied or documented.',
              risk: 'Gaps in MFA coverage are a top target in credential-based attacks.',
              whereToLook: 'Check with IT for documentation of your remote access authentication requirements.',
              whatToCheck: 'Look for any systems that allow remote login with only a username and password.',
              firstStep: 'Confirm with your IT team which remote access methods require MFA and which do not.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // ── Branch: justification for MFA exceptions ───────────────────────
      'mfa_b1': const FlowQuestion(
        id: 'mfa_b1',
        text:
            'What is the justification for those MFA exceptions, and who approved them?',
        answers: [
          FlowAnswer(
            text: 'Each exception has a documented justification and formal approval',
          ),
          FlowAnswer(
            text: 'Exceptions evolved informally without formal approval',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Undocumented MFA exceptions bypass the security review process and may not reflect current risk.',
              risk: 'Informal exceptions tend to persist long after their original justification has expired.',
              whereToLook: 'Ask IT for a list of all MFA exceptions and their corresponding justifications.',
              whatToCheck: 'Confirm whether each exception has a named approver and a documented reason.',
              firstStep: 'Require formal documentation and periodic re-approval for every MFA exception.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'MFA exceptions may not have been formally approved',
            guidance: GuidanceItem(
              meaning: 'Not knowing how exceptions were approved suggests the review process is informal or absent.',
              risk: 'Unreviewed exceptions may expose high-risk access paths without anyone being aware.',
              whereToLook: 'Review authentication configurations to identify any accounts that bypass MFA.',
              whatToCheck: 'Look for documentation of when and why each exception was created.',
              firstStep: 'Work with IT to inventory all MFA exceptions and determine whether each is still justified.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // ── Primary Q2: Internal systems without MFA ("trusted") ───────────
      'mfa_q2': const FlowQuestion(
        id: 'mfa_q2',
        primaryIndex: 2,
        text:
            'Are there any internal systems that allow login without MFA because they are considered "trusted" or are inside the network perimeter?',
        answers: [
          FlowAnswer(
            text: 'No, MFA is required everywhere regardless of network location',
          ),
          FlowAnswer(
            text: 'Yes, some internal systems skip MFA',
            followUpQuestionId: 'mfa_b3',
            guidance: GuidanceItem(
              meaning: 'Internal systems without MFA rely solely on the network perimeter for protection.',
              risk: 'An insider or attacker already on the network can access CJIS systems with just a password.',
              whereToLook: 'Review authentication settings for internally accessible CJIS systems.',
              whatToCheck: 'Look for internal applications that allow login with only a username and password.',
              firstStep: 'Extend MFA requirements to internal system access, not just remote access.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'mfa_b3',
            diagnosticFlag: 'Internal MFA requirements may not be defined',
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

      // ── Branch: internal network access to CJIS without MFA ────────────
      'mfa_b3': const FlowQuestion(
        id: 'mfa_b3',
        text:
            'Could someone with internal network access reach CJIS systems without ever being prompted for a second factor?',
        answers: [
          FlowAnswer(text: 'No, MFA is always required at the application level'),
          FlowAnswer(
            text: 'Yes, once on the network they can access CJIS with just a password',
            guidance: GuidanceItem(
              meaning: 'Network-level trust without application MFA means any internal machine is a potential entry point.',
              risk: 'Lateral movement inside the network is a common attack path against CJIS data.',
              whereToLook: 'Review whether MFA is enforced at the application login screen, not just at network entry.',
              whatToCheck: 'Confirm that being on the internal network alone does not bypass MFA requirements.',
              firstStep: 'Apply MFA at the application layer regardless of network location.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Internal systems may allow access without MFA',
            guidance: GuidanceItem(
              meaning: 'If internal MFA requirements are unclear, the network perimeter may be the only barrier.',
              risk: 'Uncertainty here means an attacker on the internal network may face no second factor.',
              whereToLook: 'Ask IT to confirm how each internal CJIS application handles authentication.',
              whatToCheck: 'Look for any application that grants access after a single password entry on the internal network.',
              firstStep: 'Verify with IT whether MFA is enforced on every CJIS application regardless of network.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // ── Primary Q3: Credential sharing ─────────────────────────────────
      'mfa_q3': const FlowQuestion(
        id: 'mfa_q3',
        primaryIndex: 3,
        text:
            'Do users ever share credentials — even temporarily — for example, during emergencies, shift changes, or when someone is locked out of their account?',
        answers: [
          FlowAnswer(
            text: 'Yes',
            followUpQuestionId: 'mfa_b2',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Shared credentials eliminate individual accountability for system actions.',
              risk: 'Credential sharing undermines both authentication integrity and auditability.',
              whereToLook: 'Review your current password and acceptable use policies.',
              whatToCheck: 'Confirm whether the policy explicitly prohibits sharing credentials under any circumstances.',
              firstStep: 'Prohibit credential sharing through policy and reinforce it with regular training.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(text: 'No'),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'mfa_b2',
            diagnosticFlag: 'Credential sharing policy may not be enforced',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about credential sharing suggests no clear prohibition or enforcement exists.',
              risk: 'Shared credentials eliminate individual accountability and undermine authentication controls.',
              whereToLook: 'Review your current acceptable use and password policies.',
              whatToCheck: 'Confirm whether the policy explicitly prohibits sharing credentials and whether it is enforced.',
              firstStep: 'Ask staff and IT whether sharing credentials is occurring and document the findings.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // ── Branch: attribution when credentials are shared ────────────────
      'mfa_b2': const FlowQuestion(
        id: 'mfa_b2',
        text:
            'When credentials are shared, how are actions attributed to the specific individual who performed them?',
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

      // ── Primary Q4: Password management ────────────────────────────────
      'mfa_q4': const FlowQuestion(
        id: 'mfa_q4',
        primaryIndex: 4,
        text:
            'How are passwords managed across your CJIS systems — are there enforced complexity requirements, restrictions on reuse, and regular expiration policies?',
        answers: [
          FlowAnswer(
            text: 'Yes, all of these are enforced automatically by the system',
          ),
          FlowAnswer(
            text: 'Some policies exist but are not consistently enforced',
            followUpQuestionId: 'mfa_b7',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Inconsistently enforced password policies leave gaps that attackers can exploit.',
              risk: 'Weak or reused passwords are among the most common initial access vectors in breaches.',
              whereToLook: 'Review your current password policy and how it is enforced across all systems.',
              whatToCheck: 'Confirm whether complexity rules, reuse restrictions, and expiration are enforced automatically.',
              firstStep: 'Audit password settings on all CJIS systems and enable automatic enforcement where missing.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Default or simple passwords are still used on some systems',
            followUpQuestionId: 'mfa_b7',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Default and simple passwords are among the most exploited vulnerabilities in any environment.',
              risk: 'Attackers routinely test default credentials as a first step in unauthorized access attempts.',
              whereToLook: 'Review your current password policy and any system default credential documentation.',
              whatToCheck: 'Look for systems that still use factory-set or easily guessable passwords.',
              firstStep: 'Enforce a password policy requiring complexity and change defaults on all systems immediately.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'mfa_b7',
            diagnosticFlag: 'Password policy enforcement may not be verified',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about password management suggests policies may not be defined or enforced.',
              risk: 'Without enforcement, weak passwords are likely present across systems.',
              whereToLook: 'Check whether a written password complexity policy exists.',
              whatToCheck: 'Confirm whether password complexity rules are enforced automatically by each system.',
              firstStep: 'Audit password configurations on critical systems and implement an enforced policy.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // ── Branch: password policy enforcement gaps ──────────────────────
      'mfa_b7': const FlowQuestion(
        id: 'mfa_b7',
        text:
            'Which specific systems have the weakest password enforcement, and who is responsible for remediating those gaps?',
        answers: [
          FlowAnswer(
            text: 'We know which systems are weaker and have a plan to address them',
          ),
          FlowAnswer(
            text: 'We have not inventoried which systems have weaker settings',
            diagnosticFlag: 'Weak password settings may not be identified',
            guidance: GuidanceItem(
              meaning: 'Without knowing which systems have weak password settings, remediation cannot be targeted.',
              risk: 'Unidentified weak points remain exploitable indefinitely.',
              whereToLook: 'Ask IT for a per-system breakdown of password policy configurations.',
              whatToCheck: 'Confirm whether each system enforces the same minimum complexity, reuse, and expiration rules.',
              firstStep: 'Create an inventory of password enforcement settings across all CJIS-connected systems.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Responsibility is unclear',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about who owns password policy enforcement suggests no one is actively managing it.',
              risk: 'Without a responsible owner, password policy gaps persist and worsen over time.',
              whereToLook: 'Determine whether IT, security, or management is responsible for password policy enforcement.',
              whatToCheck: 'Confirm that a specific person or team is accountable for ensuring password policies are applied consistently.',
              firstStep: 'Assign ownership for password policy enforcement and schedule a system-by-system audit.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // ── Primary Q5: Account recovery and MFA reset ─────────────────────
      'mfa_q5': const FlowQuestion(
        id: 'mfa_q5',
        primaryIndex: 5,
        text:
            'What account recovery or MFA reset processes exist, and how is a user\'s identity verified before restoring their access?',
        answers: [
          FlowAnswer(
            text: 'Identity is verified in person or through a secure, documented process',
          ),
          FlowAnswer(
            text: 'Recovery relies on email, phone, or help desk without strong verification',
            followUpQuestionId: 'mfa_b4',
            guidance: GuidanceItem(
              meaning: 'Weak identity verification during recovery can be exploited to gain unauthorized access.',
              risk: 'Account recovery is a common social engineering target in law enforcement environments.',
              whereToLook: 'Review your current account recovery and MFA reset procedures.',
              whatToCheck: 'Confirm what steps are required to verify identity before resetting access.',
              firstStep: 'Strengthen identity verification for recovery by requiring in-person or multi-factor confirmation.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'mfa_b4',
            diagnosticFlag: 'Account recovery process may not be defined',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about recovery processes suggests they may not be formally defined.',
              risk: 'Undefined recovery processes are vulnerable to social engineering and impersonation.',
              whereToLook: 'Ask IT to walk you through the current account recovery and MFA reset workflow.',
              whatToCheck: 'Confirm what identity verification is required before any account or MFA reset.',
              firstStep: 'Document the current recovery process and evaluate whether it could be exploited.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // ── Branch: recovery process exploitation ──────────────────────────
      'mfa_b4': const FlowQuestion(
        id: 'mfa_b4',
        text:
            'Could an attacker impersonating a legitimate user exploit the recovery process to gain access?',
        answers: [
          FlowAnswer(
            text: 'No, the process includes safeguards against impersonation',
          ),
          FlowAnswer(
            text: 'Yes, it would be relatively easy to bypass',
            guidance: GuidanceItem(
              meaning: 'A recovery process vulnerable to impersonation effectively bypasses all primary authentication controls.',
              risk: 'Social engineering attacks targeting help desks are one of the most successful breach tactics.',
              whereToLook: 'Review the specific steps and verification questions used during account recovery.',
              whatToCheck: 'Confirm whether the process uses information that an attacker could easily obtain.',
              firstStep: 'Redesign the recovery process to require in-person verification or out-of-band confirmation.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Account recovery security may not be evaluated',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about recovery security suggests the process has not been evaluated for exploitation.',
              risk: 'An untested recovery process may be the weakest link in your authentication chain.',
              whereToLook: 'Review the recovery process documentation and test it against common social engineering scenarios.',
              whatToCheck: 'Confirm whether the process relies on easily obtainable information like name or badge number.',
              firstStep: 'Conduct a walkthrough of the recovery process and evaluate its resistance to impersonation.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // ── Primary Q6: Fallback authentication methods ────────────────────
      'mfa_q6': const FlowQuestion(
        id: 'mfa_q6',
        primaryIndex: 6,
        text:
            'Are there fallback authentication methods — such as SMS codes, email verification, or backup codes — and how secure are those alternatives compared to the primary method?',
        answers: [
          FlowAnswer(
            text: 'Fallback methods are equally secure or not available',
          ),
          FlowAnswer(
            text: 'Fallback methods are less secure than the primary method',
            followUpQuestionId: 'mfa_b5',
            guidance: GuidanceItem(
              meaning: 'Less secure fallback methods can be targeted to bypass your primary authentication controls.',
              risk: 'Attackers often target the weakest authentication path, not the strongest.',
              whereToLook: 'Review which fallback methods are configured for each CJIS system.',
              whatToCheck: 'Confirm whether SMS, email, or backup codes are available as alternatives to primary MFA.',
              firstStep: 'Evaluate each fallback method and disable any that are significantly weaker than the primary.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'mfa_b5',
            diagnosticFlag: 'Fallback authentication security may not be evaluated',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about fallback methods suggests they may not have been evaluated for security.',
              risk: 'Unknown fallback methods may provide an unintended bypass to primary controls.',
              whereToLook: 'Ask IT which fallback authentication options are configured on each system.',
              whatToCheck: 'Look for SMS, email, or backup code options that users could use instead of primary MFA.',
              firstStep: 'Inventory all fallback authentication methods and evaluate their security relative to primary MFA.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // ── Branch: fallback method bypass risk ────────────────────────────
      'mfa_b5': const FlowQuestion(
        id: 'mfa_b5',
        text:
            'Can a user bypass the primary MFA method entirely by choosing a less secure fallback — such as an SMS code instead of an authenticator app?',
        answers: [
          FlowAnswer(text: 'No, the primary method is always required first'),
          FlowAnswer(
            text: 'Yes, users can choose the weaker method directly',
            guidance: GuidanceItem(
              meaning: 'If users can choose the weakest option, effective security is limited to that fallback method.',
              risk: 'SMS and email-based codes are vulnerable to interception, SIM swapping, and phishing.',
              whereToLook: 'Review authentication configurations to see whether users can self-select fallback methods.',
              whatToCheck: 'Confirm whether the system enforces the primary method before allowing any fallback.',
              firstStep: 'Configure systems to require the primary MFA method and restrict fallback to emergency use only.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Fallback method bypass may not be prevented',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about fallback enforcement suggests users may be able to choose weaker methods.',
              risk: 'If users can self-select authentication methods, the strongest method becomes optional.',
              whereToLook: 'Ask IT whether users can choose which MFA method to use at login.',
              whatToCheck: 'Confirm how fallback methods are triggered and whether users can select them voluntarily.',
              firstStep: 'Test the login flow or ask IT to demonstrate what MFA options users see at authentication.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // ── Primary Q7: Device and location restrictions ───────────────────
      'mfa_q7': const FlowQuestion(
        id: 'mfa_q7',
        primaryIndex: 7,
        text:
            'Is login access restricted by device, location, or network — or can users authenticate to CJIS systems from anywhere with valid credentials?',
        answers: [
          FlowAnswer(
            text: 'Yes, access is restricted by device, location, or network',
          ),
          FlowAnswer(
            text: 'No, valid credentials work from any device or location',
            followUpQuestionId: 'mfa_b6',
            guidance: GuidanceItem(
              meaning: 'Without device or location binding, credentials alone grant access from anywhere.',
              risk: 'Stolen credentials can be used from any location without additional controls.',
              whereToLook: 'Review your current authentication and access policy for location or device rules.',
              whatToCheck: 'Confirm whether login attempts from unusual locations or unknown devices trigger any alert or block.',
              firstStep: 'Consider implementing device certificates, IP restrictions, or location-based access controls.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'mfa_b6',
            diagnosticFlag: 'Conditional access controls may not be in place',
            guidance: GuidanceItem(
              meaning: 'Uncertainty suggests conditional access policies may not be in place.',
              risk: 'Without conditional access, authentication context cannot be verified.',
              whereToLook: 'Ask IT whether any rules restrict logins based on device type or physical location.',
              whatToCheck: 'Look for a policy or system configuration that defines where logins are permitted from.',
              firstStep: 'Confirm with IT whether device or location restrictions are enforced on CJIS system logins.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // ── Branch: unmanaged or personal device access ────────────────────
      'mfa_b6': const FlowQuestion(
        id: 'mfa_b6',
        text:
            'Can users authenticate to CJIS systems from unmanaged or personal devices — such as a home laptop or personal phone?',
        answers: [
          FlowAnswer(text: 'No, only agency-managed devices are permitted'),
          FlowAnswer(
            text: 'Yes, personal or unmanaged devices can be used',
            guidance: GuidanceItem(
              meaning: 'Personal devices are outside your control and may not meet security baselines.',
              risk: 'Unmanaged devices can carry malware, lack encryption, or store credentials insecurely.',
              whereToLook: 'Review your remote access policy and device management inventory.',
              whatToCheck: 'Confirm whether personal device access is formally approved and what controls are required.',
              firstStep: 'Implement device compliance checks or restrict CJIS access to managed devices only.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Personal device access may not be restricted',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about device types suggests no device management policy may be in place.',
              risk: 'Without device control, CJIS systems may be accessible from compromised endpoints.',
              whereToLook: 'Ask IT whether personal devices can connect to CJIS systems.',
              whatToCheck: 'Look for a device management policy and confirm which device types are approved.',
              firstStep: 'Work with IT to define which devices are permitted and enforce that policy.',
              cjisReference: 'CJIS 5.6.2.2',
            ),
          ),
        ],
      ),

      // ── Primary Q8: Login monitoring and alerting ──────────────────────
      'mfa_q8': const FlowQuestion(
        id: 'mfa_q8',
        primaryIndex: 8,
        text:
            'Are failed login attempts, MFA bypass attempts, or suspicious access patterns actively monitored and reviewed by someone on your team?',
        answers: [
          FlowAnswer(text: 'Yes, they are monitored and reviewed regularly'),
          FlowAnswer(
            text: 'Logs exist but no one actively reviews them',
            followUpQuestionId: 'mfa_b8',
            guidance: GuidanceItem(
              meaning: 'Unreviewed security logs provide no protection — they only help after a breach is already discovered.',
              risk: 'Attackers rely on the fact that failed attempts and anomalies often go unnoticed.',
              whereToLook: 'Review your current log monitoring and alerting configurations.',
              whatToCheck: 'Confirm who is responsible for reviewing login anomalies and how often reviews occur.',
              firstStep: 'Assign someone to review authentication logs at least weekly and set up alerts for failed attempts.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'No monitoring is in place',
            followUpQuestionId: 'mfa_b8',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Without login monitoring, unauthorized access attempts are invisible to your team.',
              risk: 'An attacker can attempt credentials repeatedly or exploit MFA gaps without any detection.',
              whereToLook: 'Check whether authentication systems are configured to generate security logs.',
              whatToCheck: 'Confirm whether any alerting exists for failed logins, lockouts, or unusual access patterns.',
              firstStep: 'Enable login attempt logging and configure alerts for repeated failures or unusual patterns.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            followUpQuestionId: 'mfa_b8',
            diagnosticFlag: 'Authentication monitoring may not be active',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about monitoring suggests authentication events may not be tracked or reviewed.',
              risk: 'Without monitoring, you have no way to detect ongoing attacks or credential compromise.',
              whereToLook: 'Ask IT whether authentication logs are generated and whether anyone reviews them.',
              whatToCheck: 'Look for any alerting rules, dashboards, or review schedules related to login activity.',
              firstStep: 'Confirm with IT whether authentication monitoring exists and who is responsible for it.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
        ],
      ),

      // ── Branch: incident response for authentication anomalies ─────────
      'mfa_b8': const FlowQuestion(
        id: 'mfa_b8',
        text:
            'If a suspicious login pattern were detected today — such as repeated failures or logins from an unusual location — what would happen next?',
        answers: [
          FlowAnswer(
            text: 'There is a defined incident response process that would be triggered',
          ),
          FlowAnswer(
            text: 'Someone would probably notice eventually but there is no formal process',
            diagnosticFlag: 'Control may not be consistently enforced',
            guidance: GuidanceItem(
              meaning: 'Without a defined response process, detected anomalies may not be acted on in time.',
              risk: 'Delayed response to authentication anomalies gives attackers time to establish persistent access.',
              whereToLook: 'Review your incident response plan for authentication-related events.',
              whatToCheck: 'Confirm whether specific steps, escalation contacts, and timelines are defined for login anomalies.',
              firstStep: 'Create a simple response playbook for authentication anomalies with clear escalation steps.',
              cjisReference: 'CJIS 5.6.2.1',
            ),
          ),
          FlowAnswer(
            text: 'Not sure',
            diagnosticFlag: 'Responsibility is unclear',
            guidance: GuidanceItem(
              meaning: 'Uncertainty about incident response for authentication events suggests no one owns this process.',
              risk: 'Without a clear response owner, suspicious activity can go unaddressed until damage occurs.',
              whereToLook: 'Ask IT and management who would be notified if a suspicious login were detected.',
              whatToCheck: 'Confirm whether anyone is assigned to respond to authentication alerts and what their process is.',
              firstStep: 'Designate a person or team responsible for responding to authentication anomalies and document the process.',
              cjisReference: 'CJIS 5.6.2.1',
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
