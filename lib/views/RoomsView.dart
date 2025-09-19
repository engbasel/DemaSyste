import 'package:dema/views/RoomCard.dart';
import 'package:dema/views/RoomDetailsView.dart';
import 'package:dema/views/Room_model.dart';
import 'package:flutter/material.dart';

// Main View Widget
class RoomsView extends StatelessWidget {
  const RoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data - replace with your actual data from an API
    final List<RoomModel> rooms = [
      RoomModel(
        imageUrl:
            'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Unit 101',
        roomType: 'Standard Apartment',
        status: RoomStatus.available,
        ownerName: 'Youssef El-Masry',
        rentAmount: 4500.00,
        maintenanceNotes: 'AC filter needs cleaning next month.',
      ),
      RoomModel(
        imageUrl:
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Unit 102',
        roomType: 'Deluxe Apartment',
        status: RoomStatus.occupied,
        ownerName: 'Fatima Al-Sayed',
        rentAmount: 6200.00,
        maintenanceNotes: 'Tenant reported a minor leak in the kitchen sink.',
      ),
      RoomModel(
        imageUrl:
            'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Unit 103',
        roomType: 'Studio',
        status: RoomStatus.needsCleaning,
        ownerName: 'Ali Hassan',
        rentAmount: 3800.00,
        maintenanceNotes:
            'Full cleaning and paint touch-up required before new tenant moves in.',
      ),
      RoomModel(
        imageUrl:
            'https://images.unsplash.com/photo-1590490359854-dfba59585b73?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Unit 104',
        roomType: 'Standard Apartment',
        status: RoomStatus.available,
        ownerName: 'Mona Ibrahim',
        rentAmount: 4650.00,
        maintenanceNotes: 'No issues reported.',
      ),
      RoomModel(
        imageUrl:
            'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Unit 105',
        roomType: 'Deluxe Apartment',
        status: RoomStatus.occupied,
        ownerName: 'Khaled Amer',
        rentAmount: 6500.00,
        maintenanceNotes: 'Check balcony door lock.',
      ),
      RoomModel(
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        roomNumber: 'Unit 106',
        roomType: 'Studio',
        status: RoomStatus.needsCleaning,
        ownerName: 'Sara Gad',
        rentAmount: 4000.00,
        maintenanceNotes: 'All clear.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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
              'Properties',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            _buildRoomsGrid(context, rooms),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Properties',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Add Property'),
        ),
      ],
    );
  }

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
          hintText: 'Search by unit number',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color(0xFF94A3B8)),
        ),
      ),
    );
  }

  Widget _buildRoomsGrid(BuildContext context, List<RoomModel> rooms) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: rooms.map((room) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailsView(room: room),
            ),
          ),
          borderRadius: BorderRadius.circular(12),
          child: RoomCard(room: room),
        );
      }).toList(),
    );
  }
}
