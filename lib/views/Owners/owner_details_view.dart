import 'package:dema/views/Owners/owner_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnerDetailsView extends StatelessWidget {
  final Owner owner;
  const OwnerDetailsView({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // عدد التبويبات
      child: Scaffold(
        appBar: AppBar(
          title: Text(owner.name),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.person_outline), text: 'الملف الشخصي'),
              Tab(icon: Icon(Icons.home_work_outlined), text: 'الوحدات'),
              Tab(
                icon: Icon(Icons.account_balance_wallet_outlined),
                text: 'الملخص المالي',
              ),
              Tab(icon: Icon(Icons.picture_as_pdf_outlined), text: 'التقارير'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProfileTab(),
            _buildPropertiesTab(),
            _buildFinancialsTab(),
            _buildReportsTab(),
          ],
        ),
      ),
    );
  }

  // التبويب الأول: الملف الشخصي
  Widget _buildProfileTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailRow('الاسم الكامل', owner.name),
                _buildDetailRow('رقم الهاتف', owner.phone),
                _buildDetailRow('البريد الإلكتروني', owner.email),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // التبويب الثاني: الوحدات العقارية
  Widget _buildPropertiesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: owner.ownedUnitNumbers.length,
      itemBuilder: (context, index) {
        final unit = owner.ownedUnitNumbers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.home)),
            title: Text('الوحدة رقم $unit'),
            subtitle: const Text('الحالة: مؤجرة'), // بيانات وهمية
            trailing: const Text('7500.00 ريال/شهر'),
            onTap: () {
              /* يمكن الانتقال لتفاصيل الوحدة */
            },
          ),
        );
      },
    );
  }

  // التبويب الثالث: الملخص المالي
  Widget _buildFinancialsTab() {
    final numberFormat = NumberFormat.currency(locale: 'ar_SA', symbol: 'ريال');
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildFinancialMetric(
                  'إجمالي الوحدات',
                  owner.totalProperties.toString(),
                ),
                const Divider(),
                _buildFinancialMetric(
                  'إجمالي الإيجار الشهري المتوقع',
                  numberFormat.format(owner.totalMonthlyRent),
                ),
                const Divider(),
                _buildFinancialMetric(
                  'نسبة الإشغال الحالية',
                  '${(owner.occupancyRate * 100).toStringAsFixed(0)}%',
                ),
                const Divider(),
                _buildFinancialMetric(
                  'الدخل هذا الشهر',
                  numberFormat.format(18000),
                  color: Colors.green.shade700,
                ),
                const Divider(),
                _buildFinancialMetric(
                  'مصروفات الصيانة هذا الشهر',
                  numberFormat.format(-550),
                  color: Colors.red.shade700,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // التبويب الرابع: التقارير
  Widget _buildReportsTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'جاهز لتصدير التقارير المالية للمالك',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.download_rounded),
              label: const Text('تصدير تقرير الشهر الحالي (PDF)'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
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

  Widget _buildFinancialMetric(String title, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 15)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
