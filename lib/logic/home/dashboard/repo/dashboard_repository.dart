import 'dart:convert';

import 'package:hotel_management_app/logic/home/models/room.dart';
import 'package:http/http.dart' as http;

class DashboardRepository {
  Future<List<Room>> fetchUserObjects(String email, String password) async {
    Uri url = Uri.parse(
        'https://megaplus.ge/APPARTMENTS/?ACT=6&MAIL="$email"&PASS="$password"');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body.toString().replaceAll('\'', '"');
      data = data.replaceAll(': None', ': "None"');
      final parsed = json.decode(data);
      return List<Room>.from(parsed.map((model) => Room.fromJson(model)));
    } else {
      throw Exception('არასწორი პაროლი');
    }
  }
}
