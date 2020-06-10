import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:vegasistent/screens/homework/models/homework-item.dart';
import 'package:vegasistent/screens/homework/widgets/homework-content-widget.dart';
import 'package:vegasistent/screens/homework/widgets/homework-widget.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/data-parser.dart';
import 'package:vegasistent/utils/prefs.dart';
import 'package:vegasistent/widgets/loading.dart';

class Homework extends StatefulWidget {
  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {

  Widget loading = Loading();
  List<HomeworkItem> _items = [];

  @override
  void initState() {
    getHomework().then((homework) {
      setState(() {
        loading = null;
        _items = List.from(homework).map((e) {
          return HomeworkItem(
            title: e['title'],
            subject: e['subject'],
            content: e['content'],
            teacher: e['author'],
            date: DateTime.parse(e['date']),
            deadline: DateTime.parse(e['deadline']),
          );
        }).toList();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ?? ListView(
      padding: EdgeInsets.all(8),
      children: [
        ExpansionPanelList(
          expansionCallback: (i, isExpanded) {
            setState(() {
              _items[i].isExpanded = !_items[i].isExpanded;
            });
          },
          children: _items.map((HomeworkItem item) {
            return ExpansionPanel(
              headerBuilder: (context, isExpanded) => HomeworkWidget(homework: item),
              isExpanded: item.isExpanded,
              body: HomeworkContentWidget(homework: item)
            );
          }).toList(),
        ),
      ],
    );
  }
}