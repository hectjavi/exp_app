import 'package:flutter/material.dart';

class InterestSelectorWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const InterestSelectorWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        
        splashColor: Colors.blue.withOpacity(0.1),
        
        highlightColor: Colors.blue.withOpacity(0.05),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE8F0FE) : Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? const Color(0xFF1565C0) : Colors.grey[800],
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF1565C0),
                    size: 22,
                  )
                else
                  Icon(
                    Icons.circle_outlined,
                    color: Colors.grey[400],
                    size: 22,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
