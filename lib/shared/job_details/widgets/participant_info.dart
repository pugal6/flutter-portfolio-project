import 'package:flutter/material.dart';

class ParticipantInfo extends StatelessWidget {
  final String title;
  final String value;

  const ParticipantInfo({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge
                ?.copyWith(
              color: Colors.grey.shade600,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: theme.textTheme.titleMedium
                ?.copyWith(
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}