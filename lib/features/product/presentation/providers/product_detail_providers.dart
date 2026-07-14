import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/product_model.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../states/product_detail_state.dart';

class ProductDetailNotifier extends StateNotifier<ProductDetailState> {
  final ProductModel _product;
  final Ref _ref;

  ProductDetailNotifier(this._product, this._ref)
      : super(ProductDetailState.initial()) {
    // Initialize with first available size and color
    if (_product.sizes.isNotEmpty) {
      state = state.copyWith(selectedSize: _product.sizes.first);
    }
    if (_product.colors.isNotEmpty) {
      state = state.copyWith(selectedColor: _product.colors.first);
    }
  }

  void selectSize(String size) {
    state = state.copyWith(selectedSize: size);
  }

  void selectColor(String color) {
    state = state.copyWith(selectedColor: color);
  }

  void incrementQuantity() {
    state = state.copyWith(quantity: state.quantity + 1);
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      state = state.copyWith(quantity: state.quantity - 1);
    }
  }

  Future<void> addToCart() async {
    if (state.selectedSize.isEmpty || state.selectedColor.isEmpty) {
      state = ProductDetailState.error('Please select size and color');
      return;
    }

    state = ProductDetailState.addingToCart();

    try {
      await _ref.read(cartNotifierProvider.notifier).addItem(
            product: _product,
            quantity: state.quantity,
            selectedSize: state.selectedSize,
            selectedColor: state.selectedColor,
          );

      state = ProductDetailState.addedToCart();

      // Reset success state after delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          state = state.copyWith(addToCartSuccess: false);
        }
      });
    } catch (e) {
      state = ProductDetailState.error(e.toString());
    }
  }
}

final productDetailProvider = StateNotifierProvider.family<
    ProductDetailNotifier, ProductDetailState, ProductModel>((ref, product) {
  return ProductDetailNotifier(product, ref);
});
