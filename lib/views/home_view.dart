import 'package:dema/views/BookingsView.dart';
import 'package:dema/views/DashboardContent.dart';
import 'package:dema/views/RoomsView.dart';
import 'package:dema/views/SettingsView.dart';
import 'package:dema/views/SideNavigationBar.dart';
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
    DashboardContent(),
    CalendarView(),
    BookingsView(),
    RoomsView(),
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

class PlaceholderView extends StatelessWidget {
  const PlaceholderView({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
