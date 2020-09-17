import 'dart:convert';
import 'dart:io';

String toEUDate(DateTime date) {
  return '${date.day}. ${date.month}. ${date.year}';
}

String toDashDate(DateTime date) {
  return date.toString().split(' ')[0];
}

String toTime(DateTime date) {
  return '${date.hour}.${date.minute}';
}

dynamic idToTime(int id, List timetable) {
  return timetable.firstWhere((e) => e['id'] == id)['time'];
}

Future<bool> online() async {
  final result = await InternetAddress.lookup('www.easistent.com');
  return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
}
