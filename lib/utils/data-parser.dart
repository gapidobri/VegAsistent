import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:vegasistent/models/token.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/functions.dart';
import 'package:vegasistent/utils/prefs.dart';

Future getChild() async {
  return json.decode(await getData(
      'https://www.easistent.com/m/me/child', await getPrefToken()));
}

Future getFullDetails() async {
  Document document = parse(await getData(
      'https://www.easistent.com/nastavitve_uporabnika', await getPrefToken()));

  String _getField(String detailName) {
    return document
        .getElementById('nastavitve_uporabnika-osebni_podatki-$detailName')
        .attributes['value'];
  }

  String id = document
      .getElementsByClassName("collapse")[4]
      .children[0]
      .children[1]
      .children[1]
      .children[0]
      .innerHtml;

  String profilePictureURL =
      document.getElementsByClassName('profilna_slika').first.attributes['src'];

  return {
    'id': id,
    'picture': profilePictureURL,
    'name': _getField('ime'),
    'surname': _getField('priimek'),
  };
}

Future<List> getTimetable(DateTime startDate, DateTime endDate) async {
  if (!await online()) return getPrefTimetable(startDate, endDate);

  Token token = await getPrefToken();
  List days = [];

  var timetableData = json.decode(await getData(
      'https://www.easistent.com/m/timetable/weekly?from=${toDashDate(startDate)}&to=${toDashDate(endDate)}',
      token));

  List timetable = timetableData['time_table'];
  List schoolHourEvents = timetableData['school_hour_events'];

  for (var lesson in schoolHourEvents) {
    lesson['time']['from'] =
        idToTime(lesson['time']['from_id'], timetable)['from'];
    lesson['time']['to'] = idToTime(lesson['time']['to_id'], timetable)['to'];
  }

  schoolHourEvents.sort((a, b) {
    DateTime dateA =
        DateTime.parse('${a['time']['date']} ${a['time']['from']}');
    DateTime dateB =
        DateTime.parse('${b['time']['date']} ${b['time']['from']}');
    return dateA.compareTo(dateB);
  });

  for (var i = 0; i < endDate.difference(startDate).inDays + 1; i++) {
    List day = schoolHourEvents.where((lesson) {
      return lesson['time']['date'] ==
          toDashDate(startDate.add(new Duration(days: i)));
    }).toList();
    days.add(day);
  }

  return days;
}

Future getHours() async {}

Future<JsonCodec> getFutureEvaluations() async {
  return json.decode(await getData(
      'https://www.easistent.com/m/evaluations?filter=future',
      await getPrefToken()))['items'];
}

Future<JsonCodec> getPastEvaluations() async {
  return json.decode(await getData(
      'https://www.easistent.com/m/evaluations?filter=past',
      await getPrefToken()))['items'];
}

Future<List> getHomework() async {
  Token token = await getPrefToken();
  List homeworkList = [];

  var subjects = json.decode(
      await getData('https://www.easistent.com/m/homework', token))['items'];

  for (var subject in subjects) {
    var homeworks = json.decode(await getData(
        'https://www.easistent.com/m/homework/classes/${subject['class_id']}',
        token))['items'];
    for (var homework in homeworks) {
      var detail = json.decode(await getData(
          'https://www.easistent.com/m/homework/${homework['id']}', token));
      homeworkList.add(detail);
    }
  }
  return homeworkList;
}

Future<Iterable> getPAI() async {
  return json.decode(await getData(
      'https://www.easistent.com/m/praises_and_improvements',
      await getPrefToken()))['items'];
}

Future getMessages() async {
  Document document = parse(await getData(
      'https://www.easistent.com/sporocila', await getPrefToken()));
  print(document.getElementsByClassName('obvestila-seznam-aktivno-prebrano'));
}
