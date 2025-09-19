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
