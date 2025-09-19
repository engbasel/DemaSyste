import 'package:flutter/material.dart';
import 'package:dema/views/Room_model.dart';

class RoomDetailsView extends StatelessWidget {
  final RoomModel room;

  const RoomDetailsView({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for ${room.roomNumber}'),
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        foregroundColor: const Color(0xFF1E293B),
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              room.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 250,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.roomNumber,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${room.roomType} • ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      // We need the status chip here as well
                      _RoomStatusChip(status: room.status),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildDetailRow('Owner', room.ownerName),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Rent',
                    '${room.rentAmount.toStringAsFixed(2)} EGP / month',
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow('Maintenance Notes', room.maintenanceNotes),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}

// NOTE: This widget is copied from rooms_view.dart for use in the details screen.
// For a larger app, it's better to move shared widgets to their own files.
class _RoomStatusChip extends StatelessWidget {
  final RoomStatus status;
  const _RoomStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;
    switch (status) {
      case RoomStatus.available:
        text = 'Available';
        color = const Color(0xFF10B981);
        break;
      case RoomStatus.occupied:
        text = 'Occupied';
        color = const Color(0xFFEF4444);
        break;
      case RoomStatus.needsCleaning:
        text = 'Needs Cleaning';
        color = const Color(0xFFF59E0B);
        break;
    }
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12),
    );
  }
}
