import 'package:dema/views/Dashboard/OccupancyChartSection.dart';
import 'package:dema/views/Dashboard/OverviewSection.dart';
import 'package:dema/views/Dashboard/TodaysActivitySection.dart';
import 'package:dema/views/booking/RecentBookingsSection.dart';
import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Lighter grey background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back, here is a summary of your property.',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 24),

            // Responsive Layout
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  // Wide screen layout (e.g., Desktop)
                  return _buildWideLayout();
                } else {
                  // Narrow screen layout (e.g., Tablet/Mobile)
                  return _buildNarrowLayout();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Layout for wider screens
  Widget _buildWideLayout() {
    return Column(
      children: [
        OverviewSection(),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(flex: 3, child: OccupancyChartSection()),
            const SizedBox(width: 24),
            Expanded(flex: 2, child: TodaysActivitySection()),
          ],
        ),
        const SizedBox(height: 24),
        const RecentBookingsSection(),
      ],
    );
  }

  // Layout for narrower screens
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
