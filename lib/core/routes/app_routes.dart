import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/splash_screen.dart';
import '../../screens/onboarding_screen.dart';
import '../../screens/welcome_screen.dart';
import '../../screens/notifications_screen.dart';
import '../../screens/choose_profile_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/recover_password_screen.dart';
import '../../screens/register_client_screen.dart';
import '../../screens/register_professional_screen.dart';
import '../../screens/client/client_home_screen.dart';
import '../../screens/client/search_results_screen.dart';
import '../../screens/client/professional_profile_screen.dart';
import '../../screens/client/request_service_screen.dart';
import '../../screens/client/my_requests_screen.dart';
import '../../screens/client/client_settings_screen.dart';

import '../../screens/professional/pro_home_screen.dart';
import '../../screens/professional/pro_requests_screen.dart';
import '../../screens/professional/request_detail_screen.dart';
import '../../screens/professional/pro_settings_screen.dart';

import '../../screens/error_screen.dart';
import '../../screens/chat_screen.dart';
import '../../screens/client/review_professional_screen.dart';
import '../../screens/professional/pro_services_screen.dart';
import '../../screens/professional/pro_reviews_screen.dart';
import '../../screens/professional/pro_public_profile_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/choose_profile',
        builder: (context, state) => const ChooseProfileScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/recover_password',
        builder: (context, state) => const RecoverPasswordScreen(),
      ),
      GoRoute(
        path: '/register_client',
        builder: (context, state) => const RegisterClientScreen(),
      ),
      GoRoute(
        path: '/register_professional',
        builder: (context, state) => const RegisterProfessionalScreen(),
      ),
      GoRoute(
        path: '/client_home',
        builder: (context, state) => const ClientHomeScreen(),
      ),
      GoRoute(
        path: '/search_results',
        builder: (context, state) => const SearchResultsScreen(),
      ),
      GoRoute(
        path: '/professional_profile',
        builder: (context, state) {
          final uid = state.extra as String?;
          return ProfessionalProfileScreen(uid: uid ?? '');
        },
      ),
      GoRoute(
        path: '/request_service',
        builder: (context, state) {
          final professionalId = state.extra as String?;
          return RequestServiceScreen(professionalId: professionalId ?? '');
        },
      ),
      GoRoute(
        path: '/my_requests',
        builder: (context, state) => const MyRequestsScreen(),
      ),
      GoRoute(
        path: '/client_settings',
        builder: (context, state) => const ClientSettingsScreen(),
      ),
      GoRoute(
        path: '/pro_home',
        builder: (context, state) => const ProHomeScreen(),
      ),
      GoRoute(
        path: '/pro_requests',
        builder: (context, state) => const ProRequestsScreen(),
      ),
      GoRoute(
        path: '/pro_settings',
        builder: (context, state) => const ProSettingsScreen(),
      ),
      GoRoute(
        path: '/request_detail',
        builder: (context, state) {
          final requestId = state.extra as String?;
          return RequestDetailScreen(requestId: requestId ?? '');
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) => ErrorScreen(error: state.error),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) {
          final requestId = state.extra as String?;
          return ChatScreen(requestId: requestId ?? '');
        },
      ),
      GoRoute(
        path: '/review_professional',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final professionalId = extra['professionalId'] as String? ?? '';
          final requestId = extra['requestId'] as String? ?? '';
          return ReviewProfessionalScreen(
            professionalId: professionalId,
            requestId: requestId,
          );
        },
      ),
      GoRoute(
        path: '/pro_services',
        builder: (context, state) => const ProServicesScreen(),
      ),
      GoRoute(
        path: '/pro_reviews',
        builder: (context, state) => const ProReviewsScreen(),
      ),
      GoRoute(
        path: '/pro_public_profile',
        builder: (context, state) {
          final uid = state.extra as String?;
          return ProPublicProfileScreen(uid: uid ?? '');
        },
      ),
    ],
  );
}
