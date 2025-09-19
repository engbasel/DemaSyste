import 'package:dema/views/booking/BookingsView.dart';
import 'package:dema/views/Dashboard/DashboardContent.dart';
import 'package:dema/views/Rooms/RoomsView.dart';
import 'package:dema/views/Settings/SettingsView.dart';
import 'package:dema/views/Navbar/SideNavigationBar.dart';
import 'package:dema/views/calender/CalendarView.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            // Mobile layout would typically use a Drawer and AppBar
            return Scaffold(
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

class MaintenanceRequestsView extends StatelessWidget {
  const MaintenanceRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('طلبات الصيانة')));
  }
}

class ResidentsView extends StatelessWidget {
  const ResidentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('إدارة المستأجرين')));
  }
}

class FinancialReportsView extends StatelessWidget {
  const FinancialReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('التقارير المالية')));
  }
}
