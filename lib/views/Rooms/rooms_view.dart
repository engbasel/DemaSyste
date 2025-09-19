import 'package:dema/views/Rooms/room_card.dart';
import 'package:dema/views/Rooms/room_details_view.dart';
import 'package:dema/views/Rooms/room_model.dart';
import 'package:dema/views/booking/booking_model.dart';
import 'package:flutter/material.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  // --- ✅ الخطوة 1: تعريف متغيرات الحالة للبحث والفلاتر ---
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String selectedStatus = "All";
  String selectedType = "All";
  // --- نهاية الخطوة 1 ---

  // ✅ متغير جديد للاحتفاظ بالنتائج المفلترة
  List<RoomModel> _filteredRooms = [];

  @override
  void initState() {
    super.initState();
    // ✅ الاستماع للتغييرات في حقل البحث وتطبيق الفلتر تلقائيًا
    _searchController.addListener(() {
      _searchQuery = _searchController.text;
      _applyFilters();
    });
    // ✅ تطبيق الفلاتر عند بدء تشغيل الشاشة لأول مرة
    _applyFilters();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ✅ --- الخطوة 2: دالة مركزية لتطبيق جميع الفلاتر ---
  void _applyFilters() {
    setState(() {
      _filteredRooms = rooms.where((room) {
        // فلتر الحالة
        final statusMatch =
            selectedStatus == "All" ||
            room.status.name.toLowerCase() == selectedStatus.toLowerCase();
        // فلتر النوع
        final typeMatch =
            selectedType == "All" || room.roomType.contains(selectedType);
        // ✅ فلتر البحث برقم الوحدة (الجزء المضاف)
        final searchMatch =
            _searchQuery.isEmpty ||
            room.roomNumber.toLowerCase().contains(_searchQuery.toLowerCase());

        return statusMatch && typeMatch && searchMatch;
      }).toList();
    });
  }
  // --- نهاية الخطوة 2 ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            buildCounters(_filteredRooms),
            const SizedBox(height: 24),
            // ✅ تم تحديث هذه الويدجت لتستخدم الـ Controller
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterBar(),
            const SizedBox(height: 24),
            const Text(
              'الوحدات العقارية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            // ✅ الشبكة الآن تعرض البيانات المفلترة من متغير الحالة
            _buildRoomsGrid(_filteredRooms),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'الوحدات العقارية',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('إضافة وحدة'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // ✅ --- الخطوة 3: تحديث ويدجت البحث لربطها بالـ Controller ---
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController, // الربط هنا
        decoration: const InputDecoration(
          icon: Icon(Icons.search, color: Color(0xFF94A3B8)),
          hintText: 'البحث برقم الوحدة...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color(0xFF94A3B8)),
        ),
      ),
    );
  }
  // --- نهاية الخطوة 3 ---

  Widget _buildRoomsGrid(List<RoomModel> rooms) {
    if (rooms.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text("لا توجد وحدات تطابق معايير البحث."),
        ),
      );
    }
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: rooms.map((room) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailsView(room: room),
            ),
          ),
          borderRadius: BorderRadius.circular(12),
          child: RoomCard(room: room),
        );
      }).toList(),
    );
  }

  Widget _buildFilterBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "الحالة",
                ),
                items: ["All", "Available", "Occupied", "NeedsCleaning"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  selectedStatus = val!;
                  _applyFilters(); // تطبيق الفلاتر عند التغيير
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "النوع",
                ),
                items: ["All", "Studio", "Standard", "Deluxe"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  selectedType = val!;
                  _applyFilters(); // تطبيق الفلاتر عند التغيير
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// باقي الويدجتس المساعدة (buildCounters, RoomCard, etc.) تبقى كما هي
// ...
// ...
Widget buildCounters(List<RoomModel> rooms) {
  int total = rooms.length;
  int available = rooms.where((r) => r.status == RoomStatus.available).length;
  int occupied = rooms.where((r) => r.status == RoomStatus.occupied).length;
  int needsCleaning = rooms
      .where((r) => r.status == RoomStatus.needsCleaning)
      .length;

  Widget counterCard(String title, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              "$count",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  return Row(
    children: [
      counterCard("المجموع", total, Colors.blue),
      counterCard("متاح", available, Colors.green),
      counterCard("مشغول", occupied, Colors.red),
      counterCard("تحتاج تنظيف", needsCleaning, Colors.orange),
    ],
  );
}
