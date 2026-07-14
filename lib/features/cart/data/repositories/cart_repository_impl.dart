import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';
import '../../../../shared/models/cart_item_model.dart';
import '../../../../shared/models/product_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _localDataSource;

  CartRepositoryImpl(this._localDataSource);

  @override
  Future<List<CartItemModel>> getCartItems() async {
    return await _localDataSource.getCartItems();
  }

  @override
  Future<void> addItem(CartItemModel item) async {
    await _localDataSource.addItem(item);
  }

  @override
  Future<void> removeItem(String itemId) async {
    await _localDataSource.removeItem(itemId);
  }

  @override
  Future<void> updateQuantity(String itemId, int quantity) async {
    await _localDataSource.updateQuantity(itemId, quantity);
  }

  @override
  Future<void> clearCart() async {
    await _localDataSource.clearCart();
  }

  @override
  Future<double> getTotal() async {
    return await _localDataSource.getTotal();
  }

 
@override
Future<int> getItemCount() async {
  final count = await _localDataSource.getItemCount();
  return count.toInt();
}

}
