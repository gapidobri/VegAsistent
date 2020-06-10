import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/prefs.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

var eventProvider = EventProvider.list([
  BasicEvent(
    id: 0,
    title: 'Test Event',
    color: Colors.amber,
    start: LocalDate.today().at(LocalTime(13, 0, 0)),
    end: LocalDate.today().at(LocalTime(14, 0, 0)),
  )
]);

final controller = TimetableController(
  eventProvider: eventProvider,
  initialTimeRange: InitialTimeRange.range(
    startTime: LocalTime(8, 0, 0),
    endTime: LocalTime(20, 0, 0),
  ),
  initialDate: LocalDate.today(),
  visibleRange: VisibleRange.week(),
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
            BasicAllDayEventWidget(event, info: info)
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.today),
          onPressed: () => controller.animateToToday(),
        ),
      )
    );
  }
}