import 'package:dema/views/DashboardContent.dart';
import 'package:dema/views/SideNavigationBar.dart';
import 'package:flutter/material.dart';

// Main function to run the app
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // For responsive layout, we can use LayoutBuilder
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            // Mobile layout with a Drawer
            return const DashboardContent(); // Simplified for mobile for now
          } else {
            // Desktop/Tablet layout
            return Row(
              children: const [
                SideNavigationBar(),
                Expanded(child: DashboardContent()),
              ],
            );
          }
        },
      ),
    );
  }
}
