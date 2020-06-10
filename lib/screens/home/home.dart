import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/prefs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String name = '';

  @override
  void initState() {
    void run() async {

      var token = await getPrefToken();
      var data = await getData('https://www.easistent.com/m/me/child', token);
      var d = json.decode(data);
      setState(() {
        name = d['display_name'];
      });

      await getData('https://www.easistent.com/webapp', token);

    }
    run();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        
      ],
    );
  }
}