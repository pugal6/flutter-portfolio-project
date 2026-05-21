// professional_dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_project/core/widgets/dashboard/dashboard_card.dart';
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

    final theme = Theme.of(context);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient:
                        LinearGradient(
                      colors: [
                        theme
                            .colorScheme.primary,
                        theme.colorScheme.primary
                            .withOpacity(0.8),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      32,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets
                                .all(14),
                        decoration:
                            BoxDecoration(
                          color: Colors.white
                              .withOpacity(
                            0.15,
                          ),
                          borderRadius:
                              BorderRadius
                                  .circular(
                            18,
                          ),
                        ),
                        child: const Icon(
                          Icons.build_rounded,
                          color:
                              Colors.white,
                          size: 32,
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      const Text(
                        'Manage Your Work Efficiently',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight
                                  .w700,
                          color:
                              Colors.white,
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Text(
                        'Track active jobs, discover new opportunities, and stay connected with homeowners.',
                        style: TextStyle(
                          color: Colors.white
                              .withOpacity(
                            0.9,
                          ),
                          height: 1.6,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Quick Actions',
                  style: theme
                      .textTheme.titleLarge
                      ?.copyWith(
                        fontWeight:
                            FontWeight.w700,
                      ),
                ),

                const SizedBox(height: 20),

                LayoutBuilder(
                  builder:
                      (context, constraints) {
                    final isMobile =
                        constraints.maxWidth <
                            700;

                    if (isMobile) {
                      return Column(
                        children: [
                          DashboardActionCard(
                            icon: Icons.work_outline_rounded,
                            title: 'Open Jobs',
                            subtitle: 'Browse available service requests posted by homeowners.',
                            buttonText: 'View Open Jobs',
                            onTap: () {
                              context.push('/open-jobs');
                            },
                          ),
                          const SizedBox(height: 24),
                          DashboardActionCard(
                            icon: Icons.engineering_rounded,
                            title: 'Active Jobs',
                            subtitle: 'Manage accepted jobs and monitor current work progress.',
                            buttonText: 'View Active Jobs',
                            onTap: () {
                              context.push('/active-jobs');
                            },
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: DashboardActionCard(
                            icon: Icons.work_outline_rounded,
                            title: 'Open Jobs',
                            subtitle: 'Browse available service requests posted by homeowners.',
                            buttonText: 'View Open Jobs',
                            onTap: () {
                              context.push('/open-jobs');
                            },
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: DashboardActionCard(
                            icon: Icons.engineering_rounded,
                            title: 'Active Jobs',
                            subtitle: 'Manage accepted jobs and monitor current work progress.',
                            buttonText: 'View Active Jobs',
                            onTap: () {
                              context.push('/active-jobs');
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
    );
  }
}