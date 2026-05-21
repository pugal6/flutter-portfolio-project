// professional_active_jobs_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/jobs/job_card.dart';
import '../../../../../shared/models/job_model.dart';
import '../../../../../shared/repositories/job_repository.dart';

class ProfessionalActiveJobsScreen
    extends StatelessWidget {
  const ProfessionalActiveJobsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final JobRepository jobRepository =
        JobRepository();

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Active Jobs',
        ),
      ),
      body: StreamBuilder<List<JobModel>>(
        stream: jobRepository
            .getProfessionalActiveJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final jobs = snapshot.data ?? [];

          if (jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [
                  Icon(
                    Icons.engineering_rounded,
                    size: 72,
                    color: Colors.grey
                        .withOpacity(0.45),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    'No Active Jobs',
                    style: theme
                        .textTheme.titleLarge
                        ?.copyWith(
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    'Accepted jobs will appear here.',
                    style: theme
                        .textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 900,
              ),
              child: ListView.builder(
                padding:
                    const EdgeInsets.all(
                  24,
                ),
                itemCount: jobs.length,
                itemBuilder:
                    (context, index) {
                  final job = jobs[index];

                  return JobCard(
                    job: job,
                    onTap: () {
                      context.push(
                        '/job-details/${job.id}',
                        extra: {
                          'isProfessional':
                              true,
                        },
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}