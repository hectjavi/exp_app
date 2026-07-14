import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart_entity.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    CartEntity? data,
    @Default(false) bool isLoading,
    String? error,
  }) = _CartState;

  factory CartState.initial() => const CartState();

  factory CartState.loading() => const CartState(isLoading: true);

  factory CartState.success(CartEntity data) => CartState(
    data: data,
    isLoading: false,
  );

  factory CartState.failure(String error) => CartState(
    isLoading: false,
    error: error,
  );
}
