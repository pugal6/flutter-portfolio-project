// message_bubble.dart

import 'package:flutter/material.dart';

import '../../data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  final bool isCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 6,
      ),
      child: Align(
        alignment: isCurrentUser
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(
            maxWidth: 320,
          ),
          child: Container(
            padding:
                const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? theme
                      .colorScheme.primary
                  : Colors.white,
              borderRadius:
                  BorderRadius.only(
                topLeft:
                    const Radius.circular(
                  22,
                ),
                topRight:
                    const Radius.circular(
                  22,
                ),
                bottomLeft:
                    Radius.circular(
                  isCurrentUser
                      ? 22
                      : 6,
                ),
                bottomRight:
                    Radius.circular(
                  isCurrentUser
                      ? 6
                      : 22,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.04),
                  blurRadius: 18,
                  offset:
                      const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration:
                      BoxDecoration(
                    color: isCurrentUser
                        ? Colors.white
                            .withOpacity(
                            0.15,
                          )
                        : theme
                            .colorScheme
                            .primary
                            .withOpacity(
                            0.1,
                          ),
                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: Text(
                    message.senderRole
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w700,
                      color: isCurrentUser
                          ? Colors.white
                          : theme
                              .colorScheme
                              .primary,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  message.message,
                  style: TextStyle(
                    color: isCurrentUser
                        ? Colors.white
                        : Colors.black87,
                    height: 1.5,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}