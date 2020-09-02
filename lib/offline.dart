import 'package:flutter/material.dart';

class Offline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ni povezave",
              style: TextStyle(fontSize: 50),
            ),
            Text(
              "Uporaba aplikacije brez povezave bo kmalu na voljo",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
