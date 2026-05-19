// professional_dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_project/features/auth/data/repository/auth_repository.dart';

class ProfessionalDashboardScreen
    extends StatelessWidget {
  const ProfessionalDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository =
        AuthRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Professional Dashboard',
        ),

        actions: [
          IconButton(
            onPressed: () async {
              await authRepository.logout();

              if (context.mounted) {
                context.go('/login');
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

     body: Column(
  mainAxisAlignment:
      MainAxisAlignment.center,

  children: [
    Center(
      child: ElevatedButton(
        onPressed: () {
          context.push('/open-jobs');
        },
        child: const Text(
          'View Open Jobs',
        ),
      ),
    ),

    const SizedBox(height: 20),

    Center(
      child: ElevatedButton(
        onPressed: () {
          context.push('/active-jobs');
        },
        child: const Text(
          'View Active Jobs',
        ),
      ),
    ),
  ],
),
    );
  }
}