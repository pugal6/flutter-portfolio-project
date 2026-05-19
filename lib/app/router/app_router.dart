// app_router.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/role_selection_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';

import '../../features/homeowner/dashboard/presentation/screens/homeowner_dashboard_screen.dart';

import '../../features/professional/dashboard/presentation/screens/professional_dashboard_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  redirect: (context, state) async {
    final user = FirebaseAuth.instance.currentUser;

    final currentPath = state.matchedLocation;

    final isAuthRoute =
        currentPath == '/login' ||
        currentPath == '/signup' ||
        currentPath == '/role-selection';

    // User NOT logged in
    if (user == null) {
      if (isAuthRoute) {
        return null;
      }

      return '/login';
    }

    // User logged in
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final role = userDoc.data()?['role'];

    // Prevent logged-in users from opening auth screens
    if (isAuthRoute || currentPath == '/') {
      if (role == 'homeowner') {
        return '/homeowner';
      }

      return '/professional';
    }

    // Homeowner protection
    if (role == 'homeowner' &&
        currentPath.startsWith('/professional')) {
      return '/homeowner';
    }

    // Professional protection
    if (role == 'professional' &&
        currentPath.startsWith('/homeowner')) {
      return '/professional';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),

    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return const SignupScreen();
      },
    ),

    GoRoute(
      path: '/role-selection',
      builder: (context, state) {
        final data =
            state.extra as Map<String, dynamic>?;

        return RoleSelectionScreen(
          data: data ?? {},
        );
      },
    ),

    GoRoute(
      path: '/homeowner',
      builder: (context, state) {
        return const HomeownerDashboardScreen();
      },
    ),

    GoRoute(
      path: '/professional',
      builder: (context, state) {
        return const ProfessionalDashboardScreen();
      },
    ),
  ],
);