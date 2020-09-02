import 'package:flutter/material.dart';
import 'package:vegasistent/screens/timetable/widgets/timetable-widget.dart';
import 'package:vegasistent/utils/data-parser.dart';
import 'package:vegasistent/widgets/class-modal.dart';
import 'package:vegasistent/widgets/loading.dart';

class Timetable extends StatefulWidget {
  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  Widget loading = Loading();
  List timetable = [];

  @override
  void initState() {
    getTimetable(DateTime.now(), DateTime.now().add(new Duration(days: 1)))
        .then((table) {
      setState(() {
        loading = null;
        timetable = table[0];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ??
        ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: timetable.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 8,
              color: Color(int.parse(
                  timetable[i]['color'].toString().replaceAll('#', '0xff'))),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ClassModal(timetable[i]['event_id'],
                            timetable[i]['time']['date']);
                      });
                },
                child: TimetableWidget(
                  subject: timetable[i]['subject']['name'],
                  startTime: timetable[i]['time']['from'],
                  endTime: timetable[i]['time']['to'],
                  room: timetable[i]['classroom']['name'],
                  teacher: timetable[i]['teachers'][0]['name'],
                  special: timetable[i]['hour_special_type'],
                ),
              ),
            );
          },
        );
  }
}
