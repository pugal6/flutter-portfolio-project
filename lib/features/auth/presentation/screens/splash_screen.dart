// splash_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      checkAuth();
    });
  }

  Future<void> checkAuth() async {
    try {
      final user =
          FirebaseAuth.instance.currentUser;

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (user == null) {
        if (mounted) {
          context.go('/login');
        }

        return;
      }

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (!userDoc.exists) {
        await FirebaseAuth.instance
            .signOut();

        if (mounted) {
          context.go('/login');
        }

        return;
      }

      final role =
          userDoc.data()?['role'];

      if (!mounted) return;

      if (role == 'homeowner') {
        context.go('/homeowner');
      } else if (role ==
          'professional') {
        context.go('/professional');
      } else {
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF4F7FF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: theme
                        .colorScheme.primary
                        .withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons
                        .home_repair_service_rounded,
                    size: 58,
                    color: theme
                        .colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 28),

                Text(
                  'Home Services',
                  style: theme
                      .textTheme.headlineMedium
                      ?.copyWith(
                        fontWeight:
                            FontWeight.w700,
                      ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Connecting homeowners with trusted professionals',
                  textAlign: TextAlign.center,
                  style: theme
                      .textTheme.bodyMedium
                      ?.copyWith(
                        height: 1.5,
                      ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: 28,
                  height: 28,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2.8,
                    color:
                        theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}