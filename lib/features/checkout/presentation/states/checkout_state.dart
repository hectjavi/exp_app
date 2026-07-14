import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_state.freezed.dart';

@freezed
abstract class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessingPayment,
    @Default(2) int currentStep, // Payment
    @Default(0) int selectedCardIndex,
    @Default(true) bool useSameAddress,
    String? error,
    @Default(false) bool paymentSuccess,
  }) = _CheckoutState;

  factory CheckoutState.initial() => const CheckoutState();

  factory CheckoutState.loading() => const CheckoutState(isLoading: true);

  factory CheckoutState.failure(String error) => CheckoutState(
        isLoading: false,
        error: error,
      );

  factory CheckoutState.processingPayment() =>
      const CheckoutState(isProcessingPayment: true);

  factory CheckoutState.success() => const CheckoutState(
        isProcessingPayment: false,
        paymentSuccess: true,
      );
}