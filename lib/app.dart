import 'package:flutter/material.dart';
import 'screens/role_selection_screen.dart';
import 'screens/domain_selection_screen.dart';
import 'screens/question_flow_screen.dart';

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
        '/': (context) => const RoleSelectionScreen(),
        '/domains': (context) => const DomainSelectionScreen(),
        '/question-flow': (context) => const QuestionFlowScreen(),
      },
    );
  }
}
