enum EntryType {
  entry,
  praise,
}

class PAIItem {
  
  PAIItem({ this.isExpanded = false, this.teacher, this.subject, this.category, this.date, this.content, this.type });

  bool isExpanded;
  String teacher;
  String subject;
  String category;
  DateTime date;
  String content;
  EntryType type;

}