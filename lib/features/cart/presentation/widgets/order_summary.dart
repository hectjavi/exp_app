
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double total;
  final bool showShipping;

  const OrderSummary({
    super.key,
    required this.subtotal,
    this.shipping = 0,
    required this.total,
    this.showShipping = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildRow(context, 'Subtotal', subtotal, isTotal: false),

          if (showShipping) ...[
            const SizedBox(height: 8),
            _buildShippingRow(context),
          ],

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),

          _buildRow(context, 'Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildRow(
      BuildContext context, String label, double value,
      {required bool isTotal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
        ),
        Text(
          'Q ${value.toStringAsFixed(2)}',
          style: isTotal
              ? Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
        ),
      ],
    );
  }

  Widget _buildShippingRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Shipping',
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          shipping > 0 ? 'Q ${shipping.toStringAsFixed(2)}' : 'Free',
          style: TextStyle(
            color: shipping > 0
                ? AppTheme.textPrimary
                : AppTheme.successColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
