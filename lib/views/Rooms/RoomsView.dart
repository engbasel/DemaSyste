import 'package:dema/views/Rooms/RoomCard.dart';
import 'package:dema/views/Rooms/RoomDetailsView.dart';
import 'package:dema/views/Rooms/Room_model.dart';
import 'package:dema/views/booking/booking_model.dart';
import 'package:flutter/material.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  String selectedStatus = "All";
  String selectedType = "All";
  double minPrice = 3000;
  double maxPrice = 7000;
  String sortOption = "Default";

  @override
  Widget build(BuildContext context) {
    // Apply filters
    List<RoomModel> filteredRooms = rooms.where((room) {
      bool statusMatch =
          selectedStatus == "All" ||
          room.status.name == selectedStatus.toLowerCase();
      bool typeMatch =
          selectedType == "All" || room.roomType.contains(selectedType);
      bool priceMatch =
          room.rentAmount >= minPrice && room.rentAmount <= maxPrice;
      return statusMatch && typeMatch && priceMatch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildCounters(rooms),
            const SizedBox(height: 24),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterBar(),
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
            _buildRoomsGrid(filteredRooms),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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

  Widget _buildRoomsGrid(List<RoomModel> rooms) {
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
          child: Stack(
            children: [
              RoomCard(room: room),
              Positioned(top: 8, right: 8, child: _statusChip(room.status)),
              Positioned(
                bottom: 8,
                right: 8,
                child: ElevatedButton(
                  onPressed: () {
                    if (room.status == RoomStatus.occupied) {
                      // Collect rent
                    } else if (room.status == RoomStatus.needsCleaning) {
                      // Mark as cleaned
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    room.status == RoomStatus.occupied
                        ? "Collect Rent"
                        : room.status == RoomStatus.needsCleaning
                        ? "Mark Cleaned"
                        : "Action",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _statusChip(RoomStatus status) {
    String text;
    Color color;
    switch (status) {
      case RoomStatus.available:
        text = "Available";
        color = Colors.green;
        break;
      case RoomStatus.occupied:
        text = "Occupied";
        color = Colors.red;
        break;
      case RoomStatus.needsCleaning:
        text = "Needs Cleaning";
        color = Colors.orange;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCounters(List<RoomModel> rooms) {
    int total = rooms.length;
    int available = rooms.where((r) => r.status == RoomStatus.available).length;
    int occupied = rooms.where((r) => r.status == RoomStatus.occupied).length;
    int needsCleaning = rooms
        .where((r) => r.status == RoomStatus.needsCleaning)
        .length;

    Widget _counterCard(String title, int count, Color color) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                "$count",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        _counterCard("Total", total, Colors.blue),
        _counterCard("Available", available, Colors.green),
        _counterCard("Occupied", occupied, Colors.red),
        _counterCard("Needs Cleaning", needsCleaning, Colors.orange),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Status",
                ),
                items: ["All", "Available", "Occupied", "Needs Cleaning"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => selectedStatus = val!),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Type",
                ),
                items: ["All", "Studio", "Standard", "Deluxe"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => selectedType = val!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text("Price Range: ${minPrice.round()} - ${maxPrice.round()} EGP"),
        RangeSlider(
          values: RangeValues(minPrice, maxPrice),
          min: 2000,
          max: 10000,
          divisions: 8,
          onChanged: (RangeValues values) {
            setState(() {
              minPrice = values.start;
              maxPrice = values.end;
            });
          },
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: sortOption,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Sort By",
          ),
          items: [
            "Default",
            "Floor",
            "Price",
            "Status",
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => sortOption = val!),
        ),
      ],
    );
  }
}
