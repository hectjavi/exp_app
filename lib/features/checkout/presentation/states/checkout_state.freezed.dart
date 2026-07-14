// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckoutState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isProcessingPayment => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError; // Payment
  int get selectedCardIndex => throw _privateConstructorUsedError;
  bool get useSameAddress => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get paymentSuccess => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckoutStateCopyWith<CheckoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
          CheckoutState value, $Res Function(CheckoutState) then) =
      _$CheckoutStateCopyWithImpl<$Res, CheckoutState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isProcessingPayment,
      int currentStep,
      int selectedCardIndex,
      bool useSameAddress,
      String? error,
      bool paymentSuccess});
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res, $Val extends CheckoutState>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProcessingPayment = null,
    Object? currentStep = null,
    Object? selectedCardIndex = null,
    Object? useSameAddress = null,
    Object? error = freezed,
    Object? paymentSuccess = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingPayment: null == isProcessingPayment
          ? _value.isProcessingPayment
          : isProcessingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCardIndex: null == selectedCardIndex
          ? _value.selectedCardIndex
          : selectedCardIndex // ignore: cast_nullable_to_non_nullable
              as int,
      useSameAddress: null == useSameAddress
          ? _value.useSameAddress
          : useSameAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentSuccess: null == paymentSuccess
          ? _value.paymentSuccess
          : paymentSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckoutStateImplCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$$CheckoutStateImplCopyWith(
          _$CheckoutStateImpl value, $Res Function(_$CheckoutStateImpl) then) =
      __$$CheckoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isProcessingPayment,
      int currentStep,
      int selectedCardIndex,
      bool useSameAddress,
      String? error,
      bool paymentSuccess});
}

/// @nodoc
class __$$CheckoutStateImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$CheckoutStateImpl>
    implements _$$CheckoutStateImplCopyWith<$Res> {
  __$$CheckoutStateImplCopyWithImpl(
      _$CheckoutStateImpl _value, $Res Function(_$CheckoutStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProcessingPayment = null,
    Object? currentStep = null,
    Object? selectedCardIndex = null,
    Object? useSameAddress = null,
    Object? error = freezed,
    Object? paymentSuccess = null,
  }) {
    return _then(_$CheckoutStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingPayment: null == isProcessingPayment
          ? _value.isProcessingPayment
          : isProcessingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCardIndex: null == selectedCardIndex
          ? _value.selectedCardIndex
          : selectedCardIndex // ignore: cast_nullable_to_non_nullable
              as int,
      useSameAddress: null == useSameAddress
          ? _value.useSameAddress
          : useSameAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentSuccess: null == paymentSuccess
          ? _value.paymentSuccess
          : paymentSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CheckoutStateImpl implements _CheckoutState {
  const _$CheckoutStateImpl(
      {this.isLoading = false,
      this.isProcessingPayment = false,
      this.currentStep = 2,
      this.selectedCardIndex = 0,
      this.useSameAddress = true,
      this.error,
      this.paymentSuccess = false});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isProcessingPayment;
  @override
  @JsonKey()
  final int currentStep;
// Payment
  @override
  @JsonKey()
  final int selectedCardIndex;
  @override
  @JsonKey()
  final bool useSameAddress;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool paymentSuccess;

  @override
  String toString() {
    return 'CheckoutState(isLoading: $isLoading, isProcessingPayment: $isProcessingPayment, currentStep: $currentStep, selectedCardIndex: $selectedCardIndex, useSameAddress: $useSameAddress, error: $error, paymentSuccess: $paymentSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isProcessingPayment, isProcessingPayment) ||
                other.isProcessingPayment == isProcessingPayment) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.selectedCardIndex, selectedCardIndex) ||
                other.selectedCardIndex == selectedCardIndex) &&
            (identical(other.useSameAddress, useSameAddress) ||
                other.useSameAddress == useSameAddress) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.paymentSuccess, paymentSuccess) ||
                other.paymentSuccess == paymentSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isProcessingPayment,
      currentStep, selectedCardIndex, useSameAddress, error, paymentSuccess);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      __$$CheckoutStateImplCopyWithImpl<_$CheckoutStateImpl>(this, _$identity);
}

abstract class _CheckoutState implements CheckoutState {
  const factory _CheckoutState(
      {final bool isLoading,
      final bool isProcessingPayment,
      final int currentStep,
      final int selectedCardIndex,
      final bool useSameAddress,
      final String? error,
      final bool paymentSuccess}) = _$CheckoutStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isProcessingPayment;
  @override
  int get currentStep;
  @override // Payment
  int get selectedCardIndex;
  @override
  bool get useSameAddress;
  @override
  String? get error;
  @override
  bool get paymentSuccess;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
