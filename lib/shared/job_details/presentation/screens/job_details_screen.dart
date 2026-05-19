import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/enums/job_status.dart';
import '../../../../../shared/models/job_model.dart';
import '../../../../../shared/repositories/job_repository.dart';

class JobDetailsScreen extends StatelessWidget {
  final String jobId;


final bool isProfessional;

const JobDetailsScreen({
  super.key,
  required this.jobId,
  required this.isProfessional,
});

  @override
  Widget build(BuildContext context) {
    final JobRepository jobRepository =
        JobRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Details',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
            '/chat/$jobId',
            extra: {'role': isProfessional ? 'professional' : 'homeowner'},
          );
        },
        child: const Icon(Icons.chat),
      ),

      body: StreamBuilder<JobModel>(
        stream:
            jobRepository.getJobById(
          jobId,
        ),

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

          final job = snapshot.data;

          if (job == null) {
            return const Center(
              child: Text(
                'Job not found',
              ),
            );
          }

          return Padding(
            padding:
                const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                Text(
                  job.category,
                  style:
                      const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  job.description,
                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  'Status: ${job.status.name}',
                ),

                const SizedBox(
                  height: 30,
                ),

               if (
    isProfessional &&
    job.status ==
        JobStatus.accepted)
                  Column(
                    children: [
                      SizedBox(
                        width:
                            double.infinity,
                        child:
                            ElevatedButton(
                          onPressed:
                              () async {
                            await jobRepository
                                .updateJobStatus(
                              jobId:
                                  job.id,
                              status:
                                  JobStatus
                                      .inProgress,
                            );
                          },
                          child:
                              const Text(
                            'Start Job',
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      SizedBox(
                        width:
                            double.infinity,
                        child:
                            ElevatedButton(
                          onPressed:
                              () async {
                            await jobRepository
    .updateJobStatus(
  jobId: job.id,
  status: JobStatus.cancelled,
  cancelledBy: 'professional',
);
                          },
                          child:
                              const Text(
                            'Cancel Job',
                          ),
                        ),
                      ),
                    ],
                  ),

                if (
    isProfessional &&
    job.status ==
        JobStatus.inProgress)
                  SizedBox(
                    width:
                        double.infinity,
                    child:
                        ElevatedButton(
                      onPressed:
                          () async {
                        await jobRepository
                            .updateJobStatus(
                          jobId: job.id,
                          status:
                              JobStatus
                                  .completed,
                        );
                      },
                      child: const Text(
                        'Complete Job',
                      ),
                    ),
                  ),

                  if (
    !isProfessional &&
    job.status ==
        JobStatus.pending)
  SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () async {
        await jobRepository
    .updateJobStatus(
  jobId: job.id,
  status: JobStatus.cancelled,
  cancelledBy: 'homeowner',
);
      },
      child: const Text(
        'Cancel Request',
      ),
    ),
  ),

                if (job.status ==
                        JobStatus
                            .completed ||
                    job.status ==
                        JobStatus
                            .cancelled)
                 Text(
  job.cancelledBy != null
      ? 'Cancelled by ${job.cancelledBy}'
      : 'This job is completed',
),
              ],
            ),
          );
        },
      ),
    );
  }
}