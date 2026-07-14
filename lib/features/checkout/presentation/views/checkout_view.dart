import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/checkout_provider.dart';
import '../providers/card_provider.dart';
import '../../../../shared/models/card_model.dart';

// ✅ provider para obtener tarjetas
final cardsProvider = FutureProvider<List<CardModel>>((ref) async {
  return ref.read(cardDataSourceProvider).getCards();
});

class CheckoutView extends ConsumerWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutNotifierProvider);
    final cardsAsync = ref.watch(cardsProvider);

    // ✅ LISTENER → muestra modal
    ref.listen(checkoutNotifierProvider, (previous, next) {
      // ✅ evitar doble ejecución
      if (previous?.paymentSuccess != next.paymentSuccess &&
          next.paymentSuccess) {
        _showResultDialog(
          context,
          isSuccess: true,
          message:
    'Tu compra fue procesada correctamente y quedó registrada en tu historial.',
        );
      }

      if (previous?.error != next.error && next.error != null) {
        _showResultDialog(
          context,
          isSuccess: false,
          message: next.error!,
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildStepper(state.currentStep),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPaymentSection(ref, state, cardsAsync),
                    const SizedBox(height: 16),
                    _buildCheckbox(ref, state),
                    const SizedBox(height: 16),
                    _buildApplePay(),
                  ],
                ),
              ),
            ),
            _buildContinueButton(ref, state),
          ],
        ),
      ),
    );
  }

  // ✅ HEADER
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const Spacer(),
          const Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const SizedBox(width: 50),
        ],
      ),
    );
  }

  // ✅ STEPPER
  Widget _buildStepper(int currentStep) {
    final steps = ['Your bag', 'Shipping', 'Payment', 'Review'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(steps.length, (index) {
          final isActive = index <= currentStep;

          return Column(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor:
                    index == currentStep ? Colors.blue : Colors.grey[300],
                child: isActive
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : Text('${index + 1}'),
              ),
              const SizedBox(height: 4),
              Text(
                steps[index],
                style: const TextStyle(fontSize: 10),
              )
            ],
          );
        }),
      ),
    );
  }

  // ✅ PAYMENT SECTION (DINÁMICO)
  Widget _buildPaymentSection(
      WidgetRef ref, state, AsyncValue<List<CardModel>> cardsAsync) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose a payment method',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "You won't be charged until you review the order",
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 16),

          Row(
            children: const [
              Icon(Icons.radio_button_checked, color: Colors.blue),
              SizedBox(width: 8),
              Text('Credit Card'),
            ],
          ),

          const SizedBox(height: 10),

          cardsAsync.when(
            data: (cards) => Column(
              children: List.generate(cards.length, (index) {
                final card = cards[index];

                return _cardItem(
                  ref,
                  state,
                  index,
                  card.brand,
                  'xxxx xxxx xxxx ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                );
              }),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
          ),

          TextButton(
            onPressed: () {},
            child: const Text('+ Add new card'),
          ),
        ],
      ),
    );
  }

  Widget _cardItem(
      WidgetRef ref, state, int index, String title, String subtitle) {
    final selected = state.selectedCardIndex == index;

    return GestureDetector(
      onTap: () {
        ref.read(checkoutNotifierProvider.notifier).selectCard(index);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  // ✅ CHECKBOX
  Widget _buildCheckbox(WidgetRef ref, state) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _box(),
      child: Row(
        children: [
          Checkbox(
            value: state.useSameAddress,
            onChanged: (v) {
              ref
                  .read(checkoutNotifierProvider.notifier)
                  .toggleSameAddress(v!);
            },
          ),
          const Expanded(
            child: Text(
              'My billing address is the same as my shipping address',
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  // ✅ APPLE PAY
  Widget _buildApplePay() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _box(),
      child: Row(
        children: const [
          Icon(Icons.radio_button_off),
          SizedBox(width: 8),
          Text('Apple Pay'),
        ],
      ),
    );
  }

  // ✅ BOTÓN
  Widget _buildContinueButton(WidgetRef ref, state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.blue,
        ),
        onPressed: state.isProcessingPayment
            ? null
            : () {
                ref
                    .read(checkoutNotifierProvider.notifier)
                    .processPayment();
              },
        child: state.isProcessingPayment
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Continue'),
      ),
    );
  }

  // ✅ MODAL RESULTADO
void _showResultDialog(
  BuildContext context, {
  required bool isSuccess,
  required String message,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
                size: 70,
              ),

              const SizedBox(height: 16),

              Text(
                isSuccess ? 'Compra realizada' : 'Error',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                message,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              if (isSuccess) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go('/orders');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Ver historial de compras',
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go('/');
                    },
                    child: const Text('Volver al inicio'),
                  ),
                ),
              ] else ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Aceptar'),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}
  // ✅ DECORACIÓN
  BoxDecoration _box() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    );
  }
}

