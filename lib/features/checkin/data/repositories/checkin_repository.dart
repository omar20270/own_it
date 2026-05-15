import 'package:cloud_firestore/cloud_firestore.dart';

class CheckinRepository {
  final _firestore = FirebaseFirestore.instance;
  static const _userId = 'user_001';

  // Save today's check-in answers
  Future<void> saveCheckin({
    required bool goalDone,
    required bool habitAvoided,
  }) async {
    final today = _todayKey();
    final isHonest = goalDone && habitAvoided;

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('checkins')
        .doc(today)
        .set({
          'goalDone': goalDone,
          'habitAvoided': habitAvoided,
          'isHonest': isHonest,
          'date': today,
          'savedAt': FieldValue.serverTimestamp(),
        });
  }

  // Load today's check-in (if already answered)
  Future<Map<String, dynamic>?> getTodayCheckin() async {
    final doc = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('checkins')
        .doc(_todayKey())
        .get();

    return doc.exists ? doc.data() : null;
  }

  // Load user setup (goal + badHabit)
  Future<Map<String, dynamic>?> getUserSetup() async {
    final doc = await _firestore.collection('users').doc(_userId).get();

    return doc.exists ? doc.data() : null;
  }

  // Count honest days (streak)
  Future<int> getHonestDaysCount() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('checkins')
        .where('isHonest', isEqualTo: true)
        .get();

    return snapshot.docs.length;
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<List<Map<String, dynamic>>> getAllCheckins() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('checkins')
        .orderBy('date')
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
