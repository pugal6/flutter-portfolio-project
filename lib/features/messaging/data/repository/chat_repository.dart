import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message_model.dart';

class ChatRepository {
  final FirebaseFirestore firestore;

  ChatRepository({
    required this.firestore,
  });

  Stream<List<MessageModel>> streamMessages(
    String jobId,
  ) {
    return firestore
        .collection('jobs')
        .doc(jobId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => MessageModel.fromMap(
                  doc.data(),
                  doc.id,
                ),
              )
              .toList(),
        );
  }

  Future<void> sendMessage({
    required String jobId,
    required String senderId,
    required String senderRole,
    required String message,
  }) async {
    await firestore
        .collection('jobs')
        .doc(jobId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'senderRole': senderRole,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}