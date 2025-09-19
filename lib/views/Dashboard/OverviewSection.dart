// ويدجت قسم النظرة العامة
import 'package:dema/views/Rooms/StatCard.dart' show StatCard;
import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            // Simple responsive grid
            final isSmall = constraints.maxWidth < 600;
            return GridView.count(
              crossAxisCount: isSmall ? 2 : 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: isSmall ? 1.5 : 1.8,
              children: const [
                StatCard(
                  title: 'Total Bookings',
                  value: '250',
                  change: '+10%',
                  isPositive: true,
                ),
                StatCard(
                  title: 'Revenue',
                  value: '\$15,000',
                  change: '+5%',
                  isPositive: true,
                ),
                StatCard(
                  title: 'Occupancy Rate',
                  value: '75%',
                  change: '-2%',
                  isPositive: false,
                ),
                StatCard(
                  title: 'Average Stay Duration',
                  value: '3.5 days',
                  change: '+1%',
                  isPositive: true,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
