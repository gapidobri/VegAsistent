import 'package:flutter/material.dart';

TextStyle smallText = TextStyle(color: Colors.white, fontSize: 13);

class TimetableWidget extends StatelessWidget {

  TimetableWidget({ this.subject, this.startTime, this.endTime, this.room, this.teacher });

  final String subject;
  final String startTime;
  final String endTime;
  final String room;
  final String teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(startTime, style: smallText),
              Text(subject, style: TextStyle(fontSize: 25, color: Colors.white)),
              Text(endTime, style: smallText),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(room, style: smallText),
              Icon(Icons.edit, color: Colors.white),
              Text(teacher, style: smallText),
            ],
          ),
        ],
      ),
    );
  }
}