import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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
  String dateTime;
  List timetableAll = [];

  @override
  void initState() {
    initializeDateFormatting("sl_SI", null).then((value) {
      dateTime = DateFormat("EEEE, d. M. y", "sl_SI").format(DateTime.now());
    });
    getTimetable(DateTime.now(), DateTime.now().add(new Duration(days: 7)))
        .then((table) {
      setState(() {
        loading = null;
        timetableAll = table;
      });
    });
    super.initState();
  }

  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return loading ??
        Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  spreadRadius: 0,
                )
              ]),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      controller.animateToPage(
                        controller.page.round() - 1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                  Spacer(),
                  Text(
                    dateTime,
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      controller.animateToPage(
                        controller.page.round() + 1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                //physics: NeverScrollableScrollPhysics(),
                itemCount: 7,
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    dateTime = DateFormat("EEEE, d. M. y", "sl_SI").format(
                        DateTime.now()
                            .add(new Duration(days: controller.page.round())));
                  });
                },
                itemBuilder: (context, index) {
                  List _timetable = timetableAll[index];
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: _timetable.length,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 8,
                          color: Color(int.parse(_timetable[i]['color']
                              .toString()
                              .replaceAll('#', '0xff'))),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ClassModal(_timetable[i]['event_id'],
                                        _timetable[i]['time']['date']);
                                  });
                            },
                            child: TimetableWidget(
                              subject: _timetable[i]['subject']['name'],
                              startTime: _timetable[i]['time']['from'],
                              endTime: _timetable[i]['time']['to'],
                              room: _timetable[i]['classroom']['name'],
                              teacher: _timetable[i]['teachers'][0]['name'],
                              special: _timetable[i]['hour_special_type'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
  }
}
