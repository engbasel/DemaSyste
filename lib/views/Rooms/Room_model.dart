// Model to represent a room's data with added details
enum RoomStatus { available, occupied, needsCleaning }

class RoomModel {
  final String imageUrl;
  final String roomNumber;
  final String roomType;
  final RoomStatus status;

  // 🏠 Property details
  final String ownerName;
  final double rentAmount;
  final String maintenanceNotes;
  final double? area; // مساحة الغرفة (م²)
  final int? floor; // الدور
  final String? lastMaintenance; // تاريخ آخر صيانة

  // 📄 Contract details
  final String? contractStart; // تاريخ بداية العقد
  final String? contractEnd; // تاريخ نهاية العقد

  // 👤 Tenant details
  final String? tenantName;
  final String? tenantPhone;

  RoomModel({
    required this.imageUrl,
    required this.roomNumber,
    required this.roomType,
    required this.status,
    required this.ownerName,
    required this.rentAmount,
    required this.maintenanceNotes,
    this.area,
    this.floor,
    this.lastMaintenance,
    this.contractStart,
    this.contractEnd,
    this.tenantName,
    this.tenantPhone,
  });
}
