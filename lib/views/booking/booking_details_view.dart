import 'package:dema/views/booking/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BookingDetailsView extends StatelessWidget {
  final Booking booking;
  const BookingDetailsView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    // The rest of your build method remains the same...
    return Scaffold(
      appBar: AppBar(
        title: Text('الحجز لـ ${booking.guestName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            tooltip: "طباعة / تصدير PDF",
            onPressed: () => _generateAndPrintPdf(context),
          ),
        ],
      ),
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

  // 📝 NEW: Professional PDF Generation with Arabic Support
  Future<void> _generateAndPrintPdf(BuildContext context) async {
    final pdf = pw.Document();

    // 1. Load the Arabic font from assets
    final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
    final arabicFont = pw.Font.ttf(fontData);
    // 2. Create a theme with the Arabic font
    final arabicTheme = pw.ThemeData.withFont(
      base: arabicFont,
      bold: arabicFont,
    );

    final date = DateFormat('yyyy/MM/dd – HH:mm').format(DateTime.now());

    pdf.addPage(
      pw.MultiPage(
        // 3. Apply the theme and set the text direction to RTL
        theme: arabicTheme,
        textDirection: pw.TextDirection.rtl,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          // Header
          pw.Header(
            level: 0,
            child: pw.Column(
              children: [
                pw.Text(
                  "فاتورة حجز عقار",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text("شركة ديما لإدارة العقارات"),
              ],
            ),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("رقم الحجز: #12345"), // Example booking ID
              pw.Text("تاريخ الإصدار: $date"),
            ],
          ),
          pw.Divider(height: 20),

          // Using a table for better structure
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(1),
            },
            children: [
              _buildTableRow("اسم العميل:", booking.guestName),
              _buildTableRow("رقم الهاتف:", booking.guestPhone),
              _buildTableRow("البريد الإلكتروني:", booking.guestEmail),
            ],
          ),

          pw.SizedBox(height: 20),

          // Booking Details Table
          pw.Text(
            "تفاصيل الحجز",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.Table.fromTextArray(
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.center,
            data: <List<String>>[
              <String>['تاريخ الخروج', 'تاريخ الدخول', 'الليالي', 'الغرفة'],
              <String>[
                DateFormat.yMMMd().format(booking.checkOutDate),
                DateFormat.yMMMd().format(booking.checkInDate),
                '${booking.nights}',
                '${booking.roomNumber} (${booking.roomType})',
              ],
            ],
          ),

          pw.SizedBox(height: 30),

          // Payment Details
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.SizedBox(
              width: 200,
              child: pw.Table(
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(1),
                },
                children: [
                  _buildTableRow(
                    "المبلغ الإجمالي:",
                    "${booking.totalPrice.toStringAsFixed(2)} ريال",
                  ),
                  _buildTableRow(
                    "المبلغ المدفوع:",
                    "${booking.amountPaid.toStringAsFixed(2)} ريال",
                    color: PdfColors.green,
                  ),
                  _buildTableRow(
                    "المبلغ المتبقي:",
                    "${booking.remainingBalance.toStringAsFixed(2)} ريال",
                    color: PdfColors.red,
                  ),
                ],
              ),
            ),
          ),

          pw.Expanded(child: pw.SizedBox()),

          // Footer
          pw.Footer(
            title: pw.Text(
              "شركة ديما © جميع الحقوق محفوظة",
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );

    // Show the PDF in a print preview screen
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  // Helper for creating styled table rows in PDF
  pw.TableRow _buildTableRow(
    String title,
    String value, {
    PdfColor color = PdfColors.black,
  }) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(value, style: pw.TextStyle(color: color)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            title,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // --- The rest of your UI Widgets remain unchanged ---
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
