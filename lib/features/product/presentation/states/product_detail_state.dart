import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_state.freezed.dart';

@freezed
abstract class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    @Default('') String selectedSize,
    @Default('') String selectedColor,
    @Default(1) int quantity,
    @Default(false) bool isAddingToCart,
    @Default(false) bool addToCartSuccess,
    String? error,
  }) = _ProductDetailState;

  factory ProductDetailState.initial() => const ProductDetailState();

  factory ProductDetailState.addingToCart() => const ProductDetailState(
    isAddingToCart: true,
  );

  factory ProductDetailState.addedToCart() => const ProductDetailState(
    isAddingToCart: false,
    addToCartSuccess: true,
  );

  factory ProductDetailState.error(String message) => ProductDetailState(
    isAddingToCart: false,
    error: message,
  );
}
