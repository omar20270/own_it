import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ResultRepository {
  final _firestore = FirebaseFirestore.instance;
  static const _userId = 'user_001';

  Future<void> saveCheckin({
    required String goal,
    required String habit,
    required bool goalDone,
    required bool habitAvoided,
  }) async {
    final todayId = DateFormat('yyyy-MM-dd').format(DateTime.now());

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('checkins')
        .doc(todayId)
        .set({
          'goal': goal,
          'habit': habit,
          'goalDone': goalDone,
          'habitAvoided': habitAvoided,
          'date': todayId,
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  Future<List<Map<String, dynamic>>> getAllCheckins() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('checkins')
        .orderBy('date')
        .get();

    return snapshot.docs.map((doc) {
      return {'id': doc.id, ...doc.data()};
    }).toList();
  }
}
