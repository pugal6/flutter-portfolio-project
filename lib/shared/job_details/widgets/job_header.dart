import 'package:flutter/material.dart';
import 'package:portfolio_project/shared/enums/job_status.dart';
import 'package:portfolio_project/shared/models/job_model.dart';

class JobHeader extends StatelessWidget {
  final JobModel job;

  const JobHeader({
    super.key,
    required this.job,
  });

  Color _statusColor(JobStatus status) {
    switch (status) {
      case JobStatus.pending:
        return Colors.orange;

      case JobStatus.accepted:
        return Colors.blue;

      case JobStatus.inProgress:
        return Colors.green;

      case JobStatus.completed:
        return Colors.teal;

      case JobStatus.cancelled:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary
                .withOpacity(0.8),
          ],
        ),
        borderRadius:
            BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.15),
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons
                      .home_repair_service_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),

              const Spacer(),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _statusColor(
                    job.status,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),
                child: Text(
                  job.status.name
                      .toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Text(
            job.category,
            style: const TextStyle(
              fontSize: 30,
              fontWeight:
                  FontWeight.w700,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Track progress and manage this service request.',
            style: TextStyle(
              color: Colors.white
                  .withOpacity(0.9),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}