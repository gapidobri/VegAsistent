
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

Future<bool> savePrefToken(Tuple3 token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    prefs.setString('child-id', await token.item1);
    prefs.setString('bearer', await token.item2);
    prefs.setString('cookie', await token.item3);
    return true;
  } catch (e) {
    print('Something went wrong with saveToken() 😥:');
    print(e);
  }
  return false;
}

Future<Tuple3> getPrefToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> token = [];
  try {
    token.add(prefs.getString('child-id'));
    token.add(prefs.getString('bearer'));
    token.add(prefs.getString('cookie'));
    return new Tuple3.fromList(token);
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