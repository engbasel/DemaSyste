class Owner {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String imageUrl;
  final List<String> ownedUnitNumbers; // قائمة بأرقام الوحدات التي يمتلكها

  // Financial Summary (can be calculated)
  final int totalProperties;
  final double totalMonthlyRent;
  final double occupancyRate; // e.g., 0.8 for 80%

  Owner({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.ownedUnitNumbers,
    required this.totalProperties,
    required this.totalMonthlyRent,
    required this.occupancyRate,
  });
}

// --- Dummy Data ---
// بيانات وهمية واقعية للملاك
final List<Owner> dummyOwners = [
  Owner(
    id: 'OWN-001',
    name: 'خالد الراجحي',
    phone: '055-999-8888',
    email: 'k.alrajhi@domain.com',
    imageUrl: 'https://placehold.co/100x100/E2E8F0/475569?text=KR',
    ownedUnitNumbers: ['101', '102', '103'],
    totalProperties: 3,
    totalMonthlyRent: 24500.0,
    occupancyRate: 1.0, // 100%
  ),
  Owner(
    id: 'OWN-002',
    name: 'فاطمة العتيبي',
    phone: '050-777-6666',
    email: 'f.alotaibi@domain.com',
    imageUrl: 'https://placehold.co/100x100/E2E8F0/475569?text=FA',
    ownedUnitNumbers: ['205', '206', '302', '401'],
    totalProperties: 4,
    totalMonthlyRent: 28800.0,
    occupancyRate: 0.75, // 75%
  ),
  Owner(
    id: 'OWN-003',
    name: 'سلطان الشهراني',
    phone: '053-555-4444',
    email: 's.shahrani@domain.com',
    imageUrl: 'https://placehold.co/100x100/E2E8F0/475569?text=SS',
    ownedUnitNumbers: ['501', '502'],
    totalProperties: 2,
    totalMonthlyRent: 18000.0,
    occupancyRate: 0.5, // 50%
  ),
];
