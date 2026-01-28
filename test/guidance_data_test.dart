import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/models/guidance_models.dart';
import 'package:cjis_comp/data/guidance_data.dart';

void main() {
  group('Guidance Data Tests', () {
    test('Should have 6 guidance categories', () {
      expect(GuidanceData.categories.length, 6);
    });

    test('All categories should have required fields', () {
      for (final category in GuidanceData.categories) {
        expect(category.id, isNotEmpty);
        expect(category.title, isNotEmpty);
        expect(category.description, isNotEmpty);
        expect(category.icon, isNotEmpty);
        expect(category.keyPoints, isNotEmpty);
      }
    });

    test('Should retrieve category by ID', () {
      final category = GuidanceData.getCategoryById('access_control');
      expect(category, isNotNull);
      expect(category!.title, 'Access Control');
    });

    test('Should return null for invalid category ID', () {
      final category = GuidanceData.getCategoryById('invalid_id');
      expect(category, isNull);
    });

    test('Access Control category should have questions', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      expect(questions, isNotNull);
      expect(questions!.length, greaterThan(0));
    });

    test('MFA category should have questions', () {
      final questions =
          GuidanceData.getQuestionsForCategory('authentication_mfa');
      expect(questions, isNotNull);
      expect(questions!.length, greaterThan(0));
    });

    test('Questions should have answer options', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      for (final question in questions!) {
        expect(question.options, isNotEmpty);
        expect(question.question, isNotEmpty);
      }
    });

    test('Answer options should have either result or next question', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      for (final question in questions!) {
        for (final option in question.options) {
          expect(option.text, isNotEmpty);
          // Each option should have either a result or a next question
          final hasResult = option.result != null;
          final hasNext = option.nextQuestionId != null;
          expect(hasResult || hasNext, isTrue,
              reason:
                  'Answer option should have either result or nextQuestionId');
        }
      }
    });

    test('Guidance results should have required fields', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      for (final question in questions!) {
        for (final option in question.options) {
          if (option.result != null) {
            final result = option.result!;
            expect(result.title, isNotEmpty);
            expect(result.description, isNotEmpty);
            expect(result.recommendations, isNotEmpty);
          }
        }
      }
    });
  });
}
