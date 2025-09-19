// // Model for booking data

// class Booking {
//   final String guestName;
//   final String roomType;
//   final String checkIn;
//   final String checkOut;
//   final BookingStatus status;

//   Booking({
//     required this.guestName,
//     required this.roomType,
//     required this.checkIn,
//     required this.checkOut,
//     required this.status,
//   });
// }

// enum BookingStatus { booked, checkedIn, pending, checkedOut, noShow }

// Model for booking data
class Booking {
  final String guestName;
  final String roomNumber;
  final String checkIn;
  final String checkOut;
  final BookingStatus status;

  Booking({
    required this.guestName,
    required this.roomNumber,
    required this.checkIn,
    required this.checkOut,
    required this.status,
  });
}

enum BookingStatus { booked, checkedIn, pending, checkedOut, noShow }

// Dummy bookings list
final List<Booking> dummyBookings = [
  Booking(
    guestName: "Clara Bennett",
    roomNumber: "101",
    checkIn: "2024-07-15",
    checkOut: "2024-07-20",
    status: BookingStatus.booked,
  ),
  Booking(
    guestName: "Owen Hughes",
    roomNumber: "203",
    checkIn: "2024-07-16",
    checkOut: "2024-07-19",
    status: BookingStatus.checkedIn,
  ),
  Booking(
    guestName: "Emily Carter",
    roomNumber: "305",
    checkIn: "2024-07-17",
    checkOut: "2024-07-22",
    status: BookingStatus.pending,
  ),
  Booking(
    guestName: "Noah Foster",
    roomNumber: "102",
    checkIn: "2024-07-18",
    checkOut: "2024-07-21",
    status: BookingStatus.checkedOut,
  ),
  Booking(
    guestName: "Ava Harper",
    roomNumber: "204",
    checkIn: "2024-07-19",
    checkOut: "2024-07-23",
    status: BookingStatus.noShow,
  ),
];
