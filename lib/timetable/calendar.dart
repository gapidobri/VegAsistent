import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final eventProvider = EventProvider.list([
      BasicEvent(
        id: 0,
        title: 'SLO',
        color: Colors.blue,
        start: LocalDate.today().at(LocalTime(13, 0, 0)),
        end: LocalDate.today().at(LocalTime(15, 0, 0)),
      ),
      BasicEvent(
        id: 1,
        title: 'MAT',
        color: Colors.green,
        start: LocalDate.today().at(LocalTime(2, 0, 0)),
        end: LocalDate.today().at(LocalTime(5, 0, 0)),
      )
    ]);

    final myController = TimetableController(
      eventProvider: eventProvider,
      // Optional parameters with their default values:
      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(8, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.week(),
      firstDayOfWeek: DayOfWeek.monday,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Urnik'),
      ),
      body: Timetable<BasicEvent>(
        controller: myController,
        eventBuilder: (event) => BasicEventWidget(event),
        allDayEventBuilder: (context, event, info) =>
            BasicAllDayEventWidget(event, info: info),
      )
    );
  }
}