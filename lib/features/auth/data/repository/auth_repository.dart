// auth_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../shared/enums/user_role.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final userCredential = await _authService.signUp(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'role': role.name,
      'createdAt': Timestamp.now(),
    });
  }

  Future<UserRole> login({
    required String email,
    required String password,
  }) async {
    final userCredential = await _authService.login(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user == null) {
      throw Exception('User not found');
    }

    final userDoc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      throw Exception('User data not found');
    }

    final role = userDoc.data()?['role'];

    if (role == 'homeowner') {
      return UserRole.homeowner;
    }

    return UserRole.professional;
  }

  Future<void> logout() async {
  await _authService.logout();
}
}

