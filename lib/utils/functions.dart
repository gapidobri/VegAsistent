
import 'package:time_machine/time_machine.dart';

String toEUDate(DateTime date) {
  return '${date.day}. ${date.month}. ${date.year}';
}

String toDashDate(DateTime date) {
  return date.toString().split(' ')[0];
}

String toTime(DateTime date) {
  return '${date.hour}.${date.minute}';
}