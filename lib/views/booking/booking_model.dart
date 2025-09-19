
// Enums for clarity and type safety
enum BookingStatus { booked, checkedIn, checkedOut, pending, noShow }

enum BookingType { online, walkIn, corporate }

enum PaymentMethod { cash, card, transfer }

class Booking {
  // Guest Information
  final String guestName;
  final String guestPhone;
  final String guestEmail;

  // Booking Details
  final String roomNumber;
  final String roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfGuests;
  final BookingType bookingType;

  // Financials
  final double totalPrice;
  final double amountPaid;
  final PaymentMethod paymentMethod;

  // Status
  final BookingStatus status;

  // Attachments (e.g., file paths or URLs)
  final List<String> attachments;

  Booking({
    required this.guestName,
    required this.guestPhone,
    required this.guestEmail,
    required this.roomNumber,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
    this.numberOfGuests = 1,
    required this.bookingType,
    required this.totalPrice,
    this.amountPaid = 0.0,
    required this.paymentMethod,
    required this.status,
    this.attachments = const [],
  });

  // Calculated property for nights
  int get nights => checkOutDate.difference(checkInDate).inDays;

  // Calculated property for payment status
  double get remainingBalance => totalPrice - amountPaid;
}

// Dummy data for demonstration
final List<Booking> dummyBookings = [
  Booking(
    guestName: "Lucas Bennett",
    guestPhone: "010-1111-2222",
    guestEmail: "lucas.b@example.com",
    roomNumber: "101",
    roomType: "Deluxe Suite",
    checkInDate: DateTime(2025, 7, 15),
    checkOutDate: DateTime(2025, 7, 20),
    bookingType: BookingType.online,
    totalPrice: 7500.0,
    amountPaid: 7500.0,
    paymentMethod: PaymentMethod.card,
    status: BookingStatus.booked,
  ),
  Booking(
    guestName: "Sophia Carter",
    guestPhone: "011-2222-3333",
    guestEmail: "sophia.c@example.com",
    roomNumber: "205",
    roomType: "Standard Room",
    checkInDate: DateTime(2025, 7, 16),
    checkOutDate: DateTime(2025, 7, 18),
    bookingType: BookingType.walkIn,
    totalPrice: 2400.0,
    amountPaid: 1000.0,
    paymentMethod: PaymentMethod.cash,
    status: BookingStatus.checkedIn,
  ),
  Booking(
    guestName: "Owen Harper",
    guestPhone: "012-3333-4444",
    guestEmail: "owen.h@example.com",
    roomNumber: "302",
    roomType: "Family Room",
    checkInDate: DateTime(2025, 7, 17),
    checkOutDate: DateTime(2025, 7, 22),
    bookingType: BookingType.online,
    totalPrice: 9000.0,
    amountPaid: 0.0,
    paymentMethod: PaymentMethod.transfer,
    status: BookingStatus.pending,
  ),
  Booking(
    guestName: "Isabella Foster",
    guestPhone: "015-4444-5555",
    guestEmail: "isabella.f@example.com",
    roomNumber: "401",
    roomType: "Executive Suite",
    checkInDate: DateTime(2025, 7, 18),
    checkOutDate: DateTime(2025, 7, 25),
    bookingType: BookingType.corporate,
    totalPrice: 15000.0,
    amountPaid: 15000.0,
    paymentMethod: PaymentMethod.transfer,
    status: BookingStatus.checkedOut,
  ),
  Booking(
    guestName: "Jackson Walker",
    guestPhone: "010-5555-6666",
    guestEmail: "jackson.w@example.com",
    roomNumber: "206",
    roomType: "Standard Room",
    checkInDate: DateTime(2025, 7, 19),
    checkOutDate: DateTime(2025, 7, 21),
    bookingType: BookingType.online,
    totalPrice: 2600.0,
    amountPaid: 0.0,
    paymentMethod: PaymentMethod.card,
    status: BookingStatus.noShow,
  ),
];
