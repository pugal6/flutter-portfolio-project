
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

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    String name = userDoc.data()?['name'] ?? '';
    if (name.trim().isEmpty) {
      name = 'Homeowner';
    }

    final docRef =
        _firestore.collection('jobs').doc();

    final job = JobModel(
      id: docRef.id,
      homeownerId: user.uid,
      homeownerName: name,
      category: category,
      description: description,
      status: JobStatus.pending,
      createdAt: DateTime.now(),
      professionalId: null,
      professionalName: null,
      cancelledBy: null,
    );

    await docRef.set(
      job.toMap(),
    );
  }

  Stream<List<JobModel>> getHomeownerJobs() {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    return _firestore
        .collection('jobs')
        .where(
          'homeownerId',
          isEqualTo: user.uid,
        )
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return JobModel.fromMap(
            doc.data(),
          );
        }).toList();
      },
    );
  }

  Stream<List<JobModel>> getOpenJobs() {
  return _firestore
      .collection('jobs')
      .where(
        'status',
        isEqualTo: JobStatus.pending.name,
      )
      .orderBy(
        'createdAt',
        descending: true,
      )
      .snapshots()
      .map(
    (snapshot) {
      return snapshot.docs.map((doc) {
        return JobModel.fromMap(
          doc.data(),
        );
      }).toList();
    },
  );
}

Future<void> acceptJob({
  required String jobId,
}) async {
  final user = _firebaseAuth.currentUser;

  if (user == null) {
    throw Exception('User not logged in');
  }

  final userDoc = await _firestore.collection('users').doc(user.uid).get();
  String name = userDoc.data()?['name'] ?? '';
  if (name.trim().isEmpty) {
    name = 'Professional';
  }

  await _firestore
    .collection('jobs')
    .doc(jobId)
    .update({
  'status': JobStatus.accepted.name,
  'professionalId': user.uid,
  'professionalName': name,
});
}

Future<void> updateJobStatus({
  required String jobId,
  required JobStatus status,
  String? cancelledBy,
}) async {
  await _firestore
      .collection('jobs')
      .doc(jobId)
      .update({
    'status': status.name,
    'cancelledBy': cancelledBy,
  });
}

  Stream<List<JobModel>> getProfessionalActiveJobs() {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    return _firestore
        .collection('jobs')
        .where(
          'professionalId',
          isEqualTo: user.uid,
        )
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => JobModel.fromMap(doc.data()))
            .where((job) =>
                job.status == JobStatus.accepted ||
                job.status == JobStatus.inProgress)
            .toList();
      },
    );
  }


Stream<JobModel> getJobById(
  String jobId,
) {
  return _firestore
      .collection('jobs')
      .doc(jobId)
      .snapshots()
      .map(
    (doc) {
      return JobModel.fromMap(
        doc.data()!,
      );
    },
  );
}
}