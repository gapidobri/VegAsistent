import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:vegasistent/login.dart';
import 'package:vegasistent/navigation.dart';
import 'package:vegasistent/services/ea-query.dart';
import 'package:vegasistent/utils/prefs.dart';
import 'package:vegasistent/widgets/loading.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VegAsistent',
      home: Router(),
    );
  }
}

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {

  Widget view = Container(
    color: Colors.white,
    child: Center(
      child: Loading()
    ),
  );

  Future<bool> isLoggedIn() async {
    try {
      Tuple3 token = await getPrefToken();
      return await isValidToken(token);
    } catch (e) {
      print('Something went wrong with isLoggedIn() 😥:');
      print(e);
    }
    return false;
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }
  
  void _checkLogin() async {
    try {
      Tuple3 token = await getPrefToken();
      if (await isValidToken(token)) {
        setState(() {
          view = Navigation(
            onLogOut: () async {
              await prefLogout();
              _checkLogin();
            }
          );
        });
        return;
      }
    } catch (e) {
      print('Something went wrong with isLoggedIn() 😥:');
      print(e);
    }
    setState(() {
      view = Login(onSignedIn: _checkLogin);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return view;
  }
}