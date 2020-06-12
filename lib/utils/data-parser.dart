
import 'dart:convert';

import 'package:tuple/tuple.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/functions.dart';
import 'package:vegasistent/utils/prefs.dart';

Future getTimetable(DateTime startDate, DateTime endDate) async {

  Tuple3 token = await getPrefToken();
  List days = [];

  var timetableData = json.decode(await getData('https://www.easistent.com/m/timetable/weekly?from=${toDashDate(startDate)}&to=${toDashDate(endDate)}', token));
  
  List timetable = timetableData['time_table'];
  List schoolHourEvents = timetableData['school_hour_events'];

  schoolHourEvents.sort((a, b) {
    DateTime dateA = DateTime.parse(a['time']['date']);
    DateTime dateB = DateTime.parse(b['time']['date']);
    return dateA.compareTo(dateB);
  });

  for (var lesson in schoolHourEvents) {
    lesson['time']['from'] = timetable.firstWhere((e) => lesson['time']['from_id'] == e['id'])['time']['from'];
    lesson['time']['to'] = timetable.firstWhere((e) => lesson['time']['to_id'] == e['id'])['time']['to'];
  }

  for (var i = 0; i < endDate.difference(startDate).inDays + 1; i++) {
    List day = schoolHourEvents.where((lesson) {
      return lesson['time']['date'] == toDashDate(startDate.add(new Duration(days: i)));
    }).toList();
    days.add(day);
  }

  return days;
}

Future getHours() async {

}

Future getEvaluations() async {
  Tuple3 token = await getPrefToken();
  var futureEvaluations = json.decode(await getData('https://www.easistent.com/m/evaluations?filter=future', token))['items'];
  var pastEvaluations = json.decode(await getData('https://www.easistent.com/m/evaluations?filter=past', token))['items'];

  
}

Future getHomework() async {
  
  Tuple3 token = await getPrefToken();
  List homeworkList = [];
  
  var subjects = json.decode(await getData('https://www.easistent.com/m/homework', token))['items'];

  for (var subject in subjects) {
    var homeworks = json.decode(await getData('https://www.easistent.com/m/homework/classes/${subject['class_id']}', token))['items'];
    for (var homework in homeworks) {
      var detail = json.decode(await getData('https://www.easistent.com/m/homework/${homework['id']}', token));
      homeworkList.add(detail);
    }
  }
  return homeworkList;
}

Future getPAI() async {
  Tuple3 token = await getPrefToken();
  return json.decode(await getData('https://www.easistent.com/m/praises_and_improvements', token))['items'];
}