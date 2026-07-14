import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final double height;
  final bool compact;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.height = 40,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(compact ? 8 : 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onDecrement,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(compact ? 8 : 12),
            ),
            child: Container(
              padding: EdgeInsets.all(compact ? 6 : 10),
              child: Icon(
                Icons.remove,
                color: quantity > 1 ? AppTheme.textPrimary : AppTheme.textMuted,
                size: compact ? 16 : 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 16),
            child: Text(
              '$quantity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: compact ? 14 : 16,
              ),
            ),
          ),
          InkWell(
            onTap: onIncrement,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(compact ? 8 : 12),
            ),
            child: Container(
              padding: EdgeInsets.all(compact ? 6 : 10),
              child: Icon(
                Icons.add,
                color: AppTheme.primaryColor,
                size: compact ? 16 : 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
