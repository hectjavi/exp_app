import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/models/cart_item_model.dart';

class CartLocalDataSource {
  static const String _key = 'cart_items';

  Future<List<CartItemModel>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List decoded = json.decode(jsonString);
    return decoded.map((e) => CartItemModel.fromJson(e)).toList();
  }

  Future<void> saveCart(List<CartItemModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        json.encode(items.map((e) => e.toJson()).toList());

    await prefs.setString(_key, encoded);
  }

Future<void> addItem(CartItemModel item) async {
  final items = await getCartItems();

  String normalize(String value) => value.trim().toLowerCase();

  String buildKey(CartItemModel item) {
    return "${item.product.id}_${normalize(item.selectedSize)}_${normalize(item.selectedColor)}";
  }

  final itemKey = buildKey(item);

  final index = items.indexWhere(
    (existing) => buildKey(existing) == itemKey,
  );

  if (index != -1) {
    final existing = items[index];

    items[index] = existing.copyWith(
      quantity: existing.quantity + item.quantity,
    );
  } else {
    items.add(item);
  }

  await saveCart(items);
}

Future<void> removeItem(String itemId) async {
  final items = await getCartItems();
  items.removeWhere((item) => item.id == itemId);
  await saveCart(items);
}

Future<void> updateQuantity(String itemId, int qty) async {
  final items = await getCartItems();

  final index = items.indexWhere((i) => i.id == itemId);

  if (index != -1) {
    if (qty <= 0) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(quantity: qty);
    }
  }

  await saveCart(items);
}

Future<double> getTotal() async {
  final items = await getCartItems();

  return items.fold<double>(
    0.0,
    (double sum, item) =>
        sum + (item.product.price * item.quantity),
  );
}


Future<int> getItemCount() async {
  final items = await getCartItems();

  return items.fold<int>(
    0,
    (int sum, item) => sum + item.quantity,
  );
}

Future<void> clearCart() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_key);
}

}
