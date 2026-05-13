import 'package:cloud_firestore/cloud_firestore.dart';

class ResultRepository {
  final _firestore = FirebaseFirestore.instance;
  static const _userId = 'user_001';

  // Load all 21 checkins for the progress grid
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
