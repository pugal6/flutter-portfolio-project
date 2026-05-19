import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_project/features/auth/data/repository/auth_repository.dart';

import '../../../../shared/enums/user_role.dart';

class RoleSelectionScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const RoleSelectionScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository =
        AuthRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 120,
              child: ElevatedButton(
               onPressed: () async {
  try {
    await authRepository.signUp(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      role: UserRole.homeowner,
    );

    print('Signup successful');

    if (context.mounted) {
      context.go('/homeowner');
    }
  } catch (e) {
    print(e);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
},
                child: const Text(
                  'Continue as Homeowner',
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 120,
              child: ElevatedButton(
                onPressed: () async {
  try {
    await authRepository.signUp(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      role: UserRole.professional,
    );

    print('Signup successful');

    if (context.mounted) {
      context.go('/professional');
    }
  } catch (e) {
    print(e);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
},
                child: const Text(
                  'Continue as Professional',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}