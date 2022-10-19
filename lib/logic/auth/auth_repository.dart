// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:hotel_management_app/logic/auth/Models/user.dart';

class AuthRepository {
  Future<User> login(String email, String password) async {
    Uri loginUrl = Uri.parse(
        'https://megaplus.ge/APPARTMENTS/?ACT=2&MAIL="$email"&PASS="$password"');
    final response = await http.get(loginUrl);

    if (response.statusCode == 200 && response.body.length > 5) {
      if (kDebugMode) {
        print('logged in!');
      }
      var userdata = response.body
          .replaceAll('\'', '"')
          .substring(1, response.body.length - 1);
      if (kDebugMode) {
        print(userdata);
      }
      var user = User.fromJson(userdata);
      return user;
    } else {
      throw Exception('არასწორი პაროლი');
    }
  }

  Future<User> register(String email, String password, String name, String said,
      String tel, String lang, String comment, int active) async {
    Uri registerUrl = Uri.parse(
        'https://megaplus.ge/APPARTMENTS/?ACT=3&MAIL="$email"&PASS="$password"&NAME="$name"&SAID="$said"&TEL="$tel"&LANG=""&COMMENT=""&ACTIVE=1');

    if (kDebugMode) {
      print(registerUrl);
    }
    final response = await http.get(registerUrl);

    if (response.statusCode == 200 && response.body.toString() == 'OK') {
      var user = User(
          active: 1,
          mail: email,
          password: password,
          name: name,
          identification: said,
          id: 1,
          comment: '',
          lang: '',
          phone: tel);
      return user;
    } else {
      throw Exception(response.body.toString());
    }
  }
}
