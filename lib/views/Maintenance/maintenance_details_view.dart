import 'package:dema/views/Maintenance/dummy_maintenance_requests_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaintenanceDetailsView extends StatelessWidget {
  final MaintenanceRequestModel request;
  const MaintenanceDetailsView({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الطلب #${request.id}'),
        actions: [
          // يمكن إضافة زر لتعديل الطلب هنا
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              title: 'تفاصيل الطلب',
              icon: Icons.info_outline,
              children: [
                _buildDetailRow('العنوان', request.title),
                _buildDetailRow('الوصف الكامل', request.description),
                _buildDetailRow(
                  'الحالة',
                  request.status.name,
                  chipColor: _getColorForStatus(request.status),
                ),
                _buildDetailRow(
                  'الأولوية',
                  request.priority.name,
                  chipColor: _getColorForPriority(request.priority),
                ),
                _buildDetailRow(
                  'تاريخ الإبلاغ',
                  DateFormat.yMMMMEEEEd('ar_SA').format(request.reportedDate),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'الوحدة والمستأجر',
              icon: Icons.home_work_outlined,
              children: [
                _buildDetailRow('رقم الوحدة', request.roomNumber),
                _buildDetailRow('نوع الوحدة', request.roomType),
                _buildDetailRow('اسم المستأجر', request.guestName),
                // يمكن إضافة أزرار للتواصل مع المستأجر هنا
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'الفني والتكلفة',
              icon: Icons.engineering_outlined,
              children: [
                _buildDetailRow(
                  'الفني المسؤول',
                  request.assignedTechnician ?? 'لم يتم التعيين',
                ),
                _buildDetailRow(
                  'التكلفة',
                  request.cost != null
                      ? '${request.cost!.toStringAsFixed(2)} ريال'
                      : 'لم تسجل بعد',
                ),
              ],
            ),
          ],
        ),
      ),
      // يمكن وضع الأزرار الرئيسية هنا مثل "إغلاق الطلب"
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('تغيير حالة الطلب'),
          onPressed: () {
            // TODO: Implement change status logic
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {Color? chipColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: chipColor != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Chip(
                      label: Text(
                        value,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: chipColor,
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // دوال مساعدة لجلب الألوان
  Color _getColorForStatus(MaintenanceStatus status) {
    switch (status) {
      case MaintenanceStatus.New:
        return Colors.blue;
      case MaintenanceStatus.InProgress:
        return Colors.orange;
      case MaintenanceStatus.Completed:
        return Colors.green;
      case MaintenanceStatus.Cancelled:
        return Colors.grey;
    }
  }

  Color _getColorForPriority(MaintenancePriority priority) {
    switch (priority) {
      case MaintenancePriority.High:
        return Colors.red;
      case MaintenancePriority.Medium:
        return Colors.orange;
      case MaintenancePriority.Low:
        return Colors.blue;
    }
  }
}
