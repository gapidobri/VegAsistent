import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vegasistent/models/token.dart';
import 'package:vegasistent/screens/grades/widgets/grade-widget.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/prefs.dart';
import 'package:vegasistent/widgets/loading.dart';

class Grades extends StatefulWidget {
  @override
  _GradesState createState() => _GradesState();
}

Widget loading = Loading();
List grades = [];

class _GradesState extends State<Grades> {

  @override
  void initState() {
    void getGrades() async {
      Token token = await getPrefToken();
      var subjects = await getData('https://www.easistent.com/m/grades', token);
      var dec = json.decode(subjects);

      grades.clear();
      for (var subject in dec['items']) {
        var subjectData = json.decode(await getData('https://www.easistent.com/m/grades/classes/${subject['id']}', token));
        for (var semester in subjectData['semesters']) {
          for (var grade in semester['grades']) {
            grades.add({
              'grade': grade,
              'semester': semester,
              'subject': subject
            });
          }
        }
      }
      setState(() {
        loading = null;
      });
    }
    getGrades();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ?? ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: grades.length,
        itemBuilder: (context, index) {
          var grade = grades[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
            elevation: 8,
            child: GradeWidget(
              subject: grade['subject']['name'],
              shortSubject: grade['subject']['short_name'],
              grade: int.parse(grade['grade']['value']),
              date: DateTime.parse(grade['grade']['date']),
              teacher: grade['grade']['inserted_by']['name'],
              
              // TODO The average of the grades is useless as you are not grouping the grades by subject.

              // average: double.parse(grade['subject']['average_grade'].toString().replaceAll(',', '.')),
            )
          );
        },
    );
  }
}