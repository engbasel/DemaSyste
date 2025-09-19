import 'dart:collection';
import 'package:dema/views/booking/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  // متغيرات الحالة لإدارة التقويم
  late final ValueNotifier<List<Booking>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // خريطة لتخزين الأحداث (الحجوزات) لكل يوم
  late LinkedHashMap<DateTime, List<Booking>> _events;

  @override
  void initState() {
    super.initState();
    // ✅ الخطوة 1: نقوم بتهيئة خريطة الأحداث أولاً
    _events = _groupBookingsByDate(dummyBookings);

    // الخطوة 2: نحدد اليوم المختار
    _selectedDay = _focusedDay;

    // ✅ الخطوة 3: الآن نستطيع استخدام _getEventsForDay بأمان لأن _events أصبحت لها قيمة
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // دالة لتجميع الحجوزات حسب اليوم
  LinkedHashMap<DateTime, List<Booking>> _groupBookingsByDate(
    List<Booking> bookings,
  ) {
    final map = LinkedHashMap<DateTime, List<Booking>>(
      equals: isSameDay,
      hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
    );

    for (final booking in bookings) {
      // إضافة الحجز لكل يوم من تاريخ الدخول إلى ما قبل تاريخ الخروج
      for (
        var day = booking.checkInDate;
        day.isBefore(booking.checkOutDate);
        day = day.add(const Duration(days: 1))
      ) {
        final date = DateTime.utc(day.year, day.month, day.day);
        if (map[date] == null) {
          map[date] = [];
        }
        map[date]!.add(booking);
      }
    }
    return map;
  }

  // دالة لجلب الأحداث ليوم معين
  List<Booking> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  // دالة عند اختيار يوم
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text("تقويم الحجوزات"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // ويدجت التقويم
          Card(
            margin: const EdgeInsets.all(12.0),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: TableCalendar<Booking>(
              locale: 'ar_SA', // للغة العربية
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2026, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.saturday,
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              // تخصيص شكل التقويم
              calendarStyle: CalendarStyle(
                // علامات الأحداث (الدوائر تحت اليوم)
                markerDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          // قائمة الأحداث لليوم المحدد
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                const Text(
                  "الأنشطة لليوم:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                if (_selectedDay != null)
                  Text(
                    DateFormat.yMMMd('ar_SA').format(_selectedDay!),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Booking>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                if (value.isEmpty) {
                  return const Center(
                    child: Text("لا توجد حجوزات في هذا اليوم"),
                  );
                }
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return _buildEventListItem(value[index], _selectedDay!);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت لعرض تفاصيل حدث (حجز) واحد في القائمة
  Widget _buildEventListItem(Booking booking, DateTime selectedDay) {
    // تحديد نوع الحدث (وصول، مغادرة، إقامة)
    String eventType;
    Color indicatorColor;
    if (isSameDay(booking.checkInDate, selectedDay)) {
      eventType = "وصول جديد";
      indicatorColor = Colors.green;
    } else if (isSameDay(
      booking.checkOutDate.subtract(const Duration(days: 1)),
      selectedDay,
    )) {
      // Note: checkOutDate is the morning of departure, so the last night is the day before.
      eventType = "مغادرة";
      indicatorColor = Colors.red;
    } else {
      eventType = "إقامة حالية";
      indicatorColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: indicatorColor,
          radius: 15,
          child: Icon(
            eventType == "وصول جديد"
                ? Icons.login
                : eventType == "مغادرة"
                ? Icons.logout
                : Icons.bed,
            color: Colors.white,
            size: 18,
          ),
        ),
        title: Text(booking.guestName),
        subtitle: Text("غرفة ${booking.roomNumber} - ${booking.roomType}"),
        trailing: Text(
          eventType,
          style: TextStyle(color: indicatorColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
