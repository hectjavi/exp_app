import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/checkout_notifier.dart';
import '../states/checkout_state.dart';

final checkoutNotifierProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier(ref);
});