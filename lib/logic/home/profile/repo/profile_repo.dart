import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hotel_management_app/logic/auth/Models/user.dart';

class ProfileRepo {
  Future<User> changeData(User user, String oldPassword) async {
    Uri loginUrl = Uri.parse(
        'https://megaplus.ge/APPARTMENTS/?ACT=4&MAIL="${user.mail}"&PASS="${oldPassword}"&NAME="${user.name}"&SAID="${user.identification}"&TEL="${user.phone}"&LANG="${user.lang}"&ACTIVE="${user.active}"&COMMENT="${user.comment}"&PASSNEW="${user.password}"');
    final response = await http.get(loginUrl);

    if (response.statusCode == 200 && response.body.toString() == 'OK') {
      if (kDebugMode) {
        print('Changed data!');
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedUser', user.toJson());

      return user;
    } else {
      throw Exception('შეცდომა შეცვლისას');
    }
  }
}
