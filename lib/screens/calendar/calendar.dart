import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/data-parser.dart';
import 'package:vegasistent/utils/prefs.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

List evaluations = [];

EventProvider eventStream = EventProvider.stream(
  eventGetter: (dates) async* {
    List<BasicEvent> lessons = [];

    for (List day in await getTimetable(dates.start.toDateTimeUnspecified(),
        dates.end.toDateTimeUnspecified())) {
      for (var lesson in day) {
        String start = lesson['time']['date'] + ' ' + lesson['time']['from'];
        String end = lesson['time']['date'] + ' ' + lesson['time']['to'];

        lessons.add(
          BasicEvent(
            id: Random(),
            title: lesson['subject']['name'],
            color: Color(
                int.parse(lesson['color'].toString().replaceAll('#', '0xff'))),
            start: LocalDateTime.dateTime(DateTime.parse(start))
                .addHours(2), //TODO: Fix timezone problem
            end: LocalDateTime.dateTime(DateTime.parse(end))
                .addHours(2), //TODO: Fix timezone problem
          ),
        );
      }
    }

    yield lessons;
  },
);

final controller = TimetableController(
  eventProvider: eventStream,
  initialTimeRange: InitialTimeRange.range(
    startTime: LocalTime(6, 0, 0),
    endTime: LocalTime(16, 0, 0),
  ),
  initialDate: LocalDate.today(),
  visibleRange: VisibleRange.days(5),
  firstDayOfWeek: DayOfWeek.monday,
);

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    void getLessons() async {
      var token = await getPrefToken();
      await getData('https://www.easistent.com/m/me/child', token);
    }

    getLessons();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Timetable(
          controller: controller,
          eventBuilder: (event) => BasicEventWidget(event),
          allDayEventBuilder: (context, event, info) =>
              BasicAllDayEventWidget(event, info: info)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.today),
        onPressed: () => controller.animateTo(LocalDate.today()),
      ),
    ));
  }
}
