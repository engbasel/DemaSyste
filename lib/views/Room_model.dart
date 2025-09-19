// Model to represent a room's data with added details
enum RoomStatus { available, occupied, needsCleaning }

class RoomModel {
  final String imageUrl;
  final String roomNumber;
  final String roomType;
  final RoomStatus status;
  // New fields for property details
  final String ownerName;
  final double rentAmount;
  final String maintenanceNotes;

  RoomModel({
    required this.imageUrl,
    required this.roomNumber,
    required this.roomType,
    required this.status,
    required this.ownerName,
    required this.rentAmount,
    required this.maintenanceNotes,
  });
}
