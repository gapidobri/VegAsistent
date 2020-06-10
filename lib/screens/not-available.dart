import 'package:flutter/material.dart';

class NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Kmalu na voljo',
        style: TextStyle(
          fontSize: 30
        ),
      ),
    );
  }
}