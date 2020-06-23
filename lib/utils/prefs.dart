
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegasistent/models/token.dart';

Future<bool> savePrefToken(Token token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    prefs.setString('child-id', token.childId);
    prefs.setString('bearer', token.bearerToken);
    prefs.setString('cookie', token.cookie);
    return true;
  } catch (e) {
    print('Something went wrong with saveToken() 😥:');
    print(e);
  }
  return false;
}

Future<Token> getPrefToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    return Token(
      prefs.getString('child-id'),
      prefs.getString('bearer'),
      prefs.getString('cookie')
    );
  } catch (e) {
    print('Something went wrong with getToken() 😥:');
    print(e);
    return null;
  }
}

Future<bool> prefLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    prefs.remove('child-id');
    prefs.remove('bearer');
    prefs.remove('cookie');
    return true;
  } catch (e) {
    print('Something went wrong with prefLogout() 😥:');
    print(e);
    return false;
  }
  
}