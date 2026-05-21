// homeowner_jobs_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/jobs/job_card.dart';
import '../../../../../shared/models/job_model.dart';
import '../../../../../shared/repositories/job_repository.dart';

class HomeownerJobsScreen
    extends StatelessWidget {
  const HomeownerJobsScreen({
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
          'My Requests',
        ),
      ),
      body: StreamBuilder<List<JobModel>>(
        stream:
            jobRepository.getHomeownerJobs(),
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
                    Icons.assignment_outlined,
                    size: 72,
                    color: Colors.grey
                        .withOpacity(0.45),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    'No Requests Found',
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
                    'Your submitted service requests will appear here.',
                    style: theme
                        .textTheme.bodyMedium,
                    textAlign:
                        TextAlign.center,
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
                              false,
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