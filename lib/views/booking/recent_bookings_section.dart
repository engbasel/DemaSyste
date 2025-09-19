// ويدجت قسم الحجوزات الأخيرة
import 'package:dema/views/booking/booking_model.dart';
import 'package:dema/views/Rooms/status_chip.dart';
import 'package:flutter/material.dart';

class RecentBookingsSection extends StatelessWidget {
  const RecentBookingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الحجوزات الأخيرة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DataTable(
            columnSpacing: 20,
            headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
            columns: const [
              DataColumn(label: Text('الاسم')),
              DataColumn(label: Text('غرفة')),
              DataColumn(label: Text('تاريخ الدخول')),
              DataColumn(label: Text('تاريخ الخروج')),
              DataColumn(label: Text('الحالة')),
            ],
            rows: dummyBookings.map((booking) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      booking.guestName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      booking.roomNumber,
                      style: const TextStyle(color: Color(0xFF64748B)),
                    ),
                  ),
                  DataCell(
                    Text(
                      booking.checkInDate.toString(),
                      style: const TextStyle(color: Color(0xFF64748B)),
                    ),
                  ),
                  DataCell(
                    Text(
                      booking.checkOutDate.toString(),
                      style: const TextStyle(color: Color(0xFF64748B)),
                    ),
                  ),
                  DataCell(StatusChip(status: booking.status)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
