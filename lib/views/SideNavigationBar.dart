// الويدجت الخاصة بقائمة التنقل الجانبية
import 'package:dema/views/NavItem.dart';
import 'package:flutter/material.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 32.0),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E293B),
                    shape: BoxShape.circle,
                  ),
                  // You can add an icon or logo here
                ),
                const SizedBox(width: 12),
                const Text(
                  'StayEasy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
          NavItem(
            icon: Icons.dashboard_rounded,
            title: 'Dashboard',
            isSelected: true,
          ),
          NavItem(icon: Icons.calendar_today_rounded, title: 'Calendar'),
          NavItem(icon: Icons.book_online_rounded, title: 'Bookings'),
          NavItem(icon: Icons.room_service_rounded, title: 'Rooms'),
          const Spacer(),
          NavItem(icon: Icons.settings_rounded, title: 'Settings'),
        ],
      ),
    );
  }
}
