import 'package:flutter/material.dart';

import '../../../../../shared/models/job_model.dart';
import '../../../../../shared/repositories/job_repository.dart';

class ProfessionalJobFeedScreen
    extends StatelessWidget {
  const ProfessionalJobFeedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final JobRepository jobRepository =
        JobRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Open Jobs',
        ),
      ),

      body: StreamBuilder<List<JobModel>>(
        stream:
            jobRepository.getOpenJobs(),

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
                'No open jobs',
              ),
            );
          }

          return ListView.builder(
            itemCount: jobs.length,

            itemBuilder: (context, index) {
              final job = jobs[index];

              return Card(
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

                      const SizedBox(height: 16),

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () async {
      await jobRepository.acceptJob(
        jobId: job.id,
      );
    },
    child: const Text(
      'Accept Job',
    ),
  ),
),
                    ],
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