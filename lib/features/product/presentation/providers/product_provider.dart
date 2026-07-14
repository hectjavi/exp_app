import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/product_model.dart';
import '../../data/product_remote_datasource.dart';

// ✅ datasource provider
final productRemoteDataSourceProvider = Provider((ref) {
  return ProductRemoteDataSource();
});

// ✅ products provider (Firestore real)
final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final datasource = ref.read(productRemoteDataSourceProvider);
  return datasource.getProducts();
});
