// ويدجت لعرض حالة الحجز كشارة ملونة
import 'package:dema/views/booking_model.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final BookingStatus status;
  const StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    String text;
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case BookingStatus.booked:
        text = 'Booked';
        backgroundColor = const Color(0xFFF1F5F9);
        textColor = const Color(0xFF475569);
        break;
      case BookingStatus.checkedIn:
        text = 'Checked-in';
        backgroundColor = const Color(0xFFECFDF5);
        textColor = const Color(0xFF059669);
        break;
      case BookingStatus.pending:
        text = 'Pending';
        backgroundColor = const Color(0xFFFFFBEB);
        textColor = const Color(0xFFD97706);
        break;
      case BookingStatus.checkedOut:
        text = 'Checked-out';
        backgroundColor = const Color(0xFFEFF6FF);
        textColor = const Color(0xFF2563EB);
        break;
      case BookingStatus.noShow:
        text = 'No-show';
        backgroundColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFDC2626);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
