import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/models/guidance_models.dart';
import 'package:cjis_comp/data/guidance_data.dart';

void main() {
  group('All Categories Have Guided Prompts', () {
    final categoryIds = [
      'access_control',
      'authentication_mfa',
      'data_storage',
      'user_roles',
      'cloud_vendor',
      'training',
    ];

    for (final categoryId in categoryIds) {
      test('$categoryId category should have guided prompts', () {
        final category = GuidanceData.getCategoryById(categoryId);
        expect(category, isNotNull);
        expect(category!.guidedPrompts, isNotNull,
            reason: '$categoryId should have guided prompts');
      });

      test('$categoryId guided prompts should have introduction', () {
        final category = GuidanceData.getCategoryById(categoryId);
        expect(category!.guidedPrompts!.introduction, isNotEmpty,
            reason: '$categoryId guided prompts should have an introduction');
      });

      test('$categoryId guided prompts should have 5-9 sections (MVP range)', () {
        final category = GuidanceData.getCategoryById(categoryId);
        expect(category!.guidedPrompts!.sections.length, greaterThanOrEqualTo(5),
            reason: '$categoryId guided prompts should have at least 5 sections');
        expect(category.guidedPrompts!.sections.length, lessThanOrEqualTo(9),
            reason: '$categoryId guided prompts should have at most 9 sections');
      });

      test('$categoryId sections should have title and questions', () {
        final category = GuidanceData.getCategoryById(categoryId);
        for (final section in category!.guidedPrompts!.sections) {
          expect(section.title, isNotEmpty,
              reason: 'Each section should have a title');
          expect(section.questions, isNotEmpty,
              reason: 'Each section should have at least one question');
        }
      });

      test('$categoryId guided prompts should have higher risk situations', () {
        final category = GuidanceData.getCategoryById(categoryId);
        expect(category!.guidedPrompts!.higherRiskSituations, isNotEmpty,
            reason: '$categoryId guided prompts should have higher risk situations');
        expect(category.guidedPrompts!.higherRiskSituations.length,
            greaterThanOrEqualTo(3),
            reason: '$categoryId should have at least 3 higher risk situations');
      });

      test('$categoryId guided prompts should have lower risk situations', () {
        final category = GuidanceData.getCategoryById(categoryId);
        expect(category!.guidedPrompts!.lowerRiskSituations, isNotEmpty,
            reason: '$categoryId guided prompts should have lower risk situations');
        expect(category.guidedPrompts!.lowerRiskSituations.length,
            greaterThanOrEqualTo(3),
            reason: '$categoryId should have at least 3 lower risk situations');
      });

      test('$categoryId guided prompts should reference policy sections', () {
        final category = GuidanceData.getCategoryById(categoryId);
        expect(category!.guidedPrompts!.policySections, isNotEmpty,
            reason: '$categoryId guided prompts should reference policy sections');
      });

      test('$categoryId introduction mentions "Not sure" is valid response', () {
        final category = GuidanceData.getCategoryById(categoryId);
        final intro = category!.guidedPrompts!.introduction.toLowerCase();
        expect(intro.contains('not sure'), isTrue,
            reason: '$categoryId introduction should mention that "Not sure" is valid');
      });

      test('$categoryId questions should be plain language (not technical)', () {
        final category = GuidanceData.getCategoryById(categoryId);
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

      test('$categoryId sections should have context hints', () {
        final category = GuidanceData.getCategoryById(categoryId);
        for (final section in category!.guidedPrompts!.sections) {
          expect(section.context, isNotNull,
              reason: 'Section "${section.title}" should have context');
          expect(section.context, isNotEmpty,
              reason: 'Section "${section.title}" context should not be empty');
        }
      });
    }
  });

  group('Access Control Guided Prompts Tests', () {
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

  group('Authentication and MFA Guided Prompts Tests', () {
    test('Section titles should match expected topics', () {
      final category = GuidanceData.getCategoryById('authentication_mfa');
      final sectionTitles = category!.guidedPrompts!.sections
          .map((s) => s.title)
          .toList();

      expect(sectionTitles, contains('How people log in'));
      expect(sectionTitles, contains('Logging in from different places'));
      expect(sectionTitles, contains('When the usual method doesn\'t work'));
      expect(sectionTitles, contains('Passwords and updates'));
      expect(sectionTitles, contains('Who manages authentication'));
    });

    test('Should have 5 sections', () {
      final category = GuidanceData.getCategoryById('authentication_mfa');
      expect(category!.guidedPrompts!.sections.length, equals(5),
          reason: 'Authentication and MFA guided prompts should have 5 sections');
    });

    test('Should reference CJIS policy sections 5.6 and 5.6.2.2', () {
      final category = GuidanceData.getCategoryById('authentication_mfa');
      expect(category!.guidedPrompts!.policySections, contains('5.6'));
      expect(category!.guidedPrompts!.policySections, contains('5.6.2.2'));
    });
  });

  group('Data Storage and Encryption Guided Prompts Tests', () {
    test('Section titles should match expected topics', () {
      final category = GuidanceData.getCategoryById('data_storage');
      final sectionTitles = category!.guidedPrompts!.sections
          .map((s) => s.title)
          .toList();

      expect(sectionTitles, contains('Where data is stored'));
      expect(sectionTitles, contains('Laptops and mobile devices'));
      expect(sectionTitles, contains('Backups and copies'));
      expect(sectionTitles, contains('Sending data to others'));
      expect(sectionTitles, contains('Old data and disposal'));
    });

    test('Should have 5 sections', () {
      final category = GuidanceData.getCategoryById('data_storage');
      expect(category!.guidedPrompts!.sections.length, equals(5),
          reason: 'Data Storage and Encryption guided prompts should have 5 sections');
    });

    test('Should reference CJIS policy sections 5.10 and 5.10.1.2', () {
      final category = GuidanceData.getCategoryById('data_storage');
      expect(category!.guidedPrompts!.policySections, contains('5.10'));
      expect(category!.guidedPrompts!.policySections, contains('5.10.1.2'));
    });
  });

  group('User Roles and Least Privilege Guided Prompts Tests', () {
    test('Section titles should match expected topics', () {
      final category = GuidanceData.getCategoryById('user_roles');
      final sectionTitles = category!.guidedPrompts!.sections
          .map((s) => s.title)
          .toList();

      expect(sectionTitles, contains('Who can access what'));
      expect(sectionTitles, contains('Changes in roles'));
      expect(sectionTitles, contains('Sensitive actions'));
      expect(sectionTitles, contains('Reviewing access'));
      expect(sectionTitles, contains('Documentation'));
    });

    test('Should have 5 sections', () {
      final category = GuidanceData.getCategoryById('user_roles');
      expect(category!.guidedPrompts!.sections.length, equals(5),
          reason: 'User Roles and Least Privilege guided prompts should have 5 sections');
    });

    test('Should reference CJIS policy sections 5.2.1 and 5.2.2', () {
      final category = GuidanceData.getCategoryById('user_roles');
      expect(category!.guidedPrompts!.policySections, contains('5.2.1'));
      expect(category!.guidedPrompts!.policySections, contains('5.2.2'));
    });
  });

  group('Cloud and Vendor Considerations Guided Prompts Tests', () {
    test('Section titles should match expected topics', () {
      final category = GuidanceData.getCategoryById('cloud_vendor');
      final sectionTitles = category!.guidedPrompts!.sections
          .map((s) => s.title)
          .toList();

      expect(sectionTitles, contains('Outside companies and services'));
      expect(sectionTitles, contains('Vendor access to data'));
      expect(sectionTitles, contains('Agreements and approvals'));
      expect(sectionTitles, contains('Where data is located'));
      expect(sectionTitles, contains('Ongoing oversight'));
    });

    test('Should have 5 sections', () {
      final category = GuidanceData.getCategoryById('cloud_vendor');
      expect(category!.guidedPrompts!.sections.length, equals(5),
          reason: 'Cloud and Vendor Considerations guided prompts should have 5 sections');
    });

    test('Should reference CJIS policy sections 5.14 and 5.14.1.1', () {
      final category = GuidanceData.getCategoryById('cloud_vendor');
      expect(category!.guidedPrompts!.policySections, contains('5.14'));
      expect(category!.guidedPrompts!.policySections, contains('5.14.1.1'));
    });
  });

  group('Training and Personnel Security Guided Prompts Tests', () {
    test('Section titles should match expected topics', () {
      final category = GuidanceData.getCategoryById('training');
      final sectionTitles = category!.guidedPrompts!.sections
          .map((s) => s.title)
          .toList();

      expect(sectionTitles, contains('Security training'));
      expect(sectionTitles, contains('Background checks'));
      expect(sectionTitles, contains('New staff and role changes'));
      expect(sectionTitles, contains('Tracking and records'));
      expect(sectionTitles, contains('Responding to problems'));
    });

    test('Should have 5 sections', () {
      final category = GuidanceData.getCategoryById('training');
      expect(category!.guidedPrompts!.sections.length, equals(5),
          reason: 'Training and Personnel Security guided prompts should have 5 sections');
    });

    test('Should reference CJIS policy sections 5.1, 5.5, and 5.12', () {
      final category = GuidanceData.getCategoryById('training');
      expect(category!.guidedPrompts!.policySections, contains('5.1'));
      expect(category!.guidedPrompts!.policySections, contains('5.5'));
      expect(category!.guidedPrompts!.policySections, contains('5.12'));
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
