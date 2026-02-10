import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/models/guidance_models.dart';
import 'package:cjis_comp/data/guidance_data.dart';

void main() {
  group('Guided Prompts Tests', () {
    test('Access Control category should have guided prompts', () {
      final category = GuidanceData.getCategoryById('access_control');
      expect(category, isNotNull);
      expect(category!.guidedPrompts, isNotNull,
          reason: 'Access Control should have guided prompts');
    });

    test('Guided prompts should have introduction', () {
      final category = GuidanceData.getCategoryById('access_control');
      expect(category!.guidedPrompts!.introduction, isNotEmpty,
          reason: 'Guided prompts should have an introduction');
    });

    test('Guided prompts should have 9 sections', () {
      final category = GuidanceData.getCategoryById('access_control');
      expect(category!.guidedPrompts!.sections.length, equals(9),
          reason: 'Access Control guided prompts should have 9 sections');
    });

    test('All guided prompt sections should have title and questions', () {
      final category = GuidanceData.getCategoryById('access_control');
      for (final section in category!.guidedPrompts!.sections) {
        expect(section.title, isNotEmpty,
            reason: 'Each section should have a title');
        expect(section.questions, isNotEmpty,
            reason: 'Each section should have at least one question');
      }
    });

    test('Guided prompts should have higher risk situations', () {
      final category = GuidanceData.getCategoryById('access_control');
      expect(category!.guidedPrompts!.higherRiskSituations, isNotEmpty,
          reason: 'Guided prompts should have higher risk situations');
      expect(category.guidedPrompts!.higherRiskSituations.length,
          greaterThanOrEqualTo(3),
          reason: 'Should have at least 3 higher risk situations');
    });

    test('Guided prompts should have lower risk situations', () {
      final category = GuidanceData.getCategoryById('access_control');
      expect(category!.guidedPrompts!.lowerRiskSituations, isNotEmpty,
          reason: 'Guided prompts should have lower risk situations');
      expect(category.guidedPrompts!.lowerRiskSituations.length,
          greaterThanOrEqualTo(3),
          reason: 'Should have at least 3 lower risk situations');
    });

    test('Guided prompts should reference CJIS policy sections', () {
      final category = GuidanceData.getCategoryById('access_control');
      expect(category!.guidedPrompts!.policySections, isNotEmpty,
          reason: 'Guided prompts should reference policy sections');
      expect(category.guidedPrompts!.policySections, contains('5.5'),
          reason: 'Should reference section 5.5');
      expect(category.guidedPrompts!.policySections, contains('5.6'),
          reason: 'Should reference section 5.6');
      expect(category.guidedPrompts!.policySections, contains('5.10'),
          reason: 'Should reference section 5.10');
    });

    test('Section titles should match expected topics', () {
      final category = GuidanceData.getCategoryById('access_control');
      final sectionTitles = category!.guidedPrompts!.sections
          .map((s) => s.title)
          .toList();

      expect(sectionTitles, contains('Who uses CJIS systems'));
      expect(sectionTitles, contains('Individual access vs shared access'));
      expect(sectionTitles, contains('How people get to CJIS systems'));
      expect(sectionTitles, contains('Booking and records computers'));
      expect(sectionTitles, contains('Shared printers and other devices'));
      expect(sectionTitles, contains('Other access paths'));
      expect(sectionTitles, contains('Who is responsible'));
      expect(sectionTitles, contains('When access should change'));
      expect(sectionTitles, contains('Consistency check'));
    });

    test('All sections should have context hints', () {
      final category = GuidanceData.getCategoryById('access_control');
      for (final section in category!.guidedPrompts!.sections) {
        expect(section.context, isNotNull,
            reason: 'Section "${section.title}" should have context');
        expect(section.context, isNotEmpty,
            reason: 'Section "${section.title}" context should not be empty');
      }
    });

    test('Introduction mentions that "Not sure" is valid response', () {
      final category = GuidanceData.getCategoryById('access_control');
      final intro = category!.guidedPrompts!.introduction.toLowerCase();
      expect(intro.contains('not sure'), isTrue,
          reason: 'Introduction should mention that "Not sure" is valid');
    });

    test('Questions should be plain language (not technical)', () {
      final category = GuidanceData.getCategoryById('access_control');
      final allQuestions = category!.guidedPrompts!.sections
          .expand((s) => s.questions)
          .toList();

      // Check that questions end with question marks
      for (final question in allQuestions) {
        expect(question.endsWith('?'), isTrue,
            reason: 'Question "$question" should end with question mark');
      }

      // Check that questions don't use overly technical jargon
      final technicalTerms = ['RFC', 'FIPS', 'algorithm', 'protocol stack'];
      for (final question in allQuestions) {
        for (final term in technicalTerms) {
          expect(question.toLowerCase().contains(term.toLowerCase()), isFalse,
              reason:
                  'Question "$question" should not contain technical term "$term"');
        }
      }
    });
  });

  group('GuidedPromptSection Model Tests', () {
    test('GuidedPromptSection with context', () {
      const section = GuidedPromptSection(
        title: 'Test Section',
        questions: ['Question 1?', 'Question 2?'],
        context: 'Test context',
      );

      expect(section.title, equals('Test Section'));
      expect(section.questions.length, equals(2));
      expect(section.context, equals('Test context'));
    });

    test('GuidedPromptSection without context', () {
      const section = GuidedPromptSection(
        title: 'Test Section',
        questions: ['Question 1?'],
      );

      expect(section.title, equals('Test Section'));
      expect(section.context, isNull);
    });
  });

  group('GuidedPrompts Model Tests', () {
    test('GuidedPrompts creation', () {
      const prompts = GuidedPrompts(
        introduction: 'Test intro',
        sections: [],
        higherRiskSituations: ['Risk 1', 'Risk 2'],
        lowerRiskSituations: ['Safe 1', 'Safe 2'],
        policySections: ['5.1', '5.2'],
      );

      expect(prompts.introduction, equals('Test intro'));
      expect(prompts.sections, isEmpty);
      expect(prompts.higherRiskSituations.length, equals(2));
      expect(prompts.lowerRiskSituations.length, equals(2));
      expect(prompts.policySections.length, equals(2));
    });
  });
}
