import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cjis_comp/screens/categories_screen.dart';
import 'package:cjis_comp/data/guidance_data.dart';

void main() {
  group('Categories Screen Tests', () {
    testWidgets('Should display screen title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CategoriesScreen(),
        ),
      );

      expect(find.text('CJIS Guidance Categories'), findsOneWidget);
    });

    testWidgets('Should display all categories', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CategoriesScreen(),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Check that all category titles are displayed
      for (final category in GuidanceData.categories) {
        expect(find.text(category.title), findsOneWidget);
      }
    });

    testWidgets('Should display category descriptions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CategoriesScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Check at least one description is visible
      expect(
        find.textContaining(
            'Guidelines for managing and controlling access'),
        findsOneWidget,
      );
    });

    testWidgets('Should display info section', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CategoriesScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Select a Category'), findsOneWidget);
    });

    testWidgets('Categories should be tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const CategoriesScreen(),
          routes: {
            '/category-detail': (context) => const Scaffold(
                  body: Center(child: Text('Category Detail')),
                ),
          },
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap the first category
      final firstCategoryFinder = find.text('Access Control');
      expect(firstCategoryFinder, findsOneWidget);

      await tester.tap(firstCategoryFinder);
      await tester.pumpAndSettle();

      // Should navigate to detail screen
      expect(find.text('Category Detail'), findsOneWidget);
    });
  });
}
