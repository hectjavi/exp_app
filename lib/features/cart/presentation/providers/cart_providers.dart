import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/datasources/cart_local_datasource.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/entities/cart_entity.dart';
import '../../../../shared/models/product_model.dart';
import '../../../../shared/models/cart_item_model.dart';
import '../states/cart_state.dart';

// Repository Provider
final cartRepositoryProvider = Provider((ref) {
  return CartRepositoryImpl(CartLocalDataSource());
});

// Cart Notifier
class CartNotifier extends StateNotifier<CartState> {
  final CartRepositoryImpl _repository;

  CartNotifier(this._repository) : super(CartState.initial()) {
    loadCart();
  }

  Future<void> loadCart() async {
    state = CartState.loading();
    try {
      final items = await _repository.getCartItems();
      final total = await _repository.getTotal();
      final count = await _repository.getItemCount();

      // Mapper: Models → Entity
      final entity = CartEntity(
        items: items,
        total: total,
        itemCount: count,
      );

      state = CartState.success(entity);
    } catch (e) {
      state = CartState.failure(e.toString());
    }
  }

  Future<void> addItem({
    required ProductModel product,
    required int quantity,
    required String selectedSize,
    required String selectedColor,
  }) async {
    try {
      final item = CartItemModel(
        id: const Uuid().v4(),
        product: product,
        quantity: quantity,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
      );

      await _repository.addItem(item);
      await loadCart();
    } catch (e) {
      state = CartState.failure(e.toString());
    }
  }

  Future<void> removeItem(String itemId) async {
    try {
      await _repository.removeItem(itemId);
      await loadCart();
    } catch (e) {
      state = CartState.failure(e.toString());
    }
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    try {
      await _repository.updateQuantity(itemId, quantity);
      await loadCart();
    } catch (e) {
      state = CartState.failure(e.toString());
    }
  }

  Future<void> clearCart() async {
    try {
      await _repository.clearCart();
      await loadCart();
    } catch (e) {
      state = CartState.failure(e.toString());
    }
  }
}

// Cart Notifier Provider
final cartNotifierProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return CartNotifier(repository);
});

// Derived Providers (acceden a través del Entity)
final cartItemsCountProvider = Provider<int>((ref) {
  return ref.watch(cartNotifierProvider).data?.itemCount ?? 0;
});

final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartNotifierProvider).data?.total ?? 0.0;
});
