import 'package:flutter/material.dart';
import 'package:vegasistent/utils/data-parser.dart';

class ClassModal extends StatefulWidget {
  ClassModal(this.classID, this.date);
  final int classID;
  final String date;

  @override
  _ClassModalState createState() => _ClassModalState();
}

class _ClassModalState extends State<ClassModal> {
  Widget modal;

  @override
  void initState() {
    getTimetable(DateTime.parse(widget.date), DateTime.parse(widget.date))
        .then((table) {
      setState(() {
        var c = table[0].firstWhere((el) => el['event_id'] == widget.classID);
        modal = Column(
          children: [
            Row(
              children: [
                Text(
                  c['time']['from'],
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text(
                  c['time']['to'],
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Text(
              c['subject']['name'],
              style: TextStyle(fontSize: 35),
            ),
            Text(
              c['teachers'][0]['name'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        );
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(20), child: modal);
  }
}
