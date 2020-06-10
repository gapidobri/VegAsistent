
class HomeworkItem {
  HomeworkItem({this.isExpanded = false, this.title, this.subject, this.content, this.teacher, this.date, this.deadline});

  bool isExpanded;
  String title;
  String subject;
  String content;
  String teacher;
  DateTime date;
  DateTime deadline;

}