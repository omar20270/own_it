import 'package:cloud_firestore/cloud_firestore.dart';

class SetupRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveSetup({
    required String goal,
    required String badHabit,
  }) async {
    // For now we use a fixed userId until we add Auth
    const userId = 'user_001';

    await _firestore.collection('users').doc(userId).set({
      'goal': goal,
      'badHabit': badHabit,
      'startDate': DateTime.now().toIso8601String(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
