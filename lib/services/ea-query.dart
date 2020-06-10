import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

Future getToken(username, password) async {

  var loginRes = await http.post('https://www.easistent.com/p/ajax_prijava', body: {'uporabnik': username, 'geslo': password});
  var cookie = loginRes.headers['set-cookie'].split(';')[0];

  var tokenRes = await http.get('https://www.easistent.com', headers: { 'cookie': cookie });
  var document = parse(tokenRes.body);

  try {

    String childId = document.head.querySelector('meta[name="x-child-id"]').attributes['content'];
    String bearer = document.head.querySelector('meta[name="access-token"]').attributes['content'];
    return new Tuple3(childId, bearer, cookie);

  } catch (e) {
    print('Something went wrong with getToken() 😥:');
    print(e);
    return null;
  }
  
}

Future<String> getData(url, token) async {

  var data = await http.get(url, headers: {
    'accept': 'application/json, text/html',
    'accept-encoding': 'gzip, deflate, br',
    'accept-language': 'sl-SI,sl;q=0.9,en-GB;q=0.8,en;q=0.7,de;q=0.6',
    'user-agent': 'Mozilla/5.0',
    'authorization': token.item2,
    'x-client-platform': 'web',
    'x-client-version': '13',
    'x-child-id': token.item1,
    'x-requested-with': 'XMLHttpRequest',
    'cookie': token.item3
  });

  try {
    json.decode(data.body)['id'];
    return data.body;
  } catch (e) {
    print('Something went wrong with getData() 😥:');
    print(e);
    return null;
  }
}

Future<bool> isValidToken(token) async {

  try {
    var testData = await getData('https://www.easistent.com/m/me/child', token);
    if (json.decode(testData)['id'] != null) return true;
  } catch (e) {
    print('Something went wrong with isValidToken() 😥:');
    print(e);
    return false;
  }

  return false;
}