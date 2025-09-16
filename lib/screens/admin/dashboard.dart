import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is Dashboard Page",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}
