import 'package:flutter/material.dart';

class OwnersView extends StatefulWidget {
  const OwnersView({super.key});

  @override
  State<OwnersView> createState() => _OwnersViewState();
}

class _OwnersViewState extends State<OwnersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة أصحاب الوحدات')),
      body: const Center(child: Text('إدارة أصحاب الوحدات')),
    );
  }
}
