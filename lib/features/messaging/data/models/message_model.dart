import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String senderRole;
  final String message;
  final Timestamp timestamp;

  const MessageModel({
    required this.id,
    required this.senderId,
    required this.senderRole,
    required this.message,
    required this.timestamp,
  });

  factory MessageModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return MessageModel(
      id: id,
      senderId: map['senderId'] ?? '',
      senderRole: map['senderRole'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderRole': senderRole,
      'message': message,
      'timestamp': timestamp,
    };
  }
}