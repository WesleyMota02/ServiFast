import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const ServiFastApp());
}

class ServiFastApp extends StatelessWidget {
  const ServiFastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServiFast',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
