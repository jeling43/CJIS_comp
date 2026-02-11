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
                  'Answer option "${option.text}" in question "${question.question}" should have either result or nextQuestionId');
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

  group('Access Control Adaptive Flow Tests', () {
    test('Access Control should have adaptive question flow', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      expect(questions, isNotNull);
      expect(questions!.length, greaterThanOrEqualTo(10),
          reason: 'Adaptive flow should have at least 10 questions for branching');
    });

    test('Access Control should start with baseline question', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      expect(questions!.first.id, equals('ac_baseline'),
          reason: 'First question should be the baseline question');
    });

    test('Access Control should end with closing reflective question', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      final closingQuestion = questions!.firstWhere(
        (q) => q.id == 'ac_closing',
        orElse: () => throw Exception('No closing question found'),
      );
      expect(closingQuestion.question, contains('If three different people'),
          reason: 'Closing question should be reflective');
      // All closing options should have results (end the flow)
      for (final option in closingQuestion.options) {
        expect(option.result, isNotNull,
            reason: 'Closing question options should all have results');
      }
    });

    test('Access Control baseline should branch based on certainty', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      final baseline = questions!.firstWhere((q) => q.id == 'ac_baseline');
      
      // Should have options for confident and uncertain responses
      final optionTexts = baseline.options.map((o) => o.text.toLowerCase()).toList();
      expect(optionTexts.any((t) => t.contains('clear process') || t.contains('specific approves')), isTrue,
          reason: 'Should have a confident/clear response option');
      expect(optionTexts.any((t) => t.contains('not sure') || t.contains('depends')), isTrue,
          reason: 'Should have uncertain response options');
    });

    test('Access Control should have drill-down questions for key topics', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      final questionIds = questions!.map((q) => q.id).toList();
      
      // Check for drill-down topics
      expect(questionIds.any((id) => id.contains('mixed_use') || id.contains('device')), isTrue,
          reason: 'Should have mixed-use computer drill-down');
      expect(questionIds.any((id) => id.contains('shared')), isTrue,
          reason: 'Should have shared devices drill-down');
      expect(questionIds.any((id) => id.contains('remote')), isTrue,
          reason: 'Should have remote access drill-down');
      expect(questionIds.any((id) => id.contains('responsibility')), isTrue,
          reason: 'Should have responsibility boundaries drill-down');
      expect(questionIds.any((id) => id.contains('role') || id.contains('departure')), isTrue,
          reason: 'Should have role changes drill-down');
    });

    test('Access Control questions should use everyday language', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      
      // Check that questions avoid technical jargon
      final technicalTerms = ['RFC', 'FIPS', 'protocol', 'algorithm', 'compliance', 'audit'];
      for (final question in questions!) {
        final questionLower = question.question.toLowerCase();
        for (final term in technicalTerms) {
          expect(questionLower.contains(term.toLowerCase()), isFalse,
              reason: 'Question "${question.question}" should not contain technical term "$term"');
        }
      }
    });

    test('Access Control should have "Not sure" options treated as valid', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      
      // Count questions that have "not sure" type options
      var questionsWithNotSure = 0;
      for (final question in questions!) {
        if (question.options.any((o) => 
            o.text.toLowerCase().contains('not sure') || 
            o.text.toLowerCase().contains('honestly not sure'))) {
          questionsWithNotSure++;
        }
      }
      expect(questionsWithNotSure, greaterThanOrEqualTo(5),
          reason: 'Most questions should have a "not sure" option');
    });

    test('Access Control flow should have max 3 levels deep per branch', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      
      // Build a map of question IDs to questions for traversal
      final questionMap = {for (var q in questions!) q.id: q};
      
      // Helper function to calculate max depth from a question
      int maxDepth(String questionId, Set<String> visited) {
        if (visited.contains(questionId)) return 0; // Prevent cycles
        if (!questionMap.containsKey(questionId)) return 0;
        
        visited.add(questionId);
        final question = questionMap[questionId]!;
        int maxChildDepth = 0;
        
        for (final option in question.options) {
          if (option.nextQuestionId != null && option.result == null) {
            final childDepth = maxDepth(option.nextQuestionId!, Set.from(visited));
            if (childDepth > maxChildDepth) {
              maxChildDepth = childDepth;
            }
          }
        }
        
        return 1 + maxChildDepth;
      }
      
      // Check depth from baseline
      final depth = maxDepth('ac_baseline', {});
      expect(depth, lessThanOrEqualTo(5),
          reason: 'Flow should not exceed reasonable depth (baseline + 3 levels + closing)');
    });

    test('Access Control closing results should be supportive not accusatory', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      final closingQuestion = questions!.firstWhere((q) => q.id == 'ac_closing');
      
      for (final option in closingQuestion.options) {
        final result = option.result!;
        // Should not contain negative/accusatory language
        final negativeTerms = ['fail', 'violation', 'non-compliant', 'problem', 'risk', 'concern'];
        for (final term in negativeTerms) {
          expect(result.description.toLowerCase().contains(term), isFalse,
              reason: 'Result description should not contain negative term "$term"');
        }
        // Results should be empty for riskAreas
        expect(result.riskAreas, isEmpty,
            reason: 'Closing results should not list risk areas');
      }
    });

    test('Access Control question flow should be navigable', () {
      final questions = GuidanceData.getQuestionsForCategory('access_control');
      final questionMap = {for (var q in questions!) q.id: q};
      
      // Verify all nextQuestionIds reference valid questions
      for (final question in questions) {
        for (final option in question.options) {
          if (option.nextQuestionId != null) {
            expect(questionMap.containsKey(option.nextQuestionId), isTrue,
                reason: 'Question "${question.id}" option "${option.text}" references non-existent question "${option.nextQuestionId}"');
          }
        }
      }
    });
  });
}
