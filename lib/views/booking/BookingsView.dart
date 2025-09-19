import 'package:dema/views/booking/BookingDetailsView.dart';
import 'package:dema/views/booking/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  // --- نفس المنطق البرمجي بدون تغيير ---
  late List<Booking> _filteredBookings;
  BookingStatus? _selectedStatus;
  DateTimeRange? _selectedDateRange;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredBookings = List.from(dummyBookings);
    // لفرز الحجوزات من الأحدث للأقدم
    _filteredBookings.sort((a, b) => b.checkInDate.compareTo(a.checkInDate));
  }

  void _applyFilters() {
    setState(() {
      _filteredBookings = dummyBookings.where((booking) {
        final statusMatch =
            _selectedStatus == null || booking.status == _selectedStatus;
        final dateMatch =
            _selectedDateRange == null ||
            (booking.checkInDate.isAfter(
                  _selectedDateRange!.start.subtract(const Duration(days: 1)),
                ) &&
                booking.checkInDate.isBefore(
                  _selectedDateRange!.end.add(const Duration(days: 1)),
                ));
        final searchMatch =
            _searchQuery.isEmpty ||
            booking.guestName.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            booking.roomNumber.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );

        return statusMatch && dateMatch && searchMatch;
      }).toList();
      _filteredBookings.sort((a, b) => b.checkInDate.compareTo(a.checkInDate));
    });
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      initialDateRange: _selectedDateRange,
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
      _applyFilters();
    }
  }

  // --- تم إعادة بناء الواجهة بالكامل من هنا ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // لون الخلفية العام
      appBar: AppBar(
        title: const Text(
          'الحجوزات',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("حجز جديد"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSummaryCards(),
          _buildFilterBar(),
          // ✅ الجزء الأساسي الجديد: الجدول المخصص
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFF1F5F9,
                  ), // خلفية الجدول البنفسجية الفاتحة
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildTableHeader(), // رأس الجدول
                    Expanded(
                      child: _filteredBookings.isEmpty
                          ? const Center(
                              child: Text("لا توجد حجوزات تطابق البحث"),
                            )
                          : ListView.builder(
                              itemCount: _filteredBookings.length,
                              itemBuilder: (context, index) {
                                return _buildTableRow(_filteredBookings[index]);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت بطاقات الملخص (تصميم محدث)
  Widget _buildSummaryCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children:
            [
                  _buildSummaryCard(
                    "المجموع",
                    dummyBookings.length,
                    Colors.blue.shade700,
                  ),
                  _buildSummaryCard(
                    "الدخول",
                    dummyBookings
                        .where((b) => b.status == BookingStatus.checkedIn)
                        .length,
                    Colors.green.shade700,
                  ),
                  _buildSummaryCard(
                    "قيد الانتظار",
                    dummyBookings
                        .where((b) => b.status == BookingStatus.pending)
                        .length,
                    Colors.orange.shade700,
                  ),
                  _buildSummaryCard(
                    "الخروج",
                    dummyBookings
                        .where((b) => b.status == BookingStatus.checkedOut)
                        .length,
                    Colors.grey.shade700,
                  ),
                  _buildSummaryCard(
                    "No-Show",
                    dummyBookings
                        .where((b) => b.status == BookingStatus.noShow)
                        .length,
                    Colors.red.shade700,
                  ),
                ]
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: e,
                  ),
                )
                .toList(),
      ),
    );
  }

  // ويدجت شريط الفلاتر (تصميم محدث)
  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                _searchQuery = value;
                _applyFilters();
              },
              decoration: InputDecoration(
                hintText: "بحث عن حجز...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<BookingStatus?>(
                hint: const Text("جميع الحالات"),
                value: _selectedStatus,
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text("جميع الحالات"),
                  ),
                  ...BookingStatus.values.map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Text(status.name),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() => _selectedStatus = value);
                  _applyFilters();
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton.outlined(
            icon: const Icon(Icons.date_range_outlined),
            tooltip: 'تصفية حسب تاريخ الدخول',
            onPressed: _selectDateRange,
          ),
        ],
      ),
    );
  }

  // ✅ ويدجت رأس الجدول المخصص (جديدة)
  Widget _buildTableHeader() {
    TextStyle headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade600,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text("الاسم", style: headerStyle)),
          Expanded(flex: 2, child: Text("غرفة", style: headerStyle)),
          Expanded(
            flex: 3,
            child: Text("تاريخ الدخول/الخروج", style: headerStyle),
          ),
          Expanded(flex: 1, child: Text("الليالي", style: headerStyle)),
          Expanded(flex: 2, child: Text("السعر الكلي", style: headerStyle)),
          Expanded(flex: 2, child: Text("الحالة", style: headerStyle)),
          Expanded(
            flex: 1,
            child: Text(
              "الإجراءات",
              style: headerStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ ويدجت صف الجدول المخصص (جديدة)
  Widget _buildTableRow(Booking b) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              b.guestName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(flex: 2, child: Text('${b.roomNumber} (${b.roomType})')),
          Expanded(
            flex: 3,
            child: Text(
              '${DateFormat.yMd().format(b.checkInDate)} - ${DateFormat.yMd().format(b.checkOutDate)}',
            ),
          ),
          Expanded(flex: 1, child: Text(b.nights.toString())),
          Expanded(
            flex: 2,
            child: Text('${b.totalPrice.toStringAsFixed(2)} ريال'),
          ),
          Expanded(flex: 2, child: _buildStatusChip(b.status)),
          Expanded(
            flex: 1,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
              onSelected: (value) {
                if (value == 'details') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailsView(booking: b),
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: "details", child: Text("تفاصيل")),
                const PopupMenuItem(
                  value: "checkin",
                  child: Text("تسجيل الدخول"),
                ),
                const PopupMenuItem(
                  value: "checkout",
                  child: Text("تسجيل الخروج"),
                ),
                const PopupMenuItem(
                  value: "payment",
                  child: Text("تحصيل المدفوعات"),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: "cancel",
                  child: Text(
                    "إلغاء الحجز",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت بطاقة الملخص (تصميم محدث)
  Widget _buildSummaryCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت شريحة الحالة (بدون تغيير جوهري)
  Widget _buildStatusChip(BookingStatus status) {
    final statusMap = {
      BookingStatus.booked: {'color': Colors.blue, 'text': 'Booked'},
      BookingStatus.checkedIn: {'color': Colors.green, 'text': 'Checked-In'},
      BookingStatus.pending: {'color': Colors.orange, 'text': 'Pending'},
      BookingStatus.checkedOut: {'color': Colors.grey, 'text': 'Checked-Out'},
      BookingStatus.noShow: {'color': Colors.red, 'text': 'No-Show'},
    };
    final color = statusMap[status]!['color'] as Color;
    final text = statusMap[status]!['text'] as String;

    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
