import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/models/job_model.dart';
import '../../../../../shared/repositories/job_repository.dart';

class HomeownerJobsScreen extends StatelessWidget {
  const HomeownerJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobRepository jobRepository =
        JobRepository();

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
            return const Center(
              child: Text(
                'No requests found',
              ),
            );
          }

          return ListView.builder(
            itemCount: jobs.length,

            itemBuilder: (context, index) {
              final job = jobs[index];

              return GestureDetector(
  onTap: () {
    context.push(
      '/job-details/${job.id}',
      extra: {'isProfessional': false},
    );
  },

  child:  Card(
                margin:
                    const EdgeInsets.all(12),

                child: Padding(
                  padding:
                      const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        job.category,
                        style:
                            const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
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
              )
              );
            },
          );
        },
      ),
    );
  }
}