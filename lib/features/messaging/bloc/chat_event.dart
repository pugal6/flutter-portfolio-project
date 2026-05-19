abstract class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String jobId;

  LoadMessages(this.jobId);
}

class MessagesUpdated extends ChatEvent {
  final List<dynamic> messages;

  MessagesUpdated(this.messages);
}

class SendMessage extends ChatEvent {
  final String jobId;
  final String senderId;
  final String senderRole;
  final String message;

  SendMessage({
    required this.jobId,
    required this.senderId,
    required this.senderRole,
    required this.message,
  });
}