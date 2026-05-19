import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/message_model.dart';
import '../data/repository/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  ChatBloc({
    required this.repository,
  }) : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<SendMessage>(_onSendMessage);
  }

  void _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) {
    emit(ChatLoading());

    _messagesSubscription?.cancel();

    _messagesSubscription = repository
        .streamMessages(event.jobId)
        .listen(
      (messages) {
        add(MessagesUpdated(messages));
      },
    );
  }

  void _onMessagesUpdated(
    MessagesUpdated event,
    Emitter<ChatState> emit,
  ) {
    emit(
      ChatLoaded(
        List<MessageModel>.from(event.messages),
      ),
    );
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await repository.sendMessage(
        jobId: event.jobId,
        senderId: event.senderId,
        senderRole: event.senderRole,
        message: event.message,
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}