// message_input.dart

import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onSend;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        padding:
            const EdgeInsets.fromLTRB(
          16,
          12,
          16,
          16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(
                0.04,
              ),
              blurRadius: 20,
              offset: const Offset(
                0,
                -4,
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                decoration:
                    const InputDecoration(
                  hintText:
                      'Type a message...',
                ),
              ),
            ),

            const SizedBox(width: 12),

            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.primary,
                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),
              child: IconButton(
                onPressed: onSend,
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}