// core/widgets/auth/role_selection_card.dart

import 'package:flutter/material.dart';

class RoleSelectionCard extends StatelessWidget {
  final IconData icon;

  final String title;

  final String subtitle;

  final String buttonText;

  final VoidCallback onTap;

  const RoleSelectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(28),
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
          Container(
            padding:
                const EdgeInsets.all(16),
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
              icon,
              size: 34,
              color:
                  theme.colorScheme.primary,
            ),
          ),

          const SizedBox(height: 28),

          Text(
            title,
            style: theme
                .textTheme.titleLarge
                ?.copyWith(
                  fontWeight:
                      FontWeight.w700,
                ),
          ),

          const SizedBox(height: 14),

          Text(
            subtitle,
            style: theme
                .textTheme.bodyMedium
                ?.copyWith(
                  height: 1.6,
                ),
          ),

          const SizedBox(height: 32),

          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onTap,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}