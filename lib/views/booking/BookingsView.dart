import 'package:dema/views/booking/booking_model.dart';
import 'package:flutter/material.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Bookings',
          style: TextStyle(color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Add new booking logic
              },
              icon: const Icon(Icons.add),
              label: const Text("New Booking"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search box
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search bookings",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📋 Bookings Table
          Expanded(
            child: ListView(
              children: [
                // Table Header
                Container(
                  color: const Color(0xFFE2E8F0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Guest Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Room",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Check-In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Check-Out",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Status",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Actions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                // Table Rows
                ...dummyBookings.map(
                  (b) => Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(b.guestName)),
                        Expanded(flex: 1, child: Text(b.roomNumber)),
                        Expanded(flex: 2, child: Text(b.checkIn)),
                        Expanded(flex: 2, child: Text(b.checkOut)),
                        Expanded(flex: 1, child: _buildStatusChip(b.status)),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              // TODO: Navigate to booking details
                            },
                            child: const Text("View Details"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎨 Status Chip UI
  Widget _buildStatusChip(BookingStatus status) {
    Color color;
    String text;

    switch (status) {
      case BookingStatus.booked:
        color = Colors.blue;
        text = "Booked";
        break;
      case BookingStatus.checkedIn:
        color = Colors.green;
        text = "Checked-In";
        break;
      case BookingStatus.pending:
        color = Colors.orange;
        text = "Pending";
        break;
      case BookingStatus.checkedOut:
        color = Colors.grey;
        text = "Checked-Out";
        break;
      case BookingStatus.noShow:
        color = Colors.red;
        text = "No-Show";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}
