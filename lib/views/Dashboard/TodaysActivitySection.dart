import 'package:dema/views/booking/booking_model.dart';
import 'package:flutter/material.dart';

class TodaysActivitySection extends StatelessWidget {
  const TodaysActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());

    // Filter bookings for today's check-ins and check-outs
    final checkInsToday = dummyBookings
        .where((b) => DateUtils.isSameDay(b.checkInDate, today))
        .toList();
    final checkOutsToday = dummyBookings
        .where((b) => DateUtils.isSameDay(b.checkOutDate, today))
        .toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Activity",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildActivityList("Check-Ins", checkInsToday, Colors.green),
            const Divider(height: 32),
            _buildActivityList("Check-Outs", checkOutsToday, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList(
    String title,
    List<Booking> bookings,
    Color indicatorColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title (${bookings.length})",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: indicatorColor,
          ),
        ),
        const SizedBox(height: 8),
        if (bookings.isEmpty)
          const Text(
            "No activity for today.",
            style: TextStyle(color: Colors.grey),
          )
        else
          ...bookings
              .map(
                (b) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person),
                  title: Text(b.guestName),
                  subtitle: Text("Room ${b.roomNumber}"),
                ),
              )
              .toList(),
      ],
    );
  }
}
