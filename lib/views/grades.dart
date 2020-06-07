import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:vegasistent/models/grade-widget.dart';
import 'package:vegasistent/query/prefs.dart';
import 'package:vegasistent/query/query.dart';

class Grades extends StatefulWidget {
  @override
  _GradesState createState() => _GradesState();
}

List grades = [];

class _GradesState extends State<Grades> {

  @override
  void initState() {
    void getGrades() async {
      List<Tuple2> gradeData = [];

      Tuple3 token = await getPrefToken();
      var subjects = await getData('https://www.easistent.com/m/grades', token);
      var dec = json.decode(subjects);

      for (var subject in dec['items']) {
        var subjectData = json.decode(await getData('https://www.easistent.com/m/grades/classes/${subject['id']}', token));
        for (var semester in subjectData['semesters']) {
          for (var grade in semester['grades']) {
            gradeData.add(new Tuple2(grade, subject));
          }
        }

      }
      
      setState(() {
        grades = gradeData;
      });
    }
    getGrades();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: grades.length,
        itemBuilder: (BuildContext context, int index) {
          Tuple2 grade = grades[index];

          return Card(
            child: GradeWidget(
              subject: grade.item2['short_name'],
              grade: grade.item1['value'],
            )
          );
        },
      ),
    );
  }
}