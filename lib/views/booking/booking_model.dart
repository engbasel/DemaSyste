// Enums for clarity and type safety
import 'package:dema/views/Rooms/Room_model.dart';

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

// // Dummy data for demonstration
// final List<Booking> dummyBookings = [
//   Booking(
//     guestName: "Lucas Bennett",
//     guestPhone: "010-1111-2222",
//     guestEmail: "lucas.b@example.com",
//     roomNumber: "101",
//     roomType: "Deluxe Suite",
//     checkInDate: DateTime(2025, 7, 15),
//     checkOutDate: DateTime(2025, 7, 20),
//     bookingType: BookingType.online,
//     totalPrice: 7500.0,
//     amountPaid: 7500.0,
//     paymentMethod: PaymentMethod.card,
//     status: BookingStatus.booked,
//   ),
//   Booking(
//     guestName: "Sophia Carter",
//     guestPhone: "011-2222-3333",
//     guestEmail: "sophia.c@example.com",
//     roomNumber: "205",
//     roomType: "Standard Room",
//     checkInDate: DateTime(2025, 7, 16),
//     checkOutDate: DateTime(2025, 7, 18),
//     bookingType: BookingType.walkIn,
//     totalPrice: 2400.0,
//     amountPaid: 1000.0,
//     paymentMethod: PaymentMethod.cash,
//     status: BookingStatus.checkedIn,
//   ),
//   Booking(
//     guestName: "Owen Harper",
//     guestPhone: "012-3333-4444",
//     guestEmail: "owen.h@example.com",
//     roomNumber: "302",
//     roomType: "Family Room",
//     checkInDate: DateTime(2025, 7, 17),
//     checkOutDate: DateTime(2025, 7, 22),
//     bookingType: BookingType.online,
//     totalPrice: 9000.0,
//     amountPaid: 0.0,
//     paymentMethod: PaymentMethod.transfer,
//     status: BookingStatus.pending,
//   ),
//   Booking(
//     guestName: "Isabella Foster",
//     guestPhone: "015-4444-5555",
//     guestEmail: "isabella.f@example.com",
//     roomNumber: "401",
//     roomType: "Executive Suite",
//     checkInDate: DateTime(2025, 7, 18),
//     checkOutDate: DateTime(2025, 7, 25),
//     bookingType: BookingType.corporate,
//     totalPrice: 15000.0,
//     amountPaid: 15000.0,
//     paymentMethod: PaymentMethod.transfer,
//     status: BookingStatus.checkedOut,
//   ),
//   Booking(
//     guestName: "Jackson Walker",
//     guestPhone: "010-5555-6666",
//     guestEmail: "jackson.w@example.com",
//     roomNumber: "206",
//     roomType: "Standard Room",
//     checkInDate: DateTime(2025, 7, 19),
//     checkOutDate: DateTime(2025, 7, 21),
//     bookingType: BookingType.online,
//     totalPrice: 2600.0,
//     amountPaid: 0.0,
//     paymentMethod: PaymentMethod.card,
//     status: BookingStatus.noShow,
//   ),
// ];
// Dummy data for demonstration (Arabic / Saudi Client)
final List<Booking> dummyBookings = [
  Booking(
    guestName: "عبدالله الشمري",
    guestPhone: "055-111-2222",
    guestEmail: "abdullah.sh@hotel.sa",
    roomNumber: "101",
    roomType: "جناح ديلوكس",
    checkInDate: DateTime(2025, 7, 15),
    checkOutDate: DateTime(2025, 7, 20),
    bookingType: BookingType.online,
    totalPrice: 7500.0,
    amountPaid: 7500.0,
    paymentMethod: PaymentMethod.card,
    status: BookingStatus.booked,
  ),
  Booking(
    guestName: "سارة القحطاني",
    guestPhone: "056-222-3333",
    guestEmail: "sara.q@hotel.sa",
    roomNumber: "205",
    roomType: "غرفة قياسية",
    checkInDate: DateTime(2025, 7, 16),
    checkOutDate: DateTime(2025, 7, 18),
    bookingType: BookingType.walkIn,
    totalPrice: 2400.0,
    amountPaid: 1000.0,
    paymentMethod: PaymentMethod.cash,
    status: BookingStatus.checkedIn,
  ),
  Booking(
    guestName: "فيصل الحربي",
    guestPhone: "057-333-4444",
    guestEmail: "faisal.h@hotel.sa",
    roomNumber: "302",
    roomType: "غرفة عائلية",
    checkInDate: DateTime(2025, 7, 17),
    checkOutDate: DateTime(2025, 7, 22),
    bookingType: BookingType.online,
    totalPrice: 9000.0,
    amountPaid: 0.0,
    paymentMethod: PaymentMethod.transfer,
    status: BookingStatus.pending,
  ),
  Booking(
    guestName: "نورة السبيعي",
    guestPhone: "058-444-5555",
    guestEmail: "nora.s@hotel.sa",
    roomNumber: "401",
    roomType: "جناح تنفيذي",
    checkInDate: DateTime(2025, 7, 18),
    checkOutDate: DateTime(2025, 7, 25),
    bookingType: BookingType.corporate,
    totalPrice: 15000.0,
    amountPaid: 15000.0,
    paymentMethod: PaymentMethod.transfer,
    status: BookingStatus.checkedOut,
  ),
  Booking(
    guestName: "محمد الدوسري",
    guestPhone: "059-555-6666",
    guestEmail: "mohammed.d@hotel.sa",
    roomNumber: "206",
    roomType: "غرفة قياسية",
    checkInDate: DateTime(2025, 7, 19),
    checkOutDate: DateTime(2025, 7, 21),
    bookingType: BookingType.online,
    totalPrice: 2600.0,
    amountPaid: 0.0,
    paymentMethod: PaymentMethod.card,
    status: BookingStatus.noShow,
  ),
];

// // Dummy data
// final List<RoomModel> rooms = [
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 101',
//     roomType: 'Standard Apartment',
//     status: RoomStatus.available,
//     ownerName: 'Youssef El-Masry',
//     rentAmount: 4500.00,
//     maintenanceNotes: 'AC filter needs cleaning next month.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 102',
//     roomType: 'Deluxe Apartment',
//     status: RoomStatus.occupied,
//     ownerName: 'Fatima Al-Sayed',
//     rentAmount: 6200.00,
//     maintenanceNotes: 'Tenant reported a minor leak in the kitchen sink.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 103',
//     roomType: 'Studio',
//     status: RoomStatus.needsCleaning,
//     ownerName: 'Ali Hassan',
//     rentAmount: 3800.00,
//     maintenanceNotes:
//         'Full cleaning and paint touch-up required before new tenant moves in.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 104',
//     roomType: 'Standard Apartment',
//     status: RoomStatus.available,
//     ownerName: 'Mona Ibrahim',
//     rentAmount: 4700.00,
//     maintenanceNotes: 'No issues reported.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 105',
//     roomType: 'Deluxe Apartment',
//     status: RoomStatus.occupied,
//     ownerName: 'Khaled Amer',
//     rentAmount: 6500.00,
//     maintenanceNotes: 'Check balcony door lock.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 106',
//     roomType: 'Studio',
//     status: RoomStatus.available,
//     ownerName: 'Sara Gad',
//     rentAmount: 3500.00,
//     maintenanceNotes: 'Freshly painted, ready for tenant.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 107',
//     roomType: 'Standard Apartment',
//     status: RoomStatus.needsCleaning,
//     ownerName: 'Omar Saleh',
//     rentAmount: 4200.00,
//     maintenanceNotes: 'Deep cleaning required after move-out.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1502672023488-70e25813eb80?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 108',
//     roomType: 'Deluxe Apartment',
//     status: RoomStatus.available,
//     ownerName: 'Nour Hassan',
//     rentAmount: 7000.00,
//     maintenanceNotes: 'All appliances tested and working.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 109',
//     roomType: 'Studio',
//     status: RoomStatus.occupied,
//     ownerName: 'Mohamed Tarek',
//     rentAmount: 3900.00,
//     maintenanceNotes: 'Tenant requested AC service.',
//   ),
//   RoomModel(
//     imageUrl:
//         'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1170&q=80',
//     roomNumber: 'Unit 110',
//     roomType: 'Standard Apartment',
//     status: RoomStatus.needsCleaning,
//     ownerName: 'Layla Said',
//     rentAmount: 4800.00,
//     maintenanceNotes: 'Walls need repainting.',
//   ),
// ];
// بيانات تجريبية (معربة)
final List<RoomModel> rooms = [
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 101',
    roomType: 'شقة عادية',
    status: RoomStatus.available,
    ownerName: 'عبدالله العتيبي',
    rentAmount: 4500.00,
    maintenanceNotes: 'فلتر المكيف يحتاج تنظيف الشهر القادم.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 102',
    roomType: 'شقة فاخرة',
    status: RoomStatus.occupied,
    ownerName: 'فاطمة الشهري',
    rentAmount: 6200.00,
    maintenanceNotes: 'المستأجر أبلغ عن تسريب بسيط في حوض المطبخ.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 103',
    roomType: 'استوديو',
    status: RoomStatus.needsCleaning,
    ownerName: 'علي القحطاني',
    rentAmount: 3800.00,
    maintenanceNotes: 'تحتاج تنظيف كامل مع ترميم بسيط قبل المستأجر الجديد.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 104',
    roomType: 'شقة عادية',
    status: RoomStatus.available,
    ownerName: 'منى الدوسري',
    rentAmount: 4700.00,
    maintenanceNotes: 'لا توجد ملاحظات.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 105',
    roomType: 'شقة فاخرة',
    status: RoomStatus.occupied,
    ownerName: 'خالد السبيعي',
    rentAmount: 6500.00,
    maintenanceNotes: 'يجب فحص قفل باب البلكونة.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 106',
    roomType: 'استوديو',
    status: RoomStatus.available,
    ownerName: 'سارة القاضي',
    rentAmount: 3500.00,
    maintenanceNotes: 'الشقة مطلية حديثاً وجاهزة للتأجير.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 107',
    roomType: 'شقة عادية',
    status: RoomStatus.needsCleaning,
    ownerName: 'عمر الغامدي',
    rentAmount: 4200.00,
    maintenanceNotes: 'تحتاج تنظيف عميق بعد خروج المستأجر السابق.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1502672023488-70e25813eb80?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 108',
    roomType: 'شقة فاخرة',
    status: RoomStatus.available,
    ownerName: 'نورة الحربي',
    rentAmount: 7000.00,
    maintenanceNotes: 'تم فحص جميع الأجهزة وتعمل بشكل ممتاز.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 109',
    roomType: 'استوديو',
    status: RoomStatus.occupied,
    ownerName: 'محمد التميمي',
    rentAmount: 3900.00,
    maintenanceNotes: 'المستأجر طلب صيانة للمكيف.',
  ),
  RoomModel(
    imageUrl:
        'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1170&q=80',
    roomNumber: 'شقة 110',
    roomType: 'شقة عادية',
    status: RoomStatus.needsCleaning,
    ownerName: 'ليلى السالم',
    rentAmount: 4800.00,
    maintenanceNotes: 'الجدران تحتاج إعادة طلاء.',
  ),
];


// لما العميل يمشي حضرتك هتبعت لة لينك يضيف راية في الاقامة وكل التفاصيل بحيث حضرتك تاخد راية ويوصلك في السيستم لو في اي تعديلات او اقتراحات من العملاء 
// خدمة ما بعد البيع اهم شي في في التجارة