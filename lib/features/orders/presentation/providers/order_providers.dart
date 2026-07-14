import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../shared/models/order_model.dart';
import '../../../../shared/models/order_item_model.dart';

final orderHistoryProvider =
    StreamProvider<List<OrderModel>>((ref) {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return Stream.value([]);
  }

  return FirebaseFirestore.instance
      .collection('orders')
      .where('userId', isEqualTo: user.uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();

      final items =
          (data['items'] as List<dynamic>? ?? [])
              .map(
                (item) => OrderItemModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();

      return OrderModel(
        id: doc.id,
        userId: data['userId'] ?? '',
        userEmail: data['userEmail'] ?? '',
        total:
            (data['total'] as num?)?.toDouble() ?? 0,
        status: data['status'] ?? '',
        createdAt:
            (data['createdAt'] as Timestamp)
                .toDate(),
        items: items,
      );
    }).toList();
  });
});