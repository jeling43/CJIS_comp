import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/models/results_models.dart';
import 'package:cjis_comp/data/results_sample_data.dart';

void main() {
  group('ResultsModels', () {
    test('DomainResult attentionIntensity is 0 when no signals', () {
      const dr = DomainResult(
        domainId: 'test',
        title: 'Test',
        icon: '🔒',
        highRiskConditions: 0,
        uncertainResponses: 0,
        riskLevel: RiskLevel.low,
        confidenceLevel: ConfidenceLevel.high,
        questionsAnswered: 5,
        totalQuestions: 5,
      );
      expect(dr.attentionIntensity, 0.0);
    });

    test('DomainResult attentionIntensity is capped at 1.0', () {
      const dr = DomainResult(
        domainId: 'test',
        title: 'Test',
        icon: '🔒',
        highRiskConditions: 10,
        uncertainResponses: 10,
        riskLevel: RiskLevel.high,
        confidenceLevel: ConfidenceLevel.low,
        questionsAnswered: 5,
        totalQuestions: 5,
      );
      expect(dr.attentionIntensity, 1.0);
    });

    test('DomainResult attentionIntensity scales proportionally', () {
      const dr = DomainResult(
        domainId: 'test',
        title: 'Test',
        icon: '🔒',
        highRiskConditions: 2,
        uncertainResponses: 1,
        riskLevel: RiskLevel.moderate,
        confidenceLevel: ConfidenceLevel.moderate,
        questionsAnswered: 3,
        totalQuestions: 6,
      );
      expect(dr.attentionIntensity, 0.5);
    });

    test('DomainResult coverage is 0 when no questions answered', () {
      const dr = DomainResult(
        domainId: 'test',
        title: 'Test',
        icon: '🔒',
        highRiskConditions: 0,
        uncertainResponses: 0,
        riskLevel: RiskLevel.low,
        confidenceLevel: ConfidenceLevel.high,
        questionsAnswered: 0,
        totalQuestions: 5,
      );
      expect(dr.coverage, 0.0);
    });

    test('DomainResult coverage is 1 when all questions answered', () {
      const dr = DomainResult(
        domainId: 'test',
        title: 'Test',
        icon: '🔒',
        highRiskConditions: 0,
        uncertainResponses: 0,
        riskLevel: RiskLevel.low,
        confidenceLevel: ConfidenceLevel.high,
        questionsAnswered: 5,
        totalQuestions: 5,
      );
      expect(dr.coverage, 1.0);
    });

    test('DomainResult coverage handles 0 total questions', () {
      const dr = DomainResult(
        domainId: 'test',
        title: 'Test',
        icon: '🔒',
        highRiskConditions: 0,
        uncertainResponses: 0,
        riskLevel: RiskLevel.low,
        confidenceLevel: ConfidenceLevel.high,
        questionsAnswered: 0,
        totalQuestions: 0,
      );
      expect(dr.coverage, 0.0);
    });

    test('FailurePatternDetail stores all fields correctly', () {
      const fp = FailurePatternDetail(
        pattern: 'Shared accounts',
        explanation: 'Users share logins',
        whyItMatters: 'Loss of accountability',
        firstStep: 'Inventory accounts',
        occurrences: 3,
      );
      expect(fp.pattern, 'Shared accounts');
      expect(fp.explanation, 'Users share logins');
      expect(fp.whyItMatters, 'Loss of accountability');
      expect(fp.firstStep, 'Inventory accounts');
      expect(fp.occurrences, 3);
    });

    test('ConfidenceRiskPoint stores all fields correctly', () {
      const crp = ConfidenceRiskPoint(
        domainId: 'access_control',
        label: 'Access Control',
        confidence: 0.25,
        risk: 0.85,
      );
      expect(crp.domainId, 'access_control');
      expect(crp.label, 'Access Control');
      expect(crp.confidence, 0.25);
      expect(crp.risk, 0.85);
    });

    test('ResultsData holds all components', () {
      const data = ResultsData(
        domainResults: [],
        failurePatterns: [],
        confidenceRiskPoints: [],
      );
      expect(data.domainResults, isEmpty);
      expect(data.failurePatterns, isEmpty);
      expect(data.confidenceRiskPoints, isEmpty);
    });
  });

  group('ResultsSampleData', () {
    test('sampleResults has domain results', () {
      expect(ResultsSampleData.sampleResults.domainResults, isNotEmpty);
    });

    test('sampleResults has failure patterns', () {
      expect(ResultsSampleData.sampleResults.failurePatterns, isNotEmpty);
    });

    test('sampleResults has confidence risk points', () {
      expect(
          ResultsSampleData.sampleResults.confidenceRiskPoints, isNotEmpty);
    });

    test('emptyResults has no failure patterns', () {
      expect(ResultsSampleData.emptyResults.failurePatterns, isEmpty);
    });

    test('sampleResults domain results have valid attention intensities', () {
      for (final dr in ResultsSampleData.sampleResults.domainResults) {
        expect(dr.attentionIntensity, greaterThanOrEqualTo(0.0));
        expect(dr.attentionIntensity, lessThanOrEqualTo(1.0));
      }
    });

    test('sampleResults confidence risk points have valid ranges', () {
      for (final crp
          in ResultsSampleData.sampleResults.confidenceRiskPoints) {
        expect(crp.confidence, greaterThanOrEqualTo(0.0));
        expect(crp.confidence, lessThanOrEqualTo(1.0));
        expect(crp.risk, greaterThanOrEqualTo(0.0));
        expect(crp.risk, lessThanOrEqualTo(1.0));
      }
    });
  });

  group('Advisory Language', () {
    test('Sample data does not contain compliance score language', () {
      final forbidden = [
        'compliance score',
        'pass/fail',
        'score:',
        'grade:',
        'audit ready',
        'certified',
      ];
      for (final fp in ResultsSampleData.sampleResults.failurePatterns) {
        final allText =
            '${fp.pattern} ${fp.explanation} ${fp.whyItMatters} ${fp.firstStep}'
                .toLowerCase();
        for (final term in forbidden) {
          expect(allText.contains(term), isFalse,
              reason: 'Failure pattern "$fp.pattern" should not contain "$term"');
        }
      }
    });
  });
}
