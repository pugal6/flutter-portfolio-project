import 'package:flutter/material.dart';
import 'package:portfolio_project/shared/job_details/presentation/screens/job_details_screen.dart';

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
            return const Center(
              child: Text(
                'No active jobs',
              ),
            );
          }

          return ListView.builder(
            itemCount: jobs.length,

            itemBuilder: (context, index) {
              final job = jobs[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                         JobDetailsScreen(
  jobId: job.id,
  isProfessional: true,
),
                    ),
                  );
                },

                child: Card(
                  margin:
                      const EdgeInsets.all(
                    12,
                  ),

                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        Text(
                          job.category,
                          style:
                              const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          job.description,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          'Status: ${job.status.name}',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}