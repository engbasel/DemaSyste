// Enum to define the status of a resident's contract
enum ResidentStatus {
  Active, // العقد ساري
  Inactive, // العقد منتهي
}

class Resident {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String nationalId;
  final String imageUrl;
  final ResidentStatus status;

  // Rental Info
  final String unitNumber;
  final DateTime contractStartDate;
  final DateTime contractEndDate;
  final double rentAmount;

  // Attachments (file names or URLs)
  final List<String> attachments;

  Resident({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.nationalId,
    required this.imageUrl,
    required this.status,
    required this.unitNumber,
    required this.contractStartDate,
    required this.contractEndDate,
    required this.rentAmount,
    this.attachments = const [],
  });
}

// --- Dummy Data ---
// بيانات وهمية واقعية مرتبطة بالحجوزات والوحدات السابقة
final List<Resident> dummyResidents = [
  Resident(
    id: 'RES-001',
    name: 'عبدالله الشمري',
    phone: '055-111-2222',
    email: 'abdullah.sh@hotel.sa',
    nationalId: '1012345678',
    imageUrl: 'https://placehold.co/100x100/E2E8F0/475569?text=AS',
    status: ResidentStatus.Active,
    unitNumber: '101',
    contractStartDate: DateTime(2025, 7, 15),
    contractEndDate: DateTime(2026, 7, 14),
    rentAmount: 7500.0,
    attachments: ['contract_AS.pdf', 'id_AS.jpg'],
  ),
  Resident(
    id: 'RES-002',
    name: 'سارة القحطاني',
    phone: '050-222-3333',
    email: 'sara.q@hotel.sa',
    nationalId: '1087654321',
    imageUrl: 'https://placehold.co/100x100/E2E8F0/475569?text=SQ',
    status: ResidentStatus.Active,
    unitNumber: '205',
    contractStartDate: DateTime(2025, 7, 16),
    contractEndDate: DateTime(2026, 1, 15),
    rentAmount: 2400.0,
    attachments: ['contract_SQ.pdf'],
  ),
  Resident(
    id: 'RES-003',
    name: 'فيصل الحربي',
    phone: '053-444-5555',
    email: 'faisal.h@hotel.sa',
    nationalId: '1098765432',
    imageUrl: 'https://placehold.co/100x100/E2E8F0/475569?text=FH',
    status: ResidentStatus.Active,
    unitNumber: '302',
    contractStartDate: DateTime(2025, 7, 17),
    contractEndDate: DateTime(2025, 10, 16),
    rentAmount: 9000.0,
  ),
  Resident(
    id: 'RES-004',
    name: 'نورة السبيعي',
    phone: '054-555-6666',
    email: 'noura.s@hotel.sa',
    nationalId: '1023456789',
    imageUrl: 'https://placehold.co/100x100/E2E8F0/475569?text=NS',
    status: ResidentStatus.Inactive, // Example of an inactive resident
    unitNumber: '401',
    contractStartDate: DateTime(2024, 7, 18),
    contractEndDate: DateTime(2025, 7, 17),
    rentAmount: 15000.0,
    attachments: ['contract_NS.pdf'],
  ),
];
