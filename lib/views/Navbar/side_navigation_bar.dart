import 'package:dema/views/Navbar/nav_item.dart';
import 'package:flutter/material.dart';

class SideNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SideNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ --- الجزء الذي تم إصلاحه ---
    // تم نقل اللون إلى داخل الـ BoxDecoration
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white, // اللون الآن هنا
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      // --- نهاية الجزء الذي تم إصلاحه ---
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
                ),
                const SizedBox(width: 12),
                const Text(
                  'مؤسسة ديما',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),

          // --- Main Navigation ---
          NavItem(
            icon: Icons.dashboard_rounded,
            title: 'اللوحة الرئيسية',
            isSelected: selectedIndex == 0,
            onTap: () => onItemSelected(0),
          ),
          NavItem(
            icon: Icons.calendar_today_rounded,
            title: 'التقويم',
            isSelected: selectedIndex == 1,
            onTap: () => onItemSelected(1),
          ),
          NavItem(
            icon: Icons.book_online_rounded,
            title: 'الحجوزات',
            isSelected: selectedIndex == 2,
            onTap: () => onItemSelected(2),
          ),
          NavItem(
            icon: Icons.maps_home_work_rounded, // أيقونة محسنة
            title: 'الوحدات العقارية', // اسم محسن
            isSelected: selectedIndex == 3,
            onTap: () => onItemSelected(3),
          ),

          const Divider(indent: 16, endIndent: 16, height: 24),

          // --- ✅ أقسام الإدارة الجديدة ---
          NavItem(
            icon: Icons.people_alt_rounded,
            title: 'إدارة المستأجرين',
            isSelected: selectedIndex == 4,
            onTap: () => onItemSelected(4),
          ),
          NavItem(
            icon: Icons.people_alt_rounded,
            title: 'إدارة الملاك',
            isSelected: selectedIndex == 5,
            onTap: () => onItemSelected(5),
          ),
          NavItem(
            icon: Icons.build_rounded,
            title: 'طلبات الصيانة',
            isSelected: selectedIndex == 6,
            onTap: () => onItemSelected(6),
          ),
          NavItem(
            icon: Icons.assessment_rounded,
            title: 'التقارير المالية',
            isSelected: selectedIndex == 7,
            onTap: () => onItemSelected(7),
          ),

          const Spacer(),

          // --- الإعدادات ---
          NavItem(
            icon: Icons.settings_rounded,
            title: 'الإعدادات',
            isSelected: selectedIndex == 8, // تم تحديث الرقم
            onTap: () => onItemSelected(8),
          ),
        ],
      ),
    );
  }
}
