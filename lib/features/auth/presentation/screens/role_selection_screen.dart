// role_selection_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_project/core/widgets/auth/role_selection_card.dart';
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

    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme
                            .colorScheme.primary
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.groups_rounded,
                        size: 42,
                        color: theme
                            .colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Choose Your Role',
                      style: theme
                          .textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight:
                                FontWeight.w700,
                          ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Select how you want to use the platform.',
                      textAlign: TextAlign.center,
                      style: theme
                          .textTheme.bodyMedium
                          ?.copyWith(
                            height: 1.5,
                          ),
                    ),

                    const SizedBox(height: 40),

                    LayoutBuilder(
                      builder:
                          (context, constraints) {
                        final isMobile =
                            constraints.maxWidth <
                                650;

                        if (isMobile) {
                          return Column(
                            children: [
                              RoleSelectionCard(
                                icon: Icons.home_rounded,
                                title: 'Homeowner',
                                subtitle: 'Create service requests, manage jobs, and connect with trusted professionals.',
                                buttonText: 'Continue as Homeowner',
                                onTap: () async {
                                  try {
                                    await authRepository.signUp(
                                      name: data['name'],
                                      email: data['email'],
                                      password: data['password'],
                                      role: UserRole.homeowner,
                                    );

                                    if (context.mounted) {
                                      context.go('/homeowner');
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 24),
                              RoleSelectionCard(
                                icon: Icons.build_rounded,
                                title: 'Professional',
                                subtitle: 'Discover available jobs, manage active work, and communicate with homeowners.',
                                buttonText: 'Continue as Professional',
                                onTap: () async {
                                  try {
                                    await authRepository.signUp(
                                      name: data['name'],
                                      email: data['email'],
                                      password: data['password'],
                                      role: UserRole.professional,
                                    );

                                    if (context.mounted) {
                                      context.go('/professional');
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              child: RoleSelectionCard(
                                icon: Icons.home_rounded,
                                title: 'Homeowner',
                                subtitle: 'Create service requests, manage jobs, and connect with trusted professionals.',
                                buttonText: 'Continue as Homeowner',
                                onTap: () async {
                                  try {
                                    await authRepository.signUp(
                                      name: data['name'],
                                      email: data['email'],
                                      password: data['password'],
                                      role: UserRole.homeowner,
                                    );

                                    if (context.mounted) {
                                      context.go('/homeowner');
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: RoleSelectionCard(
                                icon: Icons.build_rounded,
                                title: 'Professional',
                                subtitle: 'Discover available jobs, manage active work, and communicate with homeowners.',
                                buttonText: 'Continue as Professional',
                                onTap: () async {
                                  try {
                                    await authRepository.signUp(
                                      name: data['name'],
                                      email: data['email'],
                                      password: data['password'],
                                      role: UserRole.professional,
                                    );

                                    if (context.mounted) {
                                      context.go('/professional');
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}