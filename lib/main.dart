import 'package:dema/views/home_view.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const DemaDashboard());
}

class DemaDashboard extends StatelessWidget {
  const DemaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: HomeView()));
  }
}
