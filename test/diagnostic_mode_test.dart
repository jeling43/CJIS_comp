import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/models/question_models.dart';
import 'package:cjis_comp/data/question_data.dart';

void main() {
  group('Diagnostic Pattern Detection', () {
    test('Uncertainty: "Not sure" answers should have diagnostic flag', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final question in flow.questions.values) {
          for (final answer in question.answers) {
            if (answer.text == 'Not sure') {
              // "Not sure" answers should carry a diagnostic flag
              expect(
                answer.diagnosticFlag != null || answer.guidance != null,
                isTrue,
                reason:
                    '"Not sure" answer in question "${question.id}" should '
                    'have a diagnostic flag or guidance',
              );
            }
          }
        }
      }
    });

    test('Uncertainty flags use the correct label', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final question in flow.questions.values) {
          for (final answer in question.answers) {
            if (answer.text == 'Not sure' &&
                answer.diagnosticFlag != null) {
              expect(
                answer.diagnosticFlag,
                equals('Lack of visibility in this area'),
                reason:
                    '"Not sure" in "${question.id}" should flag uncertainty',
              );
            }
          }
        }
      }
    });

    test('Ownership gap flags exist on responsibility questions', () {
      // Access control branch b1 — "No one specific" / "Not sure"
      final acB1 =
          QuestionData.accessControlFlow.questions['ac_b1']!;
      final noOneSpecific =
          acB1.answers.firstWhere((a) => a.text == 'No one specific');
      expect(noOneSpecific.diagnosticFlag, 'Responsibility is unclear');

      final notSure =
          acB1.answers.firstWhere((a) => a.text == 'Not sure');
      expect(notSure.diagnosticFlag, 'Responsibility is unclear');

      // MFA branch b2 — "They aren't" / "Not sure"
      final mfaB2 =
          QuestionData.authMfaFlow.questions['mfa_b2']!;
      final theyArent =
          mfaB2.answers.firstWhere((a) => a.text == "They aren't");
      expect(theyArent.diagnosticFlag, 'Responsibility is unclear');
    });

    test('Control breakdown flags exist on contradiction answers', () {
      // ac_q6 "Yes" — informal grants bypass formal process
      final acQ6 =
          QuestionData.accessControlFlow.questions['ac_q6']!;
      final yesAnswer = acQ6.answers.firstWhere((a) => a.text == 'Yes');
      expect(
        yesAnswer.diagnosticFlag,
        'Control may not be consistently enforced',
      );

      // mfa_q3 "Yes" — passwords shared despite policy
      final mfaQ3 =
          QuestionData.authMfaFlow.questions['mfa_q3']!;
      final yesMfa = mfaQ3.answers.firstWhere((a) => a.text == 'Yes');
      expect(
        yesMfa.diagnosticFlag,
        'Control may not be consistently enforced',
      );
    });
  });

  group('CJIS References', () {
    test('All guidance items include a CJIS reference', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final question in flow.questions.values) {
          for (final answer in question.answers) {
            if (answer.guidance != null) {
              expect(
                answer.guidance!.cjisReference,
                isNotNull,
                reason:
                    'Guidance on "${answer.text}" in "${question.id}" '
                    'should include a CJIS reference',
              );
            }
          }
        }
      }
    });

    test('CJIS references use section number format only', () {
      final refPattern = RegExp(r'^CJIS \d+\.\d+');
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final question in flow.questions.values) {
          for (final answer in question.answers) {
            if (answer.guidance?.cjisReference != null) {
              expect(
                refPattern.hasMatch(answer.guidance!.cjisReference!),
                isTrue,
                reason:
                    'CJIS reference "${answer.guidance!.cjisReference}" '
                    'should match format "CJIS X.Y..."',
              );
            }
          }
        }
      }
    });

    test('CJIS references do not contain policy text', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final question in flow.questions.values) {
          for (final answer in question.answers) {
            if (answer.guidance?.cjisReference != null) {
              final ref = answer.guidance!.cjisReference!;
              // Should be short — just "CJIS X.Y.Z"
              expect(ref.length, lessThan(20),
                  reason: 'CJIS reference "$ref" should be section number only');
              expect(ref.contains(' - '), isFalse,
                  reason: 'CJIS reference should not contain policy text');
            }
          }
        }
      }
    });

    test('Default guidance includes CJIS reference', () {
      expect(
        QuestionData.accessControlFlow.defaultGuidance.cjisReference,
        isNotNull,
      );
      expect(
        QuestionData.authMfaFlow.defaultGuidance.cjisReference,
        isNotNull,
      );
    });
  });

  group('Combined Insights', () {
    test('Access control flow has combined insights defined', () {
      expect(
        QuestionData.accessControlFlow.combinedInsights,
        isNotEmpty,
      );
    });

    test('Auth MFA flow has combined insights defined', () {
      expect(
        QuestionData.authMfaFlow.combinedInsights,
        isNotEmpty,
      );
    });

    test('Combined insight trigger IDs reference valid questions', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final ci in flow.combinedInsights) {
          for (final qid in ci.triggerQuestionIds) {
            expect(
              flow.questions.containsKey(qid),
              isTrue,
              reason:
                  'Combined insight trigger "$qid" should reference a valid '
                  'question in domain "${flow.domainId}"',
            );
          }
        }
      }
    });

    test('Combined insights require at least 2 trigger questions', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final ci in flow.combinedInsights) {
          expect(
            ci.triggerQuestionIds.length,
            greaterThanOrEqualTo(2),
            reason:
                'Combined insight "${ci.insight}" should require 2+ triggers',
          );
        }
      }
    });

    test('Combined insights match when all trigger questions flagged', () {
      // Simulate flagging ac_q1 and ac_q2
      final flow = QuestionData.accessControlFlow;
      final flaggedIds = {'ac_q1', 'ac_q2'};

      final matched = flow.combinedInsights
          .where((ci) =>
              ci.triggerQuestionIds.every(flaggedIds.contains))
          .toList();

      expect(matched, isNotEmpty,
          reason: 'Should match a combined insight for ac_q1 + ac_q2');
    });

    test('Combined insights do not match with partial triggers', () {
      final flow = QuestionData.accessControlFlow;
      // Only one question flagged
      final flaggedIds = {'ac_q1'};

      final matched = flow.combinedInsights
          .where((ci) =>
              ci.triggerQuestionIds.every(flaggedIds.contains))
          .toList();

      expect(matched, isEmpty,
          reason:
              'Should not match combined insight with only 1 trigger');
    });
  });

  group('Output Structure', () {
    test('GuidanceItem has all required fields', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final question in flow.questions.values) {
          for (final answer in question.answers) {
            if (answer.guidance != null) {
              final g = answer.guidance!;
              expect(g.meaning, isNotEmpty,
                  reason: 'meaning (What this means) must be non-empty');
              expect(g.risk, isNotEmpty,
                  reason: 'risk (Why it matters) must be non-empty');
              expect(g.whereToLook, isNotEmpty,
                  reason: 'whereToLook (Where to look) must be non-empty');
              expect(g.whatToCheck, isNotEmpty,
                  reason: 'whatToCheck (What to check) must be non-empty');
              expect(g.firstStep, isNotEmpty,
                  reason: 'firstStep (First step) must be non-empty');
            }
          }
        }
      }
    });

    test('DiagnosticEntry model captures question ID, guidance and flag', () {
      const entry = DiagnosticEntry(
        questionId: 'test_q1',
        guidance: GuidanceItem(
          meaning: 'Test meaning',
          risk: 'Test risk',
          whereToLook: 'Test where to look',
          whatToCheck: 'Test what to check',
          firstStep: 'Test first step',
          cjisReference: 'CJIS 5.5.2',
        ),
        diagnosticFlag: 'Lack of visibility in this area',
      );

      expect(entry.questionId, 'test_q1');
      expect(entry.guidance.meaning, 'Test meaning');
      expect(entry.guidance.cjisReference, 'CJIS 5.5.2');
      expect(entry.diagnosticFlag, 'Lack of visibility in this area');
    });
  });

  group('Depth Strategy', () {
    test('Follow-up questions are limited to 1-2 per topic', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        // Count how many follow-ups each primary question can trigger
        for (final primaryId in flow.primaryQuestionIds) {
          final question = flow.questions[primaryId]!;
          var followUpCount = 0;

          for (final answer in question.answers) {
            if (answer.followUpQuestionId != null) {
              followUpCount++;
              // Check that the follow-up itself doesn't chain further
              final followUp =
                  flow.questions[answer.followUpQuestionId!];
              if (followUp != null) {
                final deepFollowUps = followUp.answers
                    .where((a) => a.followUpQuestionId != null)
                    .length;
                // At most 1 more level of follow-up (total depth = 2)
                expect(deepFollowUps, lessThanOrEqualTo(1),
                    reason:
                        'Follow-up "${followUp.id}" should not chain more '
                        'than 1 additional level');
              }
            }
          }
        }
      }
    });
  });

  group('Language Requirements', () {
    test('Guidance text is direct and practical', () {
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final question in flow.questions.values) {
          for (final answer in question.answers) {
            if (answer.guidance != null) {
              final g = answer.guidance!;
              // Each field should be 1–2 sentences (splitting on '.' gives
              // sentence count + 1 for trailing empty element)
              expect(g.meaning.split('.').length, lessThanOrEqualTo(4),
                  reason: 'meaning should be 1–2 sentences');
              expect(g.risk.split('.').length, lessThanOrEqualTo(4),
                  reason: 'risk should be 1–2 sentences');
              expect(g.firstStep.split('.').length, lessThanOrEqualTo(4),
                  reason: 'firstStep should be 1–2 sentences');
            }
          }
        }
      }
    });

    test('Output does not include compliance scores or pass/fail', () {
      final forbidden = ['compliance score', 'pass/fail', 'score:', 'grade:'];
      for (final flow in [
        QuestionData.accessControlFlow,
        QuestionData.authMfaFlow,
      ]) {
        for (final question in flow.questions.values) {
          for (final answer in question.answers) {
            if (answer.guidance != null) {
              final g = answer.guidance!;
              final allText =
                  '${g.meaning} ${g.risk} ${g.firstStep}'.toLowerCase();
              for (final term in forbidden) {
                expect(allText.contains(term), isFalse,
                    reason:
                        'Guidance should not contain "$term"');
              }
            }
          }
        }
      }
    });
  });
}
