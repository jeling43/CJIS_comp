import '../models/results_models.dart';

/// Sample/mock data for testing the Results Page visualizations.
///
/// This data is advisory only and does not represent compliance evaluations.
class ResultsSampleData {
  /// Sample results with a mix of attention levels across domains.
  static const ResultsData sampleResults = ResultsData(
    domainResults: [
      DomainResult(
        domainId: 'access_control',
        title: 'Access Control',
        icon: '🔐',
        highRiskConditions: 3,
        uncertainResponses: 2,
        riskLevel: RiskLevel.high,
        confidenceLevel: ConfidenceLevel.low,
        questionsAnswered: 6,
        totalQuestions: 6,
      ),
      DomainResult(
        domainId: 'auth_mfa',
        title: 'Authentication & MFA',
        icon: '🔑',
        highRiskConditions: 2,
        uncertainResponses: 1,
        riskLevel: RiskLevel.moderate,
        confidenceLevel: ConfidenceLevel.moderate,
        questionsAnswered: 4,
        totalQuestions: 6,
      ),
      DomainResult(
        domainId: 'encryption',
        title: 'Encryption',
        icon: '🔒',
        highRiskConditions: 0,
        uncertainResponses: 1,
        riskLevel: RiskLevel.low,
        confidenceLevel: ConfidenceLevel.high,
        questionsAnswered: 0,
        totalQuestions: 5,
      ),
      DomainResult(
        domainId: 'vendor_cloud',
        title: 'Vendor / Cloud',
        icon: '☁️',
        highRiskConditions: 1,
        uncertainResponses: 3,
        riskLevel: RiskLevel.moderate,
        confidenceLevel: ConfidenceLevel.low,
        questionsAnswered: 2,
        totalQuestions: 6,
      ),
    ],
    failurePatterns: [
      FailurePatternDetail(
        pattern: 'Shared account usage',
        explanation:
            'Multiple users appear to share login credentials, making it '
            'difficult to attribute actions to specific individuals.',
        whyItMatters:
            'Individual accountability is a foundational requirement. '
            'Without it, incident response and access review become unreliable.',
        firstStep:
            'Inventory all accounts and identify any that are used by '
            'more than one person.',
        occurrences: 3,
      ),
      FailurePatternDetail(
        pattern: 'Lack of network segmentation',
        explanation:
            'Systems that handle sensitive data may not be isolated from '
            'general-purpose network traffic.',
        whyItMatters:
            'Without segmentation, a compromise on one system can spread '
            'to systems handling protected information.',
        firstStep:
            'Map your network to identify which systems can communicate '
            'with CJIS-connected devices.',
        occurrences: 2,
      ),
      FailurePatternDetail(
        pattern: 'Unverified vendor access',
        explanation:
            'Third-party vendors may have access paths that are not formally '
            'documented or regularly reviewed.',
        whyItMatters:
            'Vendor access that is not tracked creates blind spots in your '
            'overall access management.',
        firstStep:
            'List all vendors with any form of access to your systems and '
            'confirm what each can reach.',
        occurrences: 1,
      ),
      FailurePatternDetail(
        pattern: 'Inconsistent MFA enforcement',
        explanation:
            'Multi-factor authentication may not be applied uniformly '
            'across all access paths.',
        whyItMatters:
            'Partial MFA coverage leaves gaps that can be exploited through '
            'the unprotected access paths.',
        firstStep:
            'Review which access methods require MFA and identify any '
            'that rely on passwords alone.',
        occurrences: 2,
      ),
    ],
    confidenceRiskPoints: [
      ConfidenceRiskPoint(
        domainId: 'access_control',
        label: 'Access Control',
        confidence: 0.25,
        risk: 0.85,
      ),
      ConfidenceRiskPoint(
        domainId: 'auth_mfa',
        label: 'Auth & MFA',
        confidence: 0.55,
        risk: 0.60,
      ),
      ConfidenceRiskPoint(
        domainId: 'encryption',
        label: 'Encryption',
        confidence: 0.80,
        risk: 0.20,
      ),
      ConfidenceRiskPoint(
        domainId: 'vendor_cloud',
        label: 'Vendor / Cloud',
        confidence: 0.30,
        risk: 0.55,
      ),
    ],
  );

  /// Minimal results showing no areas requiring attention.
  static const ResultsData emptyResults = ResultsData(
    domainResults: [
      DomainResult(
        domainId: 'access_control',
        title: 'Access Control',
        icon: '🔐',
        highRiskConditions: 0,
        uncertainResponses: 0,
        riskLevel: RiskLevel.low,
        confidenceLevel: ConfidenceLevel.high,
        questionsAnswered: 6,
        totalQuestions: 6,
      ),
    ],
    failurePatterns: [],
    confidenceRiskPoints: [
      ConfidenceRiskPoint(
        domainId: 'access_control',
        label: 'Access Control',
        confidence: 0.90,
        risk: 0.10,
      ),
    ],
  );
}
