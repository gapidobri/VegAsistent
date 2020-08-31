import 'package:flutter/material.dart';

class Offline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Ni povezave",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
