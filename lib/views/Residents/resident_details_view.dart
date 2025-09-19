import 'package:dema/views/Residents/resident_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResidentDetailsView extends StatelessWidget {
  final ResidentModel resident;
  const ResidentDetailsView({super.key, required this.resident});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // عدد التبويبات
      child: Scaffold(
        appBar: AppBar(
          title: Text(resident.name),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'معلومات شخصية'),
              Tab(text: 'تفاصيل العقد'),
              Tab(text: 'سجل المدفوعات'),
              Tab(text: 'طلبات الصيانة'),
              Tab(text: 'المرفقات'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPersonalInfoTab(),
            _buildContractDetailsTab(),
            _buildPaymentsTab(),
            _buildMaintenanceTab(),
            _buildAttachmentsTab(),
          ],
        ),
      ),
    );
  }

  // التبويب الأول: المعلومات الشخصية
  Widget _buildPersonalInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDetailRow('الاسم الكامل', resident.name),
              _buildDetailRow('رقم الهاتف', resident.phone),
              _buildDetailRow('البريد الإلكتروني', resident.email),
              _buildDetailRow('الرقم القومي', resident.nationalId),
            ],
          ),
        ),
      ),
    );
  }

  // التبويب الثاني: تفاصيل العقد
  Widget _buildContractDetailsTab() {
    final bool isActive = resident.status == ResidentStatus.Active;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDetailRow('رقم الوحدة', resident.unitNumber),
              _buildDetailRow(
                'قيمة الإيجار الشهري',
                '${resident.rentAmount.toStringAsFixed(2)} ريال',
              ),
              _buildDetailRow(
                'تاريخ بدء العقد',
                DateFormat.yMMMd('ar_SA').format(resident.contractStartDate),
              ),
              _buildDetailRow(
                'تاريخ انتهاء العقد',
                DateFormat.yMMMd('ar_SA').format(resident.contractEndDate),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'حالة العقد',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                trailing: Chip(
                  label: Text(isActive ? 'ساري' : 'منتهي'),
                  backgroundColor: (isActive ? Colors.green : Colors.red)
                      .withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: isActive
                        ? Colors.green.shade800
                        : Colors.red.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // التبويب الثالث: سجل المدفوعات
  Widget _buildPaymentsTab() {
    // بيانات وهمية مؤقتة
    final payments = [
      {'date': '1 سبتمبر 2025', 'amount': '7500.00 ريال', 'status': 'مدفوع'},
      {'date': '1 أغسطس 2025', 'amount': '7500.00 ريال', 'status': 'مدفوع'},
      {'date': '1 يوليو 2025', 'amount': '7500.00 ريال', 'status': 'متأخر'},
    ];
    return Card(
      margin: const EdgeInsets.all(16),
      child: DataTable(
        columns: const [
          DataColumn(label: Text('التاريخ')),
          DataColumn(label: Text('المبلغ')),
          DataColumn(label: Text('الحالة')),
        ],
        rows: payments
            .map(
              (p) => DataRow(
                cells: [
                  DataCell(Text(p['date']!)),
                  DataCell(Text(p['amount']!)),
                  DataCell(
                    Text(
                      p['status']!,
                      style: TextStyle(
                        color: p['status'] == 'مدفوع'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  // التبويب الرابع: طلبات الصيانة الخاصة بالمستأجر
  Widget _buildMaintenanceTab() {
    return const Center(child: Text('سيتم عرض سجل طلبات الصيانة هنا'));
  }

  // التبويب الخامس: المرفقات
  Widget _buildAttachmentsTab() {
    if (resident.attachments.isEmpty) {
      return const Center(child: Text('لا توجد مرفقات لهذا المستأجر'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resident.attachments.length,
      itemBuilder: (context, index) {
        final file = resident.attachments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              file.endsWith('.pdf') ? Icons.picture_as_pdf : Icons.image,
              color: Colors.blue.shade700,
            ),
            title: Text(file),
            trailing: const Icon(Icons.download_for_offline_outlined),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade600)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
