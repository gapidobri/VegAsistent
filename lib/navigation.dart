import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:vegasistent/screens/calendar/calendar.dart';
import 'package:vegasistent/screens/grades/grades.dart';
import 'package:vegasistent/screens/home/home.dart';
import 'package:vegasistent/screens/homework/homework.dart';
import 'package:vegasistent/screens/not-available.dart';
import 'package:vegasistent/screens/timetable/timetable.dart';

class Navigation extends StatefulWidget {
  Navigation({ this.onLogOut });
  final VoidCallback onLogOut;

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  Widget currentPage = Home();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: currentPage,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      size: 40.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Beta Uporabnik',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Domov'),
              onTap: () {
                setState(() {
                  currentPage = NotAvailable();
                  Navigator.pop(context);
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.calendar_view_day),
              title: Text('Urnik'),
              onTap: () {
                setState(() {
                  currentPage = Timetable();
                  Navigator.pop(context);
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Koledar'),
              onTap: () {
                setState(() {
                  currentPage = NotAvailable();
                  Navigator.pop(context);
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.grade),
              title: Text('Ocene'),
              onTap: () {
                setState(() {
                  currentPage = Grades();
                  Navigator.pop(context);
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.create),
              title: Text('Naloge'),
              onTap: () {
                setState(() {
                  currentPage = Homework();
                  Navigator.pop(context);
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.email),
              title: Text('Sporočila'),
              onTap: () {
                setState(() {
                  currentPage = NotAvailable();
                  Navigator.pop(context);
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.thumbs_up_down),
              title: Text('x360'),
              onTap: () {
                setState(() {
                  currentPage = NotAvailable();
                  Navigator.pop(context);
                });
              },
            ),

            Divider(
              color: Colors.black,
              indent: 8,
              endIndent: 32,
            ),

            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Odjava'),
              onTap: () {
                setState(() {
                  widget.onLogOut();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}