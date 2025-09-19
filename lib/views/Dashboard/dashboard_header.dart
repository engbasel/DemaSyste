// ويدجت للشريط العلوي الذي يحتوي على البحث والإشعارات
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Color(0xFF94A3B8)),
                hintText: 'بحث',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color(0xFF94A3B8)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        const Icon(
          Icons.notifications_none_rounded,
          color: Color(0xFF64748B),
          size: 28,
        ),
        const SizedBox(width: 24),
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?u=a042581f4e29026704d',
          ), // Placeholder image
        ),
      ],
    );
  }
}
