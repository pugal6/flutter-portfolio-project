import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_project/shared/job_details/widgets/job_actions.dart';
import 'package:portfolio_project/shared/job_details/widgets/job_header.dart';
import 'package:portfolio_project/shared/job_details/widgets/participant_info.dart';
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
    final jobRepository = JobRepository();

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(
            '/chat/$jobId',
            extra: {'role': isProfessional ? 'professional' : 'homeowner'},
          );
        },
        icon: const Icon(Icons.chat),
        label: const Text('Chat'),
      ),

      body: StreamBuilder<JobModel>(
        stream: jobRepository.getJobById(jobId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final job = snapshot.data;

          if (job == null) {
            return const Center(child: Text('Job not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    JobHeader(job: job),

                    const SizedBox(height: 28),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 18),

                          Text(
                            job.description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.8,
                            ),
                          ),

                          const SizedBox(height: 36),

                          const Divider(),

                          const SizedBox(height: 24),

                          ParticipantInfo(
                            title: 'Requested By',
                            value: job.homeownerName,
                          ),

                          ParticipantInfo(
                            title: 'Assigned Professional',
                            value: job.professionalName ?? 'Not assigned yet',
                          ),

                          const SizedBox(height: 12),

                          JobActions(
                            job: job,
                            isProfessional: isProfessional,
                            repository: jobRepository,
                          ),

                          if (job.status.name == 'completed' ||
                              job.status.name == 'cancelled') ...[
                            const SizedBox(height: 28),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: job.status.name == 'completed'
                                    ? Colors.green.withOpacity(0.08)
                                    : Colors.red.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                job.cancelledBy != null
                                    ? 'Cancelled by ${job.cancelledBy}'
                                    : 'This job has been completed successfully.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: job.status.name == 'completed'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
