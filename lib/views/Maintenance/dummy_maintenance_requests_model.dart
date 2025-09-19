// Enum لتحديد حالة طلب الصيانة
enum MaintenanceStatus {
  New, // جديد
  InProgress, // قيد التنفيذ
  Completed, // مكتمل
  Cancelled, // ملغي
}

// Enum لتحديد أولوية الطلب
enum MaintenancePriority {
  Low, // منخفضة
  Medium, // متوسطة
  High, // عالية
}

class MaintenanceRequestModel {
  final String id;
  final String title;
  final String description;
  final MaintenanceStatus status;
  final MaintenancePriority priority;
  final DateTime reportedDate;
  final String roomNumber;
  final String roomType;
  final String guestName;
  final String? assignedTechnician;
  final double? cost;

  MaintenanceRequestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.reportedDate,
    required this.roomNumber,
    required this.roomType,
    required this.guestName,
    this.assignedTechnician,
    this.cost,
  });
}

// --- بيانات وهمية واقعية ---
// مرتبطة ببيانات المستأجرين في booking_model.dart
final List<MaintenanceRequestModel> dummyMaintenanceRequests = [
  MaintenanceRequestModel(
    id: 'MNT-001',
    title: 'تسريب في صنبور المطبخ',
    description:
        'يوجد تسريب مستمر من صنبور المياه الساخنة في المطبخ، مما يؤدي إلى إهدار المياه.',
    status: MaintenanceStatus.New,
    priority: MaintenancePriority.High,
    reportedDate: DateTime(2025, 9, 18),
    roomNumber: '101',
    roomType: 'جناح ديلوكس',
    guestName: 'عبدالله الشمري',
  ),
  MaintenanceRequestModel(
    id: 'MNT-002',
    title: 'تكييف الهواء لا يبرد',
    description:
        'وحدة التكييف في غرفة المعيشة تعمل ولكنها لا تخرج هواءً باردًا.',
    status: MaintenanceStatus.InProgress,
    priority: MaintenancePriority.High,
    reportedDate: DateTime(2025, 9, 17),
    roomNumber: '205',
    roomType: 'غرفة قياسية',
    guestName: 'سارة القحطاني',
    assignedTechnician: 'أحمد المصري',
  ),
  MaintenanceRequestModel(
    id: 'MNT-003',
    title: 'لمبة الحمام محترقة',
    description: 'اللمبة الرئيسية في الحمام تحتاج إلى تغيير.',
    status: MaintenanceStatus.Completed,
    priority: MaintenancePriority.Low,
    reportedDate: DateTime(2025, 9, 15),
    roomNumber: '302',
    roomType: 'غرفة عائلية',
    guestName: 'فيصل الحربي',
    assignedTechnician: 'شركة النور للكهرباء',
    cost: 50.0,
  ),
  MaintenanceRequestModel(
    id: 'MNT-004',
    title: 'باب الخزانة لا يغلق جيدًا',
    description: 'باب خزانة الملابس في غرفة النوم الرئيسية لا يغلق بشكل صحيح.',
    status: MaintenanceStatus.New,
    priority: MaintenancePriority.Medium,
    reportedDate: DateTime(2025, 9, 19),
    roomNumber: '401',
    roomType: 'جناح تنفيذي',
    guestName: 'نورة السبيعي',
  ),
  MaintenanceRequestModel(
    id: 'MNT-005',
    title: 'إصلاح زجاج النافذة',
    description:
        'تم الإبلاغ عن شرخ في زجاج نافذة غرفة النوم وتم إلغاء الطلب من قبل المستأجر.',
    status: MaintenanceStatus.Cancelled,
    priority: MaintenancePriority.Medium,
    reportedDate: DateTime(2025, 9, 16),
    roomNumber: '206',
    roomType: 'غرفة قياسية',
    guestName: 'محمد الأحمدي',
  ),
];
