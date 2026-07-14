import '../../../../shared/models/cart_item_model.dart';

class CartEntity {
  final List<CartItemModel> items;
  final double total;
  final int itemCount;

  const CartEntity({
    required this.items,
    required this.total,
    required this.itemCount,
  });
}
