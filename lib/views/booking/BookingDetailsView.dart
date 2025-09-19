import 'package:dema/views/booking/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDetailsView extends StatelessWidget {
  final Booking booking;
  const BookingDetailsView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking for ${booking.guestName}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimeline(),
            const SizedBox(height: 24),
            _buildGuestInfoCard(),
            const SizedBox(height: 16),
            _buildBookingInfoCard(),
            const SizedBox(height: 16),
            _buildPaymentInfoCard(),
            const SizedBox(height: 16),
            _buildAttachmentsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTimelineStep(
              'الحجز',
              Icons.book_online,
              booking.status == BookingStatus.booked ||
                  booking.status == BookingStatus.checkedIn,
            ),
            const Expanded(child: Divider()),
            _buildTimelineStep(
              'الدخول',
              Icons.login,
              booking.status == BookingStatus.checkedIn,
            ),
            const Expanded(child: Divider()),
            _buildTimelineStep(
              'الخروج',
              Icons.logout,
              booking.status == BookingStatus.checkedOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(String title, IconData icon, bool isActive) {
    final color = isActive ? Colors.green : Colors.grey;
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildGuestInfoCard() {
    return Card(
      child: ListTileTheme(
        child: ExpansionTile(
          leading: const Icon(Icons.person),
          title: const Text(
            'معلومات العميل',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          initiallyExpanded: true,
          children: [
            _buildDetailListTile('الاسم', booking.guestName),
            _buildDetailListTile('الهاتف', booking.guestPhone),
            _buildDetailListTile('البريد الإلكتروني', booking.guestEmail),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingInfoCard() {
    return Card(
      child: ListTileTheme(
        child: ExpansionTile(
          leading: const Icon(Icons.hotel),
          title: const Text(
            'معلومات الحجز',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          initiallyExpanded: true,
          children: [
            _buildDetailListTile(
              'تاريخ الدخول',
              DateFormat.yMMMd().format(booking.checkInDate),
            ),
            _buildDetailListTile(
              'تاريخ الخروج',
              DateFormat.yMMMd().format(booking.checkOutDate),
            ),
            _buildDetailListTile('الليلة', '${booking.nights}'),
            _buildDetailListTile('عدد الضيوف', '${booking.numberOfGuests}'),
            _buildDetailListTile('نوع الحجز', booking.bookingType.name),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInfoCard() {
    return Card(
      child: ListTileTheme(
        child: ExpansionTile(
          leading: const Icon(Icons.monetization_on),
          title: const Text(
            'معلومات الدفع',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          initiallyExpanded: true,
          children: [
            _buildDetailListTile(
              'السعر الكلي',
              '${booking.totalPrice.toStringAsFixed(2)} ريال',
            ),
            _buildDetailListTile(
              'المدفوع',
              '${booking.amountPaid.toStringAsFixed(2)} ريال',
              color: Colors.green,
            ),
            _buildDetailListTile(
              'الباقي',
              '${booking.remainingBalance.toStringAsFixed(2)} ريال',
              color: Colors.red,
            ),
            _buildDetailListTile('طريقة الدفع', booking.paymentMethod.name),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentsCard() {
    return Card(
      child: ListTileTheme(
        child: ExpansionTile(
          leading: const Icon(Icons.attach_file),
          title: const Text(
            'المرفقات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            if (booking.attachments.isEmpty)
              const ListTile(title: Text('لا يوجد مرفقات'))
            else
              ...booking.attachments
                  .map(
                    (file) => ListTile(
                      leading: const Icon(Icons.insert_drive_file),
                      title: Text(file),
                      trailing: const Icon(Icons.download),
                      onTap: () {},
                    ),
                  )
                  .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailListTile(String title, String subtitle, {Color? color}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: color ?? Colors.black87,
        ),
      ),
    );
  }
}
