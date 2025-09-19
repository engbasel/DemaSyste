// Widget for the colored status indicator
import 'package:dema/views/Rooms/room_model.dart';
import 'package:flutter/material.dart';

class RoomStatusChip extends StatelessWidget {
  final RoomStatus status;
  const RoomStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;

    switch (status) {
      case RoomStatus.available:
        text = 'متاح';
        color = const Color(0xFF10B981); // Green
        break;
      case RoomStatus.occupied:
        text = 'مشغول';
        color = const Color(0xFFEF4444); // Red
        break;
      case RoomStatus.needsCleaning:
        text = 'يتطلع التنظيف';
        color = const Color(0xFFF59E0B); // Amber
        break;
    }

    return Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12),
    );
  }
}
