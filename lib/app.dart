import 'package:flutter/material.dart';
import 'screens/disclaimer_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/category_detail_screen.dart';
import 'screens/guidance_flow_screen.dart';

class CJISComplianceApp extends StatelessWidget {
  const CJISComplianceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CJIS Compliance Guidance Tool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DisclaimerScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/category-detail': (context) => const CategoryDetailScreen(),
        '/guidance-flow': (context) => const GuidanceFlowScreen(),
      },
    );
  }
}
