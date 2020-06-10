import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:vegasistent/screens/timetable/widgets/timetable-widget.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/data-parser.dart';
import 'package:vegasistent/utils/prefs.dart';

class Timetable extends StatefulWidget {
  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {

  List timetable = [];

  @override
  void initState() {

    getTimetable(DateTime.now(), DateTime.now().add(new Duration(days: 1)))
    .then((val) {
      setState(() {
        timetable = val[0];
        print(timetable);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: timetable.length,
      itemBuilder: (context, i) {
        return Card(
          elevation: 8,
          color: Color(int.parse(timetable[i]['color'].toString().replaceAll('#', '0xff'))),
          child: TimetableWidget(
            subject: timetable[i]['subject']['name'],
            startTime: new DateTime.now(),
            endTime: new DateTime.now(),
            room: timetable[i]['classroom']['name'],
            teacher: timetable[i]['teachers'][0]['name'],
          ),
        );
      },
    );
  }
}