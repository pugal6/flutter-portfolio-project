// chat_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat_bloc.dart';
import '../../bloc/chat_event.dart';
import '../../bloc/chat_state.dart';
import '../../data/repository/chat_repository.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class ChatScreen extends StatefulWidget {
  final String jobId;

  final String currentUserRole;

  const ChatScreen({
    super.key,
    required this.jobId,
    required this.currentUserRole,
  });

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState
    extends State<ChatScreen> {
  final TextEditingController
      _messageController =
      TextEditingController();

  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();

    _chatBloc = ChatBloc(
      repository: ChatRepository(
        firestore:
            FirebaseFirestore.instance,
      ),
    );

    _chatBloc.add(
      LoadMessages(widget.jobId),
    );
  }

  void _sendMessage() {
    if (_messageController.text
        .trim()
        .isEmpty) {
      return;
    }

    _chatBloc.add(
      SendMessage(
        jobId: widget.jobId,
        senderId: FirebaseAuth
            .instance.currentUser!.uid,
        senderRole:
            widget.currentUserRole,
        message:
            _messageController.text
                .trim(),
      ),
    );

    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();

    _chatBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        FirebaseAuth.instance.currentUser!
            .uid;

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Job Chat',
        ),
      ),

      body: BlocBuilder<
        ChatBloc,
        ChatState
      >(
        bloc: _chatBloc,
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (state is ChatError) {
            return Center(
              child: Text(
                state.message,
              ),
            );
          }

          if (state is ChatLoaded) {
            if (state.messages.isEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: [
                          Icon(
                            Icons
                                .forum_outlined,
                            size: 72,
                            color: Colors.grey
                                .withOpacity(
                              0.45,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Text(
                            'No Messages Yet',
                            style: theme
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight:
                                      FontWeight
                                          .w700,
                                ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            'Start the conversation.',
                            style: theme
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),

                  MessageInput(
                    controller:
                        _messageController,
                    onSend:
                        _sendMessage,
                  ),
                ],
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    padding:
                        const EdgeInsets.only(
                      top: 18,
                      bottom: 12,
                    ),
                    itemCount:
                        state.messages.length,
                    itemBuilder:
                        (context, index) {
                      final reversedMessages =
                          state.messages
                              .reversed
                              .toList();

                      final message =
                          reversedMessages[
                              index];

                      return MessageBubble(
                        message: message,
                        isCurrentUser:
                            message.senderId ==
                                currentUserId,
                      );
                    },
                  ),
                ),

                MessageInput(
                  controller:
                      _messageController,
                  onSend:
                      _sendMessage,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}