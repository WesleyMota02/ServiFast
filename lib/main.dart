import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/choose_profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/recover_password_screen.dart';
import 'screens/register_client_screen.dart';
import 'screens/register_professional_screen.dart';

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
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/choose_profile': (context) => const ChooseProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/recover_password': (context) => const RecoverPasswordScreen(),
        '/register_client': (context) => const RegisterClientScreen(),
        '/register_professional': (context) => const RegisterProfessionalScreen(),
      },
    );
  }
}

