import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/models/access_control_models.dart';
import 'package:cjis_comp/data/access_control_data.dart';

void main() {
  group('Access Control Models Tests', () {
    test('ClarityLevel enum has expected values', () {
      expect(ClarityLevel.values.length, equals(3));
      expect(ClarityLevel.generallyClear.displayText, equals('Generally Clear'));
      expect(ClarityLevel.reviewRecommended.displayText,
          equals('Review Recommended'));
      expect(ClarityLevel.earlyClarificationRecommended.displayText,
          equals('Early Clarification Recommended'));
    });

    test('ClarificationPriority enum has expected values', () {
      expect(ClarificationPriority.values.length, equals(3));
      expect(ClarificationPriority.standard.displayText, equals('Standard'));
      expect(ClarificationPriority.elevated.displayText, equals('Elevated'));
      expect(ClarificationPriority.focused.displayText, equals('Focused'));
    });

    test('ClarificationPriority has explanations', () {
      for (final priority in ClarificationPriority.values) {
        expect(priority.explanation, isNotEmpty,
            reason: '${priority.name} should have an explanation');
      }
    });

    test('AccessControlQuestion can be created', () {
      const question = AccessControlQuestion(
        id: 'test_q1',
        question: 'Test question?',
        options: [],
      );

      expect(question.id, equals('test_q1'));
      expect(question.question, equals('Test question?'));
      expect(question.isBaseline, isFalse);
      expect(question.isReflective, isFalse);
      expect(question.depth, equals(0));
    });

    test('AccessControlOption can track uncertainty', () {
      const option = AccessControlOption(
        text: 'I\'m not sure',
        indicatesUncertainty: true,
        uncertaintyArea: 'Test area',
      );

      expect(option.text, equals('I\'m not sure'));
      expect(option.indicatesUncertainty, isTrue);
      expect(option.uncertaintyArea, equals('Test area'));
    });

    test('AccessControlResponse records selections', () {
      const response = AccessControlResponse(
        questionId: 'q1',
        questionText: 'Test question?',
        selectedOptionText: 'Test answer',
        indicatesUncertainty: true,
        uncertaintyArea: 'Test uncertainty',
      );

      expect(response.questionId, equals('q1'));
      expect(response.questionText, equals('Test question?'));
      expect(response.selectedOptionText, equals('Test answer'));
      expect(response.indicatesUncertainty, isTrue);
      expect(response.uncertaintyArea, equals('Test uncertainty'));
    });
  });

  group('Access Control Data Tests', () {
    test('Policy references are defined', () {
      expect(AccessControlData.policyReferences, isNotEmpty);
      expect(AccessControlData.policyReferences.length, greaterThanOrEqualTo(3));
    });

    test('Questions list is not empty', () {
      expect(AccessControlData.questions, isNotEmpty);
    });

    test('Questions have baseline questions', () {
      final baselineQuestions =
          AccessControlData.questions.where((q) => q.isBaseline).toList();
      expect(baselineQuestions, isNotEmpty,
          reason: 'Should have at least one baseline question');
      expect(baselineQuestions.length, greaterThanOrEqualTo(3),
          reason: 'Should have at least 3 baseline questions');
    });

    test('Questions have reflective question', () {
      final reflectiveQuestions =
          AccessControlData.questions.where((q) => q.isReflective).toList();
      expect(reflectiveQuestions, isNotEmpty,
          reason: 'Should have at least one reflective question');
    });

    test('All questions have options', () {
      for (final question in AccessControlData.questions) {
        expect(question.options, isNotEmpty,
            reason: 'Question "${question.id}" should have options');
      }
    });

    test('All questions end with question mark', () {
      for (final question in AccessControlData.questions) {
        expect(question.question.endsWith('?'), isTrue,
            reason: 'Question "${question.id}" should end with ?');
      }
    });

    test('getFirstQuestion returns a baseline question', () {
      final firstQuestion = AccessControlData.getFirstQuestion();
      expect(firstQuestion, isNotNull);
      expect(firstQuestion!.isBaseline, isTrue);
    });

    test('getQuestionById returns correct question', () {
      final question = AccessControlData.getQuestionById('ac_baseline_1');
      expect(question, isNotNull);
      expect(question!.id, equals('ac_baseline_1'));
    });

    test('getQuestionById returns null for non-existent question', () {
      final question = AccessControlData.getQuestionById('non_existent');
      expect(question, isNull);
    });

    test('Follow-up questions exist for each category', () {
      expect(AccessControlData.followUpQuestionsByArea['responsibility'],
          isNotNull);
      expect(AccessControlData.followUpQuestionsByArea['access_changes'],
          isNotNull);
      expect(AccessControlData.followUpQuestionsByArea['remote_access'],
          isNotNull);
      expect(AccessControlData.followUpQuestionsByArea['individual_access'],
          isNotNull);
    });

    test('Default follow-up questions are defined', () {
      expect(AccessControlData.defaultFollowUpQuestions, isNotEmpty);
      expect(AccessControlData.defaultFollowUpQuestions.length, equals(4));
    });
  });

  group('Access Control Result Calculation Tests', () {
    test('No uncertainty returns Generally Clear', () {
      final responses = [
        const AccessControlResponse(
          questionId: 'q1',
          questionText: 'Question 1?',
          selectedOptionText: 'Clear answer',
          indicatesUncertainty: false,
        ),
        const AccessControlResponse(
          questionId: 'q2',
          questionText: 'Question 2?',
          selectedOptionText: 'Another clear answer',
          indicatesUncertainty: false,
        ),
      ];

      final result = AccessControlData.calculateResult(responses);

      expect(result.clarityLevel, equals(ClarityLevel.generallyClear));
      expect(result.clarificationPriority,
          equals(ClarificationPriority.standard));
      expect(result.uncertaintyAreas, isEmpty);
    });

    test('Some uncertainty returns Review Recommended', () {
      final responses = [
        const AccessControlResponse(
          questionId: 'q1',
          questionText: 'Question 1?',
          selectedOptionText: 'Clear answer',
          indicatesUncertainty: false,
        ),
        const AccessControlResponse(
          questionId: 'q2',
          questionText: 'Question 2?',
          selectedOptionText: 'Not sure',
          indicatesUncertainty: true,
          uncertaintyArea: 'Test area 1',
        ),
      ];

      final result = AccessControlData.calculateResult(responses);

      expect(result.clarityLevel, equals(ClarityLevel.reviewRecommended));
      expect(result.uncertaintyAreas, contains('Test area 1'));
    });

    test('Multiple uncertainties returns Early Clarification Recommended', () {
      final responses = [
        const AccessControlResponse(
          questionId: 'q1',
          questionText: 'Question 1?',
          selectedOptionText: 'Not sure',
          indicatesUncertainty: true,
          uncertaintyArea: 'Area 1',
        ),
        const AccessControlResponse(
          questionId: 'q2',
          questionText: 'Question 2?',
          selectedOptionText: 'Not sure',
          indicatesUncertainty: true,
          uncertaintyArea: 'Area 2',
        ),
        const AccessControlResponse(
          questionId: 'q3',
          questionText: 'Question 3?',
          selectedOptionText: 'Not sure',
          indicatesUncertainty: true,
          uncertaintyArea: 'Area 3',
        ),
      ];

      final result = AccessControlData.calculateResult(responses);

      expect(result.clarityLevel,
          equals(ClarityLevel.earlyClarificationRecommended));
      expect(result.clarificationPriority,
          equals(ClarificationPriority.focused));
    });

    test('Result summary text is neutral (no compliance language)', () {
      final responses = [
        const AccessControlResponse(
          questionId: 'q1',
          questionText: 'Question 1?',
          selectedOptionText: 'Not sure',
          indicatesUncertainty: true,
          uncertaintyArea: 'Test area',
        ),
      ];

      final result = AccessControlData.calculateResult(responses);

      // Check that summary doesn't contain compliance/risk/failure language
      expect(result.summaryText.toLowerCase().contains('non-compliance'),
          isFalse);
      expect(result.summaryText.toLowerCase().contains('fail'), isFalse);
      expect(result.summaryText.toLowerCase().contains('risk level'), isFalse);
      expect(result.summaryText.toLowerCase().contains('score'), isFalse);
    });

    test('Result includes suggested follow-up questions', () {
      final responses = [
        const AccessControlResponse(
          questionId: 'q1',
          questionText: 'Question 1?',
          selectedOptionText: 'Not sure',
          indicatesUncertainty: true,
          uncertaintyArea: 'Responsibility area',
        ),
      ];

      final result = AccessControlData.calculateResult(responses);

      expect(result.suggestedFollowUpQuestions, isNotEmpty);
    });
  });

  group('Adaptive Question Flow Tests', () {
    test('Baseline questions have depth 0', () {
      final baselineQuestions =
          AccessControlData.questions.where((q) => q.isBaseline).toList();

      for (final q in baselineQuestions) {
        expect(q.depth, equals(0),
            reason: 'Baseline question "${q.id}" should have depth 0');
      }
    });

    test('Drill-down questions have depth >= 1', () {
      final drillQuestions =
          AccessControlData.questions.where((q) => !q.isBaseline && !q.isReflective).toList();

      for (final q in drillQuestions) {
        expect(q.depth, greaterThanOrEqualTo(1),
            reason: 'Drill-down question "${q.id}" should have depth >= 1');
      }
    });

    test('Some options indicate uncertainty', () {
      final allOptions =
          AccessControlData.questions.expand((q) => q.options).toList();
      final uncertaintyOptions =
          allOptions.where((o) => o.indicatesUncertainty).toList();

      expect(uncertaintyOptions, isNotEmpty,
          reason: 'Some options should indicate uncertainty');
    });

    test('Some options indicate shared responsibility', () {
      final allOptions =
          AccessControlData.questions.expand((q) => q.options).toList();
      final sharedOptions =
          allOptions.where((o) => o.indicatesSharedResponsibility).toList();

      expect(sharedOptions, isNotEmpty,
          reason: 'Some options should indicate shared responsibility');
    });

    test('Questions use plain language (no technical jargon)', () {
      final technicalTerms = ['RFC', 'FIPS', 'algorithm', 'protocol'];

      for (final question in AccessControlData.questions) {
        for (final term in technicalTerms) {
          expect(
              question.question.toLowerCase().contains(term.toLowerCase()),
              isFalse,
              reason:
                  'Question "${question.id}" should not contain technical term "$term"');
        }
      }
    });
  });

  group('Design Principles Verification Tests', () {
    test('ClarityLevel does not use numeric scores', () {
      for (final level in ClarityLevel.values) {
        // Display text should not contain numbers/percentages
        expect(RegExp(r'\d+%').hasMatch(level.displayText), isFalse,
            reason:
                '${level.name} display text should not contain percentages');
        expect(level.displayText.contains('score'), isFalse,
            reason: '${level.name} display text should not mention scores');
      }
    });

    test('ClarityLevel does not use risk terminology', () {
      for (final level in ClarityLevel.values) {
        expect(level.displayText.toLowerCase().contains('risk'), isFalse,
            reason: '${level.name} should not use risk terminology');
        expect(level.displayText.toLowerCase().contains('fail'), isFalse,
            reason: '${level.name} should not use failure terminology');
        expect(level.displayText.toLowerCase().contains('danger'), isFalse,
            reason: '${level.name} should not use danger terminology');
      }
    });

    test('ClarificationPriority uses neutral language', () {
      for (final priority in ClarificationPriority.values) {
        // Should not use alarming language
        expect(priority.explanation.toLowerCase().contains('critical'), isFalse,
            reason: '${priority.name} should not use "critical"');
        expect(priority.explanation.toLowerCase().contains('severe'), isFalse,
            reason: '${priority.name} should not use "severe"');
        expect(priority.explanation.toLowerCase().contains('fail'), isFalse,
            reason: '${priority.name} should not use "fail"');
      }
    });
  });
}
