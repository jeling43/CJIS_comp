import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/models/guidance_models.dart';
import 'package:cjis_comp/data/guidance_data.dart';

void main() {
  group('CJIS Mapping and Risk Context Tests', () {
    test('All categories should have CJIS policy references', () {
      for (final category in GuidanceData.categories) {
        expect(category.cjisPolicyReferences, isNotNull,
            reason:
                'Category ${category.title} should have CJIS policy references');
        expect(category.cjisPolicyReferences, isNotEmpty,
            reason:
                'Category ${category.title} should have at least one CJIS policy reference');
      }
    });

    test(
        'CJIS policy references should have section numbers and interpretations',
        () {
      for (final category in GuidanceData.categories) {
        for (final reference in category.cjisPolicyReferences) {
          expect(reference.sectionNumber, isNotEmpty,
              reason:
                  'Policy reference in ${category.title} should have section number');
          expect(reference.plainLanguageInterpretation, isNotEmpty,
              reason:
                  'Policy reference in ${category.title} should have plain language interpretation');
        }
      }
    });

    test('All categories should have risk context', () {
      for (final category in GuidanceData.categories) {
        expect(category.riskContext, isNotNull,
            reason: 'Category ${category.title} should have risk context');
        expect(category.riskContext.title, isNotEmpty,
            reason: 'Risk context in ${category.title} should have title');
        expect(category.riskContext.riskPoints, isNotEmpty,
            reason:
                'Risk context in ${category.title} should have risk points');
      }
    });

    test('All categories should have common failure patterns', () {
      for (final category in GuidanceData.categories) {
        expect(category.commonFailures, isNotNull,
            reason:
                'Category ${category.title} should have common failures list');
        expect(category.commonFailures, isNotEmpty,
            reason:
                'Category ${category.title} should have at least one common failure pattern');
      }
    });

    test('Common failure patterns should have pattern and description', () {
      for (final category in GuidanceData.categories) {
        for (final failure in category.commonFailures) {
          expect(failure.pattern, isNotEmpty,
              reason:
                  'Failure pattern in ${category.title} should have pattern name');
          expect(failure.description, isNotEmpty,
              reason:
                  'Failure pattern in ${category.title} should have description');
        }
      }
    });

    test('All categories should have priority guidance', () {
      for (final category in GuidanceData.categories) {
        expect(category.priorityGuidance, isNotNull,
            reason: 'Category ${category.title} should have priority guidance');
        expect(category.priorityGuidance.higherRiskWhen, isNotEmpty,
            reason:
                'Priority guidance in ${category.title} should have higher risk condition');
        expect(category.priorityGuidance.lowerRiskWhen, isNotEmpty,
            reason:
                'Priority guidance in ${category.title} should have lower risk condition');
      }
    });

    test('Access Control should have specific CJIS references', () {
      final category = GuidanceData.getCategoryById('access_control');
      expect(category, isNotNull);
      expect(category!.cjisPolicyReferences.length, greaterThanOrEqualTo(1));

      final hasSection52 = category.cjisPolicyReferences
          .any((ref) => ref.sectionNumber.contains('5.2'));
      expect(hasSection52, isTrue,
          reason: 'Access Control should reference section 5.2');
    });

    test('Authentication and MFA should have specific CJIS references', () {
      final category = GuidanceData.getCategoryById('authentication_mfa');
      expect(category, isNotNull);

      final hasSection56 = category!.cjisPolicyReferences
          .any((ref) => ref.sectionNumber.contains('5.6'));
      expect(hasSection56, isTrue,
          reason: 'Authentication and MFA should reference section 5.6');
    });

    test('Data Storage should have specific CJIS references', () {
      final category = GuidanceData.getCategoryById('data_storage');
      expect(category, isNotNull);

      final hasSection510 = category!.cjisPolicyReferences
          .any((ref) => ref.sectionNumber.contains('5.10'));
      expect(hasSection510, isTrue,
          reason: 'Data Storage should reference section 5.10');
    });

    test('Risk context titles should be appropriate', () {
      for (final category in GuidanceData.categories) {
        final title = category.riskContext.title.toLowerCase();
        final hasAppropriateTitle = title.contains('risk') ||
            title.contains('why') ||
            title.contains('matter');
        expect(hasAppropriateTitle, isTrue,
            reason:
                'Risk context title in ${category.title} should mention risk, why, or matter');
      }
    });

    test('Priority guidance should not contain numeric scores', () {
      for (final category in GuidanceData.categories) {
        final guidance = category.priorityGuidance;

        // Check for numeric scoring patterns
        final scorePatterns = [
          RegExp(r'\d+/\d+'), // e.g., 3/5, 7/10
          RegExp(r'\d+\s*points?'), // e.g., 5 points, 3 point
          RegExp(r'score\s*of\s*\d+'), // e.g., score of 7
        ];

        for (final pattern in scorePatterns) {
          expect(pattern.hasMatch(guidance.higherRiskWhen), isFalse,
              reason: 'Higher risk guidance should not contain numeric scores');
          expect(pattern.hasMatch(guidance.lowerRiskWhen), isFalse,
              reason: 'Lower risk guidance should not contain numeric scores');
        }
      }
    });

    test('Plain language interpretations should not be verbatim policy quotes',
        () {
      // This is a heuristic test - we check that interpretations don't start with
      // typical policy language that would indicate verbatim quotes
      final policyLanguagePatterns = [
        'shall',
        'must',
        'the agency shall',
        'the cso shall',
      ];

      for (final category in GuidanceData.categories) {
        for (final reference in category.cjisPolicyReferences) {
          final interpretation =
              reference.plainLanguageInterpretation.toLowerCase();

          // Plain language should avoid formal policy language
          final startsWithPolicyLanguage = policyLanguagePatterns
              .any((pattern) => interpretation.startsWith(pattern));

          expect(startsWithPolicyLanguage, isFalse,
              reason:
                  'Policy interpretation in ${category.title} should use plain language, not policy quotes');
        }
      }
    });

    test('Each category should have at least 3 risk points', () {
      for (final category in GuidanceData.categories) {
        expect(category.riskContext.riskPoints.length, greaterThanOrEqualTo(3),
            reason:
                'Category ${category.title} should have at least 3 risk points');
      }
    });

    test('Each category should have at least 3 common failure patterns', () {
      for (final category in GuidanceData.categories) {
        expect(category.commonFailures.length, greaterThanOrEqualTo(3),
            reason:
                'Category ${category.title} should have at least 3 common failure patterns');
      }
    });
  });
}
