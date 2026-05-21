import 'package:flutter/material.dart';
import 'package:portfolio_project/shared/enums/job_status.dart';
import 'package:portfolio_project/shared/models/job_model.dart';
import 'package:portfolio_project/shared/repositories/job_repository.dart';

class JobActions extends StatelessWidget {
  final JobModel job;
  final bool isProfessional;
  final JobRepository repository;

  const JobActions({
    super.key,
    required this.job,
    required this.isProfessional,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    if (isProfessional &&
        job.status ==
            JobStatus.pending) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () async {
                await repository
                    .updateJobStatus(
                  jobId: job.id,
                  status:
                      JobStatus.accepted,
                );
              },
              child:
                  const Text('Accept Job'),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton(
              onPressed: () async {
                await repository
                    .updateJobStatus(
                  jobId: job.id,
                  status:
                      JobStatus.cancelled,
                  cancelledBy:
                      'professional',
                );
              },
              child:
                  const Text('Decline Job'),
            ),
          ),
        ],
      );
    }

    if (isProfessional &&
        job.status ==
            JobStatus.accepted) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () async {
                await repository
                    .updateJobStatus(
                  jobId: job.id,
                  status: JobStatus
                      .inProgress,
                );
              },
              child:
                  const Text('Start Job'),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton(
              onPressed: () async {
                await repository
                    .updateJobStatus(
                  jobId: job.id,
                  status:
                      JobStatus.cancelled,
                  cancelledBy:
                      'professional',
                );
              },
              child:
                  const Text('Cancel Job'),
            ),
          ),
        ],
      );
    }

    if (isProfessional &&
        job.status ==
            JobStatus.inProgress) {
      return SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () async {
            await repository
                .updateJobStatus(
              jobId: job.id,
              status:
                  JobStatus.completed,
            );
          },
          child:
              const Text('Complete Job'),
        ),
      );
    }

    if (!isProfessional &&
        job.status ==
            JobStatus.pending) {
      return SizedBox(
        width: double.infinity,
        height: 54,
        child: OutlinedButton(
          onPressed: () async {
            await repository
                .updateJobStatus(
              jobId: job.id,
              status:
                  JobStatus.cancelled,
              cancelledBy:
                  'homeowner',
            );
          },
          child:
              const Text('Cancel Request'),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}