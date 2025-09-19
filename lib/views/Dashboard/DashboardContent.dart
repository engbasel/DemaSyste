// الويدجت الخاصة بالمحتوى الرئيسي للوحة التحكم
import 'package:dema/views/Dashboard/DashboardHeader.dart';
import 'package:dema/views/Dashboard/OverviewSection.dart';
import 'package:dema/views/Dashboard/RecentBookingsSection.dart';
import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardHeader(),
          const SizedBox(height: 24),
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome back, Sarah',
            style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 24),
          OverviewSection(),
          const SizedBox(height: 24),
          const RecentBookingsSection(),
        ],
      ),
    );
  }
}
