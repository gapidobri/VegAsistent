import 'package:flutter/material.dart';

class GradeWidget extends StatelessWidget {

  GradeWidget({ this.subject, this.grade });

  final String subject;
  final String grade;

  final List<Color> gradeColors = [
    Colors.red, // Grade 1
  	Colors.orange, // Grade 2
    Colors.yellow, // Grade 3
    Colors.lightGreen, // Grade 4
    Colors.green // Grade 5
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: gradeColors[int.parse(grade) - 1],
            child: Text(
              grade,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            subject,
            style: TextStyle(
              fontSize: 20
            ),
          ),
        ],
      ),
    );
  }
}