import 'package:dema/views/Rooms/RoomStatusChip.dart';
import 'package:flutter/material.dart';
import 'package:dema/views/Rooms/Room_model.dart';

class RoomDetailsView extends StatelessWidget {
  final RoomModel room;

  const RoomDetailsView({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for ${room.roomNumber}'),
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        foregroundColor: const Color(0xFF1E293B),
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الغرفة
            Image.network(
              room.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 250,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            ),

            // التفاصيل
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان الغرفة
                  Text(
                    room.roomNumber,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // نوع الغرفة + الحالة
                  Row(
                    children: [
                      Text(
                        '${room.roomType} • ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      RoomStatusChip(status: room.status),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // ✅ معلومات إضافية
                  _buildDetailRow('Owner', room.ownerName),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Rent',
                    '${room.rentAmount.toStringAsFixed(2)} EGP / month',
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow('Area', '${room.area ?? 0} m²'),
                  const SizedBox(height: 16),
                  _buildDetailRow('Floor', '${room.floor ?? '-'}'),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Last Maintenance',
                    room.lastMaintenance ?? '-',
                  ),
                  const SizedBox(height: 16),
                  if (room.contractStart != null && room.contractEnd != null)
                    _buildDetailRow(
                      'Contract',
                      '${room.contractStart} → ${room.contractEnd}',
                    ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // 👤 قسم المستأجر
                  if (room.status == RoomStatus.occupied &&
                      room.tenantName != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tenant Info',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow('Name', room.tenantName!),
                        const SizedBox(height: 8),
                        _buildDetailRow('Phone', room.tenantPhone ?? '-'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // TODO: اتصال مباشر
                              },
                              icon: const Icon(Icons.phone),
                              label: const Text('Call'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: () {
                                // TODO: إرسال رسالة
                              },
                              icon: const Icon(Icons.message),
                              label: const Text('Message'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                  // 💰 قسم المدفوعات
                  const Text(
                    'Payments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentsTable(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO: تحصيل الإيجار
                        },
                        child: const Text('Collect Rent'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          // TODO: تذكير المستأجر
                        },
                        child: const Text('Send Reminder'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // 🔧 قسم الصيانة
                  const Text(
                    'Maintenance',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(room.maintenanceNotes),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: جدولة صيانة
                    },
                    child: const Text('Schedule Maintenance'),
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // 📂 المرفقات
                  const Text(
                    'Attachments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: [
                      _buildAttachmentCard(
                        Icons.picture_as_pdf,
                        'Contract.pdf',
                      ),
                      _buildAttachmentCard(Icons.image, 'Before.jpg'),
                      _buildAttachmentCard(Icons.image, 'After.jpg'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildPaymentsTable() {
    final dummyPayments = [
      {'date': '2025-09-01', 'amount': '4500 EGP', 'status': 'Paid'},
      {'date': '2025-08-01', 'amount': '4500 EGP', 'status': 'Paid'},
      {'date': '2025-07-01', 'amount': '4500 EGP', 'status': 'Late'},
    ];

    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFE2E8F0)),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Amount',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...dummyPayments.map((p) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(p['date']!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(p['amount']!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  p['status']!,
                  style: TextStyle(
                    color: p['status'] == 'Paid' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildAttachmentCard(IconData icon, String fileName) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: Colors.blueGrey),
          const SizedBox(height: 8),
          Text(
            fileName,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
