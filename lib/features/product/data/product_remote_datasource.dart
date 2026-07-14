import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../shared/models/product_model.dart';

class ProductRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestore
        .collection('products')
        .get();

    return snapshot.docs.map((doc) {
      return ProductModel.fromFirestore(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  Future<void> deleteProduct(String productId) async {
  await _firestore.collection('products').doc(productId).delete();
}
}