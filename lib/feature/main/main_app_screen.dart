import 'package:flutter/material.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Main App Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
