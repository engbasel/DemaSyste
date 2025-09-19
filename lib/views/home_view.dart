import 'package:dema/views/Financial/financial_reports_view.dart';
import 'package:dema/views/Maintenance/maintenance_requests_view.dart';
import 'package:dema/views/Owners/owners_view.dart';
import 'package:dema/views/Residents/residents_view.dart';
import 'package:dema/views/booking/bookings_view.dart';
import 'package:dema/views/Dashboard/dashboard_content.dart';
import 'package:dema/views/Rooms/rooms_view.dart';
import 'package:dema/views/Settings/settings_view.dart';
import 'package:dema/views/Navbar/side_navigation_bar.dart';
import 'package:dema/views/calender/calendar_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  // List of widgets to display based on the selected index
  static const List<Widget> _widgetOptions = <Widget>[
    // اللوحة الرئيسية
    DashboardContent(),
    // التقويم
    CalendarView(),
    // الحجوزات
    BookingsView(),

    // الوحدات العقارية
    RoomsView(),

    // إدارة المستأجرين
    ResidentsView(),
    // إدارة أصحاب الوحدات
    OwnersView(),
    // طلبات الصيانة
    MaintenanceRequestsView(),

    // التقارير المالية
    FinancialReportsView(),
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    // Check to avoid navigating to settings from the bottom of the bar
    if (index < 4) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      // Handle settings navigation separately if needed, for now it's just another screen
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            // Mobile layout would typically use a Drawer and AppBar
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(title: const Text('StayEasy')),
              drawer: SideNavigationBar(
                selectedIndex: _selectedIndex,
                onItemSelected: _onItemTapped,
              ),
              body: _widgetOptions.elementAt(_selectedIndex),
            );
          } else {
            // Desktop/Tablet layout
            return Row(
              children: [
                SideNavigationBar(
                  selectedIndex: _selectedIndex,
                  onItemSelected: _onItemTapped,
                ),
                Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
              ],
            );
          }
        },
      ),
    );
  }
}
