import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vegasistent/query/prefs.dart';
import 'package:vegasistent/query/query.dart';

class Homework extends StatefulWidget {
  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {

    void getHomework() async {
      var token = await getPrefToken();
      var data = await getData('https://www.easistent.com/m/homework', token);
      var homework = json.decode(data);
      print(data);
      
    }

    getHomework();

    return SafeArea(
      child: Center(

      ),
    );
  }
}