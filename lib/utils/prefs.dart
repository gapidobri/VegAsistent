import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegasistent/models/token.dart';
import 'package:vegasistent/utils/data-parser.dart';
import 'package:vegasistent/utils/functions.dart';

Future<bool> savePrefToken(Token token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    prefs.setString('child-id', token.childId);
    prefs.setString('bearer', token.bearerToken);
    prefs.setString('cookie', token.cookie);
    return true;
  } catch (e) {
    print('Something went wrong with saveToken() 😥:');
    print(e);
  }
  return false;
}

Future<Token> getPrefToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    return Token(prefs.getString('child-id'), prefs.getString('bearer'),
        prefs.getString('cookie'));
  } catch (e) {
    print('Something went wrong with getToken() 😥:');
    print(e);
    return null;
  }
}

Future<bool> prefLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    prefs.remove('child-id');
    prefs.remove('bearer');
    prefs.remove('cookie');
    return true;
  } catch (e) {
    print('Something went wrong with prefLogout() 😥:');
    print(e);
    return false;
  }
}

Future<bool> savePrefTimetable(DateTime from, DateTime to) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tt = await getTimetable(from, to);

  try {
    tt.forEach((day) {
      if (day.length == 0) return;
      prefs.setString(day[0]['time']['date'], json.encode(day));
    });
    return true;
  } catch (e) {
    print('Something went wrong with savePrefTimetable() 😥:');
    print(e);
    return false;
  }
}

Future<List> getPrefTimetable(DateTime from, DateTime to) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List days = [];
  int diff = to.difference(from).inDays;
  try {
    for (var i = 0; i < diff; i++) {
      var date = toDashDate(from.add(new Duration(days: i)));
      if (!prefs.containsKey(date)) break;
      var day = prefs.get(date);
      //print(List.from(json.decode(day)).map((e) => e['subject']['name']));
      days.add(json.decode(day));
    }
    return days;
  } catch (e) {
    print('Something went wrong with getPrefTimetable() 😥:');
    print(e);
    return [];
  }
}
