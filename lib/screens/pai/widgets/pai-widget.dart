import 'package:flutter/material.dart';
import 'package:vegasistent/screens/pai/models/pai-item.dart';
import 'package:vegasistent/utils/functions.dart';

class PAIWidget extends StatelessWidget {
  PAIWidget({ this.pai });
  final PAIItem pai;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(pai.type == EntryType.entry ? Icons.thumb_down : Icons.thumb_up),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pai.category,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(toEUDate(pai.date)),
                  SizedBox(width: 24),
                  Text(pai.subject),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}