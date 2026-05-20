import 'package:cloud_firestore/cloud_firestore.dart';

class SetupRepository {
  final _firestore = FirebaseFirestore.instance;

  static const _userId = 'user_001';

  Future<void> saveSetup({
    required String goal,
    required String badHabit,
  }) async {
    await _firestore.collection('users').doc(_userId).set({
      'goal': goal,
      'badHabit': badHabit,
      'startDate': DateTime.now().toIso8601String(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
