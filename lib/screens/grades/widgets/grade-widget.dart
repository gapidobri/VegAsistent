import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vegasistent/utils/functions.dart';

class GradeWidget extends StatelessWidget {

  GradeWidget({ this.subject, this.shortSubject, this.grade, this.date, this.average, this.teacher });

  final String subject;
  final String shortSubject;
  final int grade;
  final DateTime date;
  final double average;
  final String teacher;

  final List<Color> gradeColors = [
    Colors.red, // Grade 1
  	Colors.orange, // Grade 2
    Colors.yellow, // Grade 3
    Colors.lightGreen, // Grade 4
    Colors.green // Grade 5
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundColor: gradeColors[grade - 1],
            child: Text(
              grade.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: AutoSizeText(
              subject,
              style: TextStyle(
                fontSize: 25,
              ),
              minFontSize: 25,
              maxLines: 1,
              overflowReplacement: Text(
                shortSubject,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(teacher),
              Text(toEUDate(date)),
              SizedBox(height: 8),
              CircleAvatar(
                backgroundColor: gradeColors[average.round() - 1],
                child: Text(
                  average.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}