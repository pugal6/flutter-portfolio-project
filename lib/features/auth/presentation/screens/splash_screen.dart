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

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    checkAuth();
  });
}

  Future<void> checkAuth() async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) {
        context.go('/login');
      }

      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      await FirebaseAuth.instance.signOut();

      if (mounted) {
        context.go('/login');
      }

      return;
    }

    final role = userDoc.data()?['role'];

    if (!mounted) return;

    if (role == 'homeowner') {
      context.go('/homeowner');
    } else if (role == 'professional') {
      context.go('/professional');
    } else {
      context.go('/login');
    }
  } catch (e) {
    print(e);

    if (mounted) {
      context.go('/login');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}