import 'package:flutter/material.dart';
import 'package:vegasistent/screens/homework/models/homework-item.dart';
import 'package:vegasistent/utils/functions.dart';

class HomeworkWidget extends StatelessWidget {

  HomeworkWidget({ this.homework });
  HomeworkItem homework;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(homework.subject),
              Spacer(),
              Text('Do ${toEUDate(homework.deadline)}')
            ],
          ),
          Text(
            homework.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      )
    );
  }
}