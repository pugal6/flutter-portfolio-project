import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_project/features/auth/data/repository/auth_repository.dart';

class HomeownerDashboardScreen
    extends StatelessWidget {
  const HomeownerDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository =
        AuthRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homeowner Dashboard',
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

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/create-request');
          },
          child: const Text(
            'Create Service Request',
          ),
        ),
      ),
    );
  }
}