// ويدجت لعنصر واحد في قائمة التنقل
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;

  const NavItem({
    required this.icon,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected
                ? const Color(0xFF2563EB)
                : const Color(0xFF64748B),
            size: 20,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }
}
