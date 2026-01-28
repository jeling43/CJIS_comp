import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/screens/disclaimer_screen.dart';

void main() {
  group('Disclaimer Screen Tests', () {
    testWidgets('Should display disclaimer title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DisclaimerScreen(),
        ),
      );

      expect(find.text('CJIS Compliance\nGuidance Tool'), findsOneWidget);
    });

    testWidgets('Should display important disclaimer section',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DisclaimerScreen(),
        ),
      );

      expect(find.text('Important Disclaimer'), findsOneWidget);
    });

    testWidgets('Should display intended audience section',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DisclaimerScreen(),
        ),
      );

      expect(find.text('Intended Audience'), findsOneWidget);
    });

    testWidgets('Should display purpose section', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DisclaimerScreen(),
        ),
      );

      expect(find.text('Purpose'), findsOneWidget);
    });

    testWidgets('Should display limitations section',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DisclaimerScreen(),
        ),
      );

      expect(find.text('Limitations'), findsOneWidget);
    });

    testWidgets('Should have continue button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DisclaimerScreen(),
        ),
      );

      expect(find.text('I Understand - Continue'), findsOneWidget);
      expect(
          find.widgetWithText(ElevatedButton, 'I Understand - Continue'),
          findsOneWidget);
    });

    testWidgets('Should display security icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DisclaimerScreen(),
        ),
      );

      expect(find.byIcon(Icons.security), findsOneWidget);
    });

    testWidgets('Should display warning icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DisclaimerScreen(),
        ),
      );

      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
    });
  });
}
