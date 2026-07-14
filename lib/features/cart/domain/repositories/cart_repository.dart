import '../../../../shared/models/cart_item_model.dart';
import '../../../../shared/models/product_model.dart';

abstract class CartRepository {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addItem(CartItemModel item);
  Future<void> removeItem(String itemId);
  Future<void> updateQuantity(String itemId, int quantity);
  Future<void> clearCart();
  Future<double> getTotal();
  Future<int> getItemCount();
}
