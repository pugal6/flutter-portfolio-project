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

      body: const Center(
        child: Text('Professional Dashboard'),
      ),
    );
  }
}