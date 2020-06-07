import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:vegasistent/main.dart';
import 'package:vegasistent/query/prefs.dart';
import 'package:vegasistent/query/query.dart';

class Login extends StatefulWidget {
  Login({ this.onSignedIn });
  final VoidCallback onSignedIn;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) => 
          SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.alternate_email),
                        labelText: 'E-mail',
                      ),
                      validator: (val) => val.isEmpty ? 'Prosim vpiši e-mail naslov' : null,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        labelText: 'Geslo',
                      ),
                      validator: (val) => val.isEmpty ? 'Prosim vpiši geslo' : null,
                    ),
                    SizedBox(height: 8.0),
                    RaisedButton(
                      child: Text('Prijava'),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          Tuple3 token = await getToken(emailController.text, passwordController.text);
                          if (!await savePrefToken(token)) {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Napačni podatki za prijavo')));
                            return;
                          }
                          widget.onSignedIn();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}