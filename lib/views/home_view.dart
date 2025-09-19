import 'package:dema/views/DashboardContent.dart';
import 'package:dema/views/SideNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Main function to run the app
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // For responsive layout, we can use LayoutBuilder
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            // Mobile layout with a Drawer
            return const DashboardContent(); // Simplified for mobile for now
          } else {
            // Desktop/Tablet layout
            return Row(
              children: const [
                SideNavigationBar(),
                Expanded(child: DashboardContent()),
              ],
            );
          }
        },
      ),
    );
  }
}

// Model for booking data
class Booking {
  final String guestName;
  final String roomType;
  final String checkIn;
  final String checkOut;
  final BookingStatus status;

  Booking({
    required this.guestName,
    required this.roomType,
    required this.checkIn,
    required this.checkOut,
    required this.status,
  });
}

enum BookingStatus { booked, checkedIn, pending, checkedOut, noShow }

// ويدجت لعرض حالة الحجز كشارة ملونة
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
