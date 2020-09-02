import 'package:flutter/material.dart';

TextStyle smallText = TextStyle(color: Colors.white, fontSize: 13);

class TimetableWidget extends StatelessWidget {
  TimetableWidget(
      {this.subject,
      this.startTime,
      this.endTime,
      this.room,
      this.teacher,
      this.special});

  final String subject;
  final String startTime;
  final String endTime;
  final String room;
  final String teacher;
  final String special;

  @override
  Widget build(BuildContext context) {
    Widget icon;

    switch (special) {
      case 'substitution':
        icon = Icon(Icons.sync, color: Colors.white);
        break;

      case 'exam':
        icon = Icon(Icons.grade, color: Colors.white);
        break;

      case 'test':
        icon = Icon(Icons.check, color: Colors.white);
        break;

      case 'event':
        icon = Icon(Icons.event, color: Colors.white);
        break;

      default:
        icon = null;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(startTime, style: smallText),
              Text(subject,
                  style: TextStyle(fontSize: 25, color: Colors.white)),
              Text(endTime, style: smallText),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(room, style: smallText),
              SizedBox(
                height: 25,
                child: icon,
              ),
              Text(teacher, style: smallText),
            ],
          ),
        ],
      ),
    );
  }
}
