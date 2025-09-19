import 'package:dema/views/Dashboard/occupancy_chart_section.dart';
import 'package:dema/views/Dashboard/overview_section.dart';
import 'package:dema/views/Dashboard/todays_activity_section.dart';
import 'package:dema/views/booking/recent_bookings_section.dart';
import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // 👈 دعم الكتابة من اليمين لليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
        
              backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العنوان الرئيسي
              Text(
                'لوحة التحكم',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'مرحباً بك مجدداً، هنا ملخص عن عقاراتك وإدارتها.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 24),

              // تصميم مرن
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1200) {
                    // شاشات عريضة (كمبيوتر)
                    return _buildWideLayout();
                  } else {
                    // شاشات أصغر (تابلت / جوال)
                    return _buildNarrowLayout();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // تصميم للشاشات العريضة
  Widget _buildWideLayout() {
    return Column(
      children: [
        OverviewSection(),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: OccupancyChartSection()),
            const SizedBox(width: 24),
            Expanded(flex: 2, child: TodaysActivitySection()),
          ],
        ),
        const SizedBox(height: 24),
        const RecentBookingsSection(),
      ],
    );
  }

  // تصميم للشاشات الصغيرة
  Widget _buildNarrowLayout() {
    return Column(
      children: [
        OverviewSection(),
        const SizedBox(height: 24),
        TodaysActivitySection(),
        const SizedBox(height: 24),
        OccupancyChartSection(),
        const SizedBox(height: 24),
        const RecentBookingsSection(),
      ],
    );
  }
}
