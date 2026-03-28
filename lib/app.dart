import 'package:flutter/material.dart';
import 'screens/disclaimer_screen.dart';
import 'screens/domain_selection_screen.dart';
import 'screens/question_flow_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/category_detail_screen.dart';
import 'screens/guidance_flow_screen.dart';

class CJISComplianceApp extends StatelessWidget {
  const CJISComplianceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CJIS Guidance',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        // Primary flow: Disclaimer → Domain → Question
        '/': (context) => const DisclaimerScreen(),
        '/domains': (context) => const DomainSelectionScreen(),
        '/question-flow': (context) => const QuestionFlowScreen(),
        // Secondary reference section (not part of main flow)
        '/categories': (context) => const CategoriesScreen(),
        '/category-detail': (context) => const CategoryDetailScreen(),
        '/guidance-flow': (context) => const GuidanceFlowScreen(),
      },
    );
  }
}
