import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../enums/job_status.dart';
import '../models/job_model.dart';

class JobRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance;

  Future<void> createJob({
    required String category,
    required String description,
  }) async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final docRef =
        _firestore.collection('jobs').doc();

    final job = JobModel(
      id: docRef.id,

      homeownerId: user.uid,

      category: category,

      description: description,

      status: JobStatus.pending,

      createdAt: DateTime.now(),
    );

    await docRef.set(
      job.toMap(),
    );
  }
}