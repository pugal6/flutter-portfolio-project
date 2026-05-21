// homeowner_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_project/core/widgets/dashboard/dashboard_card.dart';
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

    final theme = Theme.of(context);

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
                          Icons.home_rounded,
                          color:
                              Colors.white,
                          size: 32,
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      const Text(
                        'Manage Your Service Requests',
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
                        'Create repair requests, track progress, and stay connected with professionals.',
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
                            icon: Icons.add_home_work_rounded,
                            title: 'Create Request',
                            subtitle: 'Submit a new repair or maintenance request for professionals to review.',
                            buttonText: 'Create Service Request',
                            onTap: () {
                              context.push('/create-request');
                            },
                          ),
                          const SizedBox(height: 24),
                          DashboardActionCard(
                            icon: Icons.assignment_rounded,
                            title: 'My Requests',
                            subtitle: 'Track submitted jobs and monitor their latest progress updates.',
                            buttonText: 'View My Requests',
                            onTap: () {
                              context.push('/my-requests');
                            },
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: DashboardActionCard(
                            icon: Icons.add_home_work_rounded,
                            title: 'Create Request',
                            subtitle: 'Submit a new repair or maintenance request for professionals to review.',
                            buttonText: 'Create Service Request',
                            onTap: () {
                              context.push('/create-request');
                            },
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: DashboardActionCard(
                            icon: Icons.assignment_rounded,
                            title: 'My Requests',
                            subtitle: 'Track submitted jobs and monitor their latest progress updates.',
                            buttonText: 'View My Requests',
                            onTap: () {
                              context.push('/my-requests');
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