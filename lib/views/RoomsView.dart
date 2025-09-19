import 'package:dema/views/RoomCard.dart';
import 'package:dema/views/Room_model.dart';
import 'package:flutter/material.dart';

// Main View Widget
class RoomsView extends StatelessWidget {
  const RoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data - replace with your actual data from an API
    final List<Room> rooms = [
      Room(
        imageUrl:
            'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Room 101',
        roomType: 'Standard Room',
        status: RoomStatus.available,
      ),
      Room(
        imageUrl:
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Room 102',
        roomType: 'Deluxe Room',
        status: RoomStatus.occupied,
      ),
      Room(
        imageUrl:
            'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Room 103',
        roomType: 'Suite',
        status: RoomStatus.needsCleaning,
      ),
      Room(
        imageUrl:
            'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Room 104',
        roomType: 'Standard Room',
        status: RoomStatus.available,
      ),
      Room(
        imageUrl:
            'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Room 105',
        roomType: 'Deluxe Room',
        status: RoomStatus.occupied,
      ),
      Room(
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Room 106',
        roomType: 'Suite',
        status: RoomStatus.needsCleaning,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Background color from design
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildSearchBar(),
            const SizedBox(height: 24),
            const Text(
              'Rooms',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            _buildRoomsGrid(rooms),
          ],
        ),
      ),
    );
  }

  // Header Widget: Title and Add Room Button
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Rooms',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Add room logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Add Room'),
        ),
      ],
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Color(0xFF94A3B8)),
          hintText: 'Search by room number',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color(0xFF94A3B8)),
        ),
      ),
    );
  }

  // Rooms Grid Widget
  Widget _buildRoomsGrid(List<Room> rooms) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: rooms.map((room) => RoomCard(room: room)).toList(),
    );
  }
}
