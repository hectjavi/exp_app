import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../states/checkout_state.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../providers/card_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final Ref ref;
  final Dio _dio = Dio();

  CheckoutNotifier(this.ref) : super(CheckoutState.initial());

  // ✅ seleccionar tarjeta
  void selectCard(int index) {
    state = state.copyWith(selectedCardIndex: index);
  }

  // ✅ checkbox dirección
  void toggleSameAddress(bool value) {
    state = state.copyWith(useSameAddress: value);
  }

  // ✅ PROCESAR PAGO
  Future<void> processPayment() async {
    state = state.copyWith(
      isProcessingPayment: true,
      error: null,
      paymentSuccess: false,
    );

    try {
      final cart = ref.read(cartNotifierProvider).data;

      // ✅ validar carrito
      if (cart == null || cart.items.isEmpty) {
        throw Exception('Carrito vacío');
      }

      final amount = cart.total;

      // ✅ obtener tarjeta REAL desde datasource
      final cardNumber = await _getSelectedCardNumber();

      // ✅ llamada API
      final response = await _dio.post(
        'https://processpayment-sfdkfoab2q-uc.a.run.app',
        data: {
          "amount": amount,
          "cardNumber": cardNumber,
        },
      );

      final data = response.data;

      final bool isSuccess = data['success'] == true;
      final String message = data['message'] ?? 'Error en el pago';

      if (isSuccess) {
        state = state.copyWith(
          isProcessingPayment: false,
          paymentSuccess: true,
          error: null,
        );
      final user =
          FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('orders')
            .add({
          'userId': user.uid,
          'userEmail': user.email,
          'total': cart.total,
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
          'items': cart.items.map((item) {
            return {
              'productId': item.product.id,
              'name': item.product.name,
              'price': item.product.price,
              'quantity': item.quantity,
              'image': item.product.images.first,
            };
          }).toList(),
        });
      }
        await ref.read(cartNotifierProvider.notifier).clearCart();
      } else {
        state = state.copyWith(
          isProcessingPayment: false,
          paymentSuccess: false,
          error: message,
        );
      }

    } catch (e) {
      state = state.copyWith(
        isProcessingPayment: false,
        error: e.toString(),
      );
    }
  }

  // ✅ obtener tarjeta desde datasource
  Future<String> _getSelectedCardNumber() async {
    final dataSource = ref.read(cardDataSourceProvider);

    final card = await dataSource.getCardByIndex(
      state.selectedCardIndex,
    );

    if (card == null) {
      throw Exception('Tarjeta no válida');
    }

    return card.cardNumber;
  }
}