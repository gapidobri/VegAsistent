import 'package:flutter/material.dart';
import 'package:vegasistent/screens/calendar/calendar.dart';
import 'package:vegasistent/screens/grades/grades.dart';
import 'package:vegasistent/screens/homework/homework.dart';
import 'package:vegasistent/screens/pai/pai.dart';
import 'package:vegasistent/screens/timetable/timetable.dart';
import 'package:vegasistent/widgets/not-available.dart';

class Navigation extends StatefulWidget {
  Navigation({this.onLogOut});
  final VoidCallback onLogOut;

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;

  List<Page> pages = [
    Page(name: 'Domov', icon: Icons.home, page: NotAvailable()),
    Page(name: 'Urnik', icon: Icons.calendar_view_day, page: Timetable()),
    Page(name: 'Koledar', icon: Icons.calendar_today, page: Calendar()),
    Page(name: 'Ocene', icon: Icons.grade, page: Grades()),
    Page(name: 'Naloge', icon: Icons.create, page: Homework()),
    Page(name: 'Sporočila', icon: Icons.message, page: NotAvailable()),
    Page(name: 'x360', icon: Icons.thumbs_up_down, page: PAI()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[currentPage].name),
      ),
      body: pages[currentPage].page,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(
              children: pages.map((e) {
                return ListTile(
                    leading: Icon(e.icon),
                    title: Text(e.name),
                    onTap: () {
                      setState(() {
                        currentPage = pages.indexOf(e);
                        Navigator.pop(context);
                      });
                    });
              }).toList(),
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

class Page {
  Page({this.name, this.icon, this.page});
  final String name;
  final IconData icon;
  final Widget page;
}
