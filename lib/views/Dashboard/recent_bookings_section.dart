// import 'package:dema/views/booking/booking_model.dart';
// import 'package:flutter/material.dart';

// class RecentBookingsSection extends StatelessWidget {
//   const RecentBookingsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "Recent Bookings",
//               style: Theme.of(
//                 context,
//               ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: DataTable(
//               columns: const [
//                 DataColumn(label: Text('Guest Name')),
//                 DataColumn(label: Text('Room')),
//                 DataColumn(label: Text('Status')),
//               ],
//               rows: dummyBookings.take(5).map((b) {
//                 return DataRow(
//                   cells: [
//                     DataCell(Text(b.guestName)),
//                     DataCell(Text(b.roomNumber)),
//                     DataCell(_buildStatusChip(b.status)),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusChip(BookingStatus status) {
//     final statusMap = {
//       BookingStatus.booked: {'color': Colors.blue, 'text': 'Booked'},
//       BookingStatus.checkedIn: {'color': Colors.green, 'text': 'Checked-In'},
//       BookingStatus.pending: {'color': Colors.orange, 'text': 'Pending'},
//       BookingStatus.checkedOut: {'color': Colors.grey, 'text': 'Checked-Out'},
//       BookingStatus.noShow: {'color': Colors.red, 'text': 'No-Show'},
//     };
//     final color = statusMap[status]!['color'] as Color;
//     final text = statusMap[status]!['text'] as String;

//     return Chip(
//       label: Text(text, style: TextStyle(color: color, fontSize: 12)),
//       backgroundColor: color.withOpacity(0.1),
//       side: BorderSide.none,
//       padding: EdgeInsets.zero,
//     );
//   }
// }

import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    // For responsive grid
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 1200) crossAxisCount = 2;
        if (constraints.maxWidth < 600) crossAxisCount = 1;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
          children: const [
            _OverviewCard(
              title: 'الحجوزات',
              value: '250',
              icon: Icons.book_online,
              color: Colors.blue,
              change: '+10%',
            ),
            _OverviewCard(
              title: 'الإيرادات',
              value: '\$15,000',
              icon: Icons.monetization_on,
              color: Colors.green,
              change: '+5%',
            ),
            _OverviewCard(
              title: 'الإحصائيات',
              value: '75%',
              icon: Icons.hotel,
              color: Colors.orange,
              change: '-2%',
              isNegative: true,
            ),
            _OverviewCard(
              title: ' الغرف المتاحة',
              value: '12',
              icon: Icons.meeting_room,
              color: Colors.purple,
              change: '+1',
            ),
          ],
        );
      },
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;
  final bool isNegative;

  const _OverviewCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
    this.isNegative = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        change,
                        style: TextStyle(
                          color: isNegative ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
