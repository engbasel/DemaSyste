// import 'package:dema/views/booking/booking_model.dart';
// import 'package:flutter/material.dart';

// class BookingsView extends StatelessWidget {
//   const BookingsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       appBar: AppBar(
//         title: const Text(
//           'Bookings',
//           style: TextStyle(color: Color(0xFF1E293B)),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 // TODO: Add new booking logic
//               },
//               icon: const Icon(Icons.add),
//               label: const Text("New Booking"),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // 📊 Summary counters
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 _buildSummaryCard("Total", dummyBookings.length, Colors.blue),
//                 const SizedBox(width: 12),
//                 _buildSummaryCard(
//                   "Checked-In",
//                   dummyBookings
//                       .where((b) => b.status == BookingStatus.checkedIn)
//                       .length,
//                   Colors.green,
//                 ),
//                 const SizedBox(width: 12),
//                 _buildSummaryCard(
//                   "Pending",
//                   dummyBookings
//                       .where((b) => b.status == BookingStatus.pending)
//                       .length,
//                   Colors.orange,
//                 ),
//                 const SizedBox(width: 12),
//                 _buildSummaryCard(
//                   "No-Show",
//                   dummyBookings
//                       .where((b) => b.status == BookingStatus.noShow)
//                       .length,
//                   Colors.red,
//                 ),
//               ],
//             ),
//           ),

//           // 🔍 Search + Filters
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search by guest name or room",
//                       prefixIcon: const Icon(Icons.search),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 DropdownButton<BookingStatus?>(
//                   hint: const Text("Filter by Status"),
//                   value: null,
//                   items: BookingStatus.values.map((status) {
//                     return DropdownMenuItem(
//                       value: status,
//                       child: Text(status.toString().split('.').last),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     // TODO: Apply filter
//                   },
//                 ),
//               ],
//             ),
//           ),

//           // 📋 Bookings Table
//           Expanded(
//             child: ListView(
//               children: [
//                 // Table Header
//                 Container(
//                   color: const Color(0xFFE2E8F0),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 12,
//                   ),
//                   child: const Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           "Guest Name",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           "Room",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           "Check-In",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           "Check-Out",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           "Status",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           "Actions",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Table Rows
//                 ...dummyBookings.map(
//                   (b) => Container(
//                     color: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 12,
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(flex: 2, child: Text(b.guestName)),
//                         Expanded(flex: 1, child: Text(b.roomNumber)),
//                         Expanded(flex: 2, child: Text(b.checkIn)),
//                         Expanded(flex: 2, child: Text(b.checkOut)),
//                         Expanded(flex: 1, child: _buildStatusChip(b.status)),
//                         Expanded(
//                           flex: 1,
//                           child: PopupMenuButton<String>(
//                             onSelected: (value) {
//                               // TODO: Handle actions
//                             },
//                             itemBuilder: (context) => [
//                               const PopupMenuItem(
//                                 value: "details",
//                                 child: Text("View Details"),
//                               ),
//                               const PopupMenuItem(
//                                 value: "checkin",
//                                 child: Text("Check-In"),
//                               ),
//                               const PopupMenuItem(
//                                 value: "checkout",
//                                 child: Text("Check-Out"),
//                               ),
//                               const PopupMenuItem(
//                                 value: "cancel",
//                                 child: Text("Cancel Booking"),
//                               ),
//                             ],
//                             child: const Text(
//                               "Actions",
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 📊 Summary Card
//   Widget _buildSummaryCard(String title, int count, Color color) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         child: Column(
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black54,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               "$count",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🎨 Status Chip UI
//   Widget _buildStatusChip(BookingStatus status) {
//     Color color;
//     String text;

//     switch (status) {
//       case BookingStatus.booked:
//         color = Colors.blue;
//         text = "Booked";
//         break;
//       case BookingStatus.checkedIn:
//         color = Colors.green;
//         text = "Checked-In";
//         break;
//       case BookingStatus.pending:
//         color = Colors.orange;
//         text = "Pending";
//         break;
//       case BookingStatus.checkedOut:
//         color = Colors.grey;
//         text = "Checked-Out";
//         break;
//       case BookingStatus.noShow:
//         color = Colors.red;
//         text = "No-Show";
//         break;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.w500,
//           fontSize: 12,
//         ),
//       ),
//     );
//   }
// }

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
  late List<Booking> _filteredBookings;
  BookingStatus? _selectedStatus;
  DateTimeRange? _selectedDateRange;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredBookings = List.from(dummyBookings);
  }

  void _applyFilters() {
    setState(() {
      _filteredBookings = dummyBookings.where((booking) {
        // Status Filter
        final statusMatch =
            _selectedStatus == null || booking.status == _selectedStatus;
        // Date Range Filter
        final dateMatch =
            _selectedDateRange == null ||
            (booking.checkInDate.isAfter(
                  _selectedDateRange!.start.subtract(const Duration(days: 1)),
                ) &&
                booking.checkInDate.isBefore(
                  _selectedDateRange!.end.add(const Duration(days: 1)),
                ));
        // Search Query Filter
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Bookings',
          style: TextStyle(color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("New Booking"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSummaryCards(),
          _buildFilterBar(),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildBookingsTable(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildSummaryCard("Total", dummyBookings.length, Colors.blue),
          const SizedBox(width: 12),
          _buildSummaryCard(
            "Checked-In",
            dummyBookings
                .where((b) => b.status == BookingStatus.checkedIn)
                .length,
            Colors.green,
          ),
          const SizedBox(width: 12),
          _buildSummaryCard(
            "Pending",
            dummyBookings
                .where((b) => b.status == BookingStatus.pending)
                .length,
            Colors.orange,
          ),
          const SizedBox(width: 12),
          _buildSummaryCard(
            "Checked-Out",
            dummyBookings
                .where((b) => b.status == BookingStatus.checkedOut)
                .length,
            Colors.grey,
          ),
          const SizedBox(width: 12),
          _buildSummaryCard(
            "No-Show",
            dummyBookings.where((b) => b.status == BookingStatus.noShow).length,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                _searchQuery = value;
                _applyFilters();
              },
              decoration: InputDecoration(
                hintText: "Search by guest name or room",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
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
            ),
            child: DropdownButton<BookingStatus?>(
              underline: const SizedBox(),
              hint: const Text("Filter by Status"),
              value: _selectedStatus,
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text("All Statuses"),
                ),
                ...BookingStatus.values.map(
                  (status) =>
                      DropdownMenuItem(value: status, child: Text(status.name)),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
                _applyFilters();
              },
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.date_range),
            tooltip: 'Filter by Check-in Date',
            onPressed: _selectDateRange,
          ),
          if (_selectedDateRange != null)
            ActionChip(
              avatar: const Icon(Icons.close),
              label: Text(
                '${DateFormat.yMd().format(_selectedDateRange!.start)} - ${DateFormat.yMd().format(_selectedDateRange!.end)}',
              ),
              onPressed: () {
                setState(() {
                  _selectedDateRange = null;
                });
                _applyFilters();
              },
            ),
        ],
      ),
    );
  }

  DataTable _buildBookingsTable() {
    final columns = [
      'Guest',
      'Room',
      'Check-In/Out',
      'Nights',
      'Total Price',
      'Status',
      'Actions',
    ];
    return DataTable(
      columns: columns
          .map(
            (c) => DataColumn(
              label: Text(
                c,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
      rows: _filteredBookings.map((b) {
        return DataRow(
          cells: [
            DataCell(Text(b.guestName)),
            DataCell(Text('${b.roomNumber} (${b.roomType})')),
            DataCell(
              Text(
                '${DateFormat.yMd().format(b.checkInDate)}\n${DateFormat.yMd().format(b.checkOutDate)}',
              ),
            ),
            DataCell(Text(b.nights.toString())),
            DataCell(Text('${b.totalPrice.toStringAsFixed(2)} EGP')),
            DataCell(_buildStatusChip(b.status)),
            DataCell(
              PopupMenuButton<String>(
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
                  const PopupMenuItem(
                    value: "details",
                    child: Text("View Details"),
                  ),
                  const PopupMenuItem(
                    value: "checkin",
                    child: Text("Check-In"),
                  ),
                  const PopupMenuItem(
                    value: "checkout",
                    child: Text("Check-Out"),
                  ),
                  const PopupMenuItem(
                    value: "payment",
                    child: Text("Collect Payment"),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: "cancel",
                    child: Text(
                      "Cancel Booking",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

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
    );
  }
}
