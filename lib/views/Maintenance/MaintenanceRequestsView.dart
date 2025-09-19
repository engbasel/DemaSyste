import 'package:dema/views/Maintenance/MaintenanceDetailsView.dart';
import 'package:dema/views/Maintenance/dummyMaintenanceRequestsmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaintenanceRequestsView extends StatefulWidget {
  const MaintenanceRequestsView({super.key});

  @override
  State<MaintenanceRequestsView> createState() =>
      _MaintenanceRequestsViewState();
}

class _MaintenanceRequestsViewState extends State<MaintenanceRequestsView> {
  // استخدام TabController لتقسيم الطلبات حسب الحالة
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // عدد الحالات: جديد، قيد التنفيذ، مكتمل، ملغي
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text(
            'طلبات الصيانة',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement Add New Request functionality
                },
                icon: const Icon(Icons.add),
                label: const Text("طلب جديد"),
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              _buildTab('جديد', MaintenanceStatus.New),
              _buildTab('قيد التنفيذ', MaintenanceStatus.InProgress),
              _buildTab('مكتمل', MaintenanceStatus.Completed),
              _buildTab('ملغي', MaintenanceStatus.Cancelled),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRequestsList(MaintenanceStatus.New),
            _buildRequestsList(MaintenanceStatus.InProgress),
            _buildRequestsList(MaintenanceStatus.Completed),
            _buildRequestsList(MaintenanceStatus.Cancelled),
          ],
        ),
      ),
    );
  }

  // ويدجت مخصصة لعنوان التبويب مع عدد الطلبات
  Widget _buildTab(String title, MaintenanceStatus status) {
    final count = dummyMaintenanceRequests
        .where((req) => req.status == status)
        .length;
    return Tab(
      child: Row(
        children: [
          Text(title),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 12,
            backgroundColor: _getColorForStatus(status).withOpacity(0.2),
            child: Text(
              count.toString(),
              style: TextStyle(
                color: _getColorForStatus(status),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت لعرض قائمة الطلبات حسب الحالة
  Widget _buildRequestsList(MaintenanceStatus status) {
    final requests = dummyMaintenanceRequests
        .where((req) => req.status == status)
        .toList();

    if (requests.isEmpty) {
      return Center(child: Text('لا توجد طلبات في حالة "$status"'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return _buildRequestCard(requests[index]);
      },
    );
  }

  // ويدجت لعرض بطاقة طلب صيانة واحد
  Widget _buildRequestCard(MaintenanceRequest request) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MaintenanceDetailsView(request: request),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    request.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _buildPriorityChip(request.priority),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'وحدة ${request.roomNumber} (${request.roomType}) - المستأجر: ${request.guestName}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'تاريخ الإبلاغ: ${DateFormat.yMMMd('ar_SA').format(request.reportedDate)}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  const Spacer(),
                  if (request.assignedTechnician != null) ...[
                    Icon(Icons.person, size: 14, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      request.assignedTechnician!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت لعرض شريحة الأولوية
  Widget _buildPriorityChip(MaintenancePriority priority) {
    Color color;
    String text;
    switch (priority) {
      case MaintenancePriority.High:
        color = Colors.red;
        text = 'عالية';
        break;
      case MaintenancePriority.Medium:
        color = Colors.orange;
        text = 'متوسطة';
        break;
      case MaintenancePriority.Low:
        color = Colors.blue;
        text = 'منخفضة';
        break;
    }
    return Chip(
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
    );
  }

  // دالة لجلب اللون حسب الحالة
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
}
