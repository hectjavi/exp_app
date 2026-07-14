import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRemoteDataSource {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> saveOrder({
    required String userId,
    required String userEmail,
    required double total,
    required List<Map<String, dynamic>> items,
  }) async {
    await _firestore.collection('orders').add({
      'userId': userId,
      'userEmail': userEmail,
      'total': total,
      'status': 'completed',
      'createdAt': FieldValue.serverTimestamp(),
      'items': items,
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getOrdersByUser(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
  }
}