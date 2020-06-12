import 'package:flutter/material.dart';
import 'package:vegasistent/screens/homework/models/homework-item.dart';
import 'package:vegasistent/utils/functions.dart';

class HomeworkContentWidget extends StatelessWidget {

  HomeworkContentWidget({ this.homework });
  final HomeworkItem homework;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(homework.content),
          Row(
            children: [
              Text(
                'Objavljeno ${toEUDate(homework.date)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Spacer(),
              Text(
                homework.teacher,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          
        ],
      )
    );
  }
}