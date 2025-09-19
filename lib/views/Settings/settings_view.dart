import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // عدد التبويبات
      child: Scaffold(

      backgroundColor: Colors.white,

        appBar: AppBar(
          title: const Text(
            'الإعدادات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          bottom: const TabBar(
            isScrollable: true,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            tabs: [
              Tab(text: 'الملف الشخصي'),
              Tab(text: 'إعدادات الشركة'),
              Tab(text: 'الإشعارات'),
              Tab(text: 'المظهر واللغة'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProfileSettings(),
            _buildCompanySettings(),
            _buildNotificationsSettings(),
            _buildAppearanceSettings(),
          ],
        ),
      ),
    );
  }

  // التبويب الأول: إعدادات الملف الشخصي
  Widget _buildProfileSettings() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        _buildSettingsCard(
          title: 'معلومات الحساب',
          children: [
            TextFormField(
              initialValue: 'Sarah',
              decoration: const InputDecoration(labelText: 'الاسم الكامل'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'sarah@stay-easy.com',
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('حفظ التغييرات'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSettingsCard(
          title: 'الأمان',
          children: [
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الحالية',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الجديدة',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('تغيير كلمة المرور'),
            ),
          ],
        ),
      ],
    );
  }

  // التبويب الثاني: إعدادات الشركة
  Widget _buildCompanySettings() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        _buildSettingsCard(
          title: 'معلومات الشركة الأساسية',
          children: [
            TextFormField(
              initialValue: 'مؤسسة ديما لإدارة العقارات',
              decoration: const InputDecoration(labelText: 'اسم الشركة'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: '055-123-4567',
              decoration: const InputDecoration(labelText: 'رقم التواصل العام'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'الرياض، المملكة العربية السعودية',
              decoration: const InputDecoration(labelText: 'العنوان'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSettingsCard(
          title: 'العلامة التجارية',
          children: [
            ListTile(
              leading: const Icon(Icons.business_center),
              title: const Text('شعار الشركة'),
              subtitle: const Text('يستخدم في الفواتير والتقارير'),
              trailing: ElevatedButton(
                child: const Text('تغيير الشعار'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  // التبويب الثالث: إعدادات الإشعارات
  Widget _buildNotificationsSettings() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        _buildSettingsCard(
          title: 'إشعارات البريد الإلكتروني',
          children: [
            SwitchListTile(
              title: const Text('طلب صيانة جديد'),
              subtitle: const Text(
                'إرسال بريد إلكتروني عند وصول طلب صيانة جديد.',
              ),
              value: true,
              onChanged: (val) {},
            ),
            SwitchListTile(
              title: const Text('حجز جديد'),
              subtitle: const Text('إرسال بريد إلكتروني عند تأكيد حجز جديد.'),
              value: true,
              onChanged: (val) {},
            ),
            SwitchListTile(
              title: const Text('عقود على وشك الانتهاء'),
              subtitle: const Text('إرسال تذكير قبل 30 يومًا من انتهاء العقد.'),
              value: false,
              onChanged: (val) {},
            ),
          ],
        ),
      ],
    );
  }

  // التبويب الرابع: المظهر واللغة
  Widget _buildAppearanceSettings() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        _buildSettingsCard(
          title: 'مظهر التطبيق',
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('فاتح'),
              value: ThemeMode.light,
              groupValue: ThemeMode.light, // القيمة الحالية
              onChanged: (val) {},
            ),
            RadioListTile<ThemeMode>(
              title: const Text('داكن'),
              value: ThemeMode.dark,
              groupValue: ThemeMode.light,
              onChanged: (val) {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSettingsCard(
          title: 'اللغة',
          children: [
            DropdownButtonFormField<String>(
              value: 'ar',
              items: const [
                DropdownMenuItem(value: 'ar', child: Text('العربية')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (val) {},
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        ),
      ],
    );
  }

  // ويدجت مساعدة لبناء بطاقات الإعدادات بشكل موحد
  Widget _buildSettingsCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}
