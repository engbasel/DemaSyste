// Model to represent a room's data
enum RoomStatus { available, occupied, needsCleaning }

class Room {
  final String imageUrl;
  final String roomNumber;
  final String roomType;
  final RoomStatus status;

  Room({
    required this.imageUrl,
    required this.roomNumber,
    required this.roomType,
    required this.status,
  });
}
