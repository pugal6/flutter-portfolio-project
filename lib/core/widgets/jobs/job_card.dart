// core/widgets/jobs/job_card.dart

import 'package:flutter/material.dart';
import 'package:portfolio_project/shared/models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;

  final VoidCallback onTap;

  final Widget? action;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    this.action,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.orange;

      case 'accepted':
        return Colors.blue;

      case 'inprogress':
        return Colors.green;

      case 'completed':
        return Colors.teal;

      case 'cancelled':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final statusColor = _statusColor(
      job.status.name,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(
                0.05,
              ),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(
                    14,
                  ),
                  decoration: BoxDecoration(
                    color: theme
                        .colorScheme.primary
                        .withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Icon(
                    Icons
                        .home_repair_service_rounded,
                    color: theme
                        .colorScheme.primary,
                  ),
                ),

                const Spacer(),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor
                        .withOpacity(0.12),
                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: Text(
                    job.status.name
                        .toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight:
                          FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              job.category,
              style: theme
                  .textTheme.titleLarge
                  ?.copyWith(
                    fontWeight:
                        FontWeight.w700,
                  ),
            ),

            const SizedBox(height: 14),

            Text(
              job.description,
              style: theme
                  .textTheme.bodyMedium
                  ?.copyWith(
                    height: 1.6,
                  ),
            ),

            if (action != null) ...[
              const SizedBox(height: 28),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}