// ignore_for_file: file_names

import 'dart:collection';
import 'package:dema/views/booking/BookingDetailsView.dart';
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
  DateTime _focusedDay = DateTime(
    2025,
    9,
    19,
  ); // Set initial focus day to match dummy data
  DateTime? _selectedDay;

  // خريطة لتخزين الأحداث (الحجوزات) لكل يوم
  late LinkedHashMap<DateTime, List<Booking>> _events;

  @override
  void initState() {
    super.initState();
    _events = _groupBookingsByDate(dummyBookings);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  LinkedHashMap<DateTime, List<Booking>> _groupBookingsByDate(
    List<Booking> bookings,
  ) {
    final map = LinkedHashMap<DateTime, List<Booking>>(
      equals: isSameDay,
      hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
    );

    for (final booking in bookings) {
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

  List<Booking> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

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
          Card(
            margin: const EdgeInsets.all(12.0),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: TableCalendar<Booking>(
              locale: 'ar_SA',
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
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                // تم إزالة markerDecoration لأننا سنستخدم calendarBuilders
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              // ✅ --- الجزء المطور ---
              // builder مخصص لعرض مؤشرات ملونة حسب نوع الحدث
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    final bookings = events.cast<Booking>();
                    // التحقق من وجود أنواع مختلفة من الأحداث في نفس اليوم
                    bool hasArrival = bookings.any(
                      (b) => isSameDay(b.checkInDate, date),
                    );
                    bool hasDeparture = bookings.any(
                      (b) => isSameDay(
                        b.checkOutDate.subtract(const Duration(days: 1)),
                        date,
                      ),
                    );
                    bool hasStayOver = bookings.any(
                      (b) =>
                          !isSameDay(b.checkInDate, date) &&
                          !isSameDay(
                            b.checkOutDate.subtract(const Duration(days: 1)),
                            date,
                          ),
                    );

                    return Positioned(
                      right: 5,
                      bottom: 5,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasArrival) _buildMarker(Colors.green),
                          if (hasStayOver) _buildMarker(Colors.orange),
                          if (hasDeparture) _buildMarker(Colors.red),
                        ],
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 8.0),
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
                  padding: const EdgeInsets.only(
                    bottom: 80,
                  ), // لإعطاء مساحة للزر العائم
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
      // ✅ --- الجزء المضاف ---
      // زر عائم لإضافة حجز جديد
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // يمكن هنا فتح شاشة جديدة وإرسال التاريخ المختار
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'فتح شاشة حجز جديد لتاريخ ${DateFormat.yMMMd('ar_SA').format(_selectedDay!)}',
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
        label: const Text('حجز جديد'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  // ويدجت صغيرة لرسم مؤشر ملون
  Widget _buildMarker(Color color) {
    return Container(
      width: 7,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 0.5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildEventListItem(Booking booking, DateTime selectedDay) {
    String eventType;
    Color indicatorColor;
    if (isSameDay(booking.checkInDate, selectedDay)) {
      eventType = "وصول جديد";
      indicatorColor = Colors.green;
    } else if (isSameDay(
      booking.checkOutDate.subtract(const Duration(days: 1)),
      selectedDay,
    )) {
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
        // ✅ --- الجزء المضاف ---
        // جعل العنصر قابلاً للضغط للانتقال لشاشة التفاصيل
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingDetailsView(booking: booking),
            ),
          );
        },
      ),
    );
  }
}
