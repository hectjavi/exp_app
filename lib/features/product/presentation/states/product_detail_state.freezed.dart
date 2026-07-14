// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductDetailState {
  String get selectedSize => throw _privateConstructorUsedError;
  String get selectedColor => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  bool get isAddingToCart => throw _privateConstructorUsedError;
  bool get addToCartSuccess => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductDetailStateCopyWith<ProductDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailStateCopyWith(
          ProductDetailState value, $Res Function(ProductDetailState) then) =
      _$ProductDetailStateCopyWithImpl<$Res, ProductDetailState>;
  @useResult
  $Res call(
      {String selectedSize,
      String selectedColor,
      int quantity,
      bool isAddingToCart,
      bool addToCartSuccess,
      String? error});
}

/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res, $Val extends ProductDetailState>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSize = null,
    Object? selectedColor = null,
    Object? quantity = null,
    Object? isAddingToCart = null,
    Object? addToCartSuccess = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      selectedSize: null == selectedSize
          ? _value.selectedSize
          : selectedSize // ignore: cast_nullable_to_non_nullable
              as String,
      selectedColor: null == selectedColor
          ? _value.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isAddingToCart: null == isAddingToCart
          ? _value.isAddingToCart
          : isAddingToCart // ignore: cast_nullable_to_non_nullable
              as bool,
      addToCartSuccess: null == addToCartSuccess
          ? _value.addToCartSuccess
          : addToCartSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductDetailStateImplCopyWith<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  factory _$$ProductDetailStateImplCopyWith(_$ProductDetailStateImpl value,
          $Res Function(_$ProductDetailStateImpl) then) =
      __$$ProductDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String selectedSize,
      String selectedColor,
      int quantity,
      bool isAddingToCart,
      bool addToCartSuccess,
      String? error});
}

/// @nodoc
class __$$ProductDetailStateImplCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res, _$ProductDetailStateImpl>
    implements _$$ProductDetailStateImplCopyWith<$Res> {
  __$$ProductDetailStateImplCopyWithImpl(_$ProductDetailStateImpl _value,
      $Res Function(_$ProductDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSize = null,
    Object? selectedColor = null,
    Object? quantity = null,
    Object? isAddingToCart = null,
    Object? addToCartSuccess = null,
    Object? error = freezed,
  }) {
    return _then(_$ProductDetailStateImpl(
      selectedSize: null == selectedSize
          ? _value.selectedSize
          : selectedSize // ignore: cast_nullable_to_non_nullable
              as String,
      selectedColor: null == selectedColor
          ? _value.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isAddingToCart: null == isAddingToCart
          ? _value.isAddingToCart
          : isAddingToCart // ignore: cast_nullable_to_non_nullable
              as bool,
      addToCartSuccess: null == addToCartSuccess
          ? _value.addToCartSuccess
          : addToCartSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ProductDetailStateImpl implements _ProductDetailState {
  const _$ProductDetailStateImpl(
      {this.selectedSize = '',
      this.selectedColor = '',
      this.quantity = 1,
      this.isAddingToCart = false,
      this.addToCartSuccess = false,
      this.error});

  @override
  @JsonKey()
  final String selectedSize;
  @override
  @JsonKey()
  final String selectedColor;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final bool isAddingToCart;
  @override
  @JsonKey()
  final bool addToCartSuccess;
  @override
  final String? error;

  @override
  String toString() {
    return 'ProductDetailState(selectedSize: $selectedSize, selectedColor: $selectedColor, quantity: $quantity, isAddingToCart: $isAddingToCart, addToCartSuccess: $addToCartSuccess, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailStateImpl &&
            (identical(other.selectedSize, selectedSize) ||
                other.selectedSize == selectedSize) &&
            (identical(other.selectedColor, selectedColor) ||
                other.selectedColor == selectedColor) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isAddingToCart, isAddingToCart) ||
                other.isAddingToCart == isAddingToCart) &&
            (identical(other.addToCartSuccess, addToCartSuccess) ||
                other.addToCartSuccess == addToCartSuccess) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedSize, selectedColor,
      quantity, isAddingToCart, addToCartSuccess, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailStateImplCopyWith<_$ProductDetailStateImpl> get copyWith =>
      __$$ProductDetailStateImplCopyWithImpl<_$ProductDetailStateImpl>(
          this, _$identity);
}

abstract class _ProductDetailState implements ProductDetailState {
  const factory _ProductDetailState(
      {final String selectedSize,
      final String selectedColor,
      final int quantity,
      final bool isAddingToCart,
      final bool addToCartSuccess,
      final String? error}) = _$ProductDetailStateImpl;

  @override
  String get selectedSize;
  @override
  String get selectedColor;
  @override
  int get quantity;
  @override
  bool get isAddingToCart;
  @override
  bool get addToCartSuccess;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$ProductDetailStateImplCopyWith<_$ProductDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
