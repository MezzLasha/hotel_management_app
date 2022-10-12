import 'package:http/http.dart' as http;

class AuthRepository {
  Future<void> login(String email, String password) async {
    Uri loginUrl = Uri.parse(
        'https://megaplus.ge/APPARTMENTS/?ACT=2&MAIL="$email"&PASS="$password"');
    final response = await http.get(loginUrl);

    if (response.statusCode == 200 && response.body.length > 5) {
      print('logged in!');
    } else {
      throw Exception('არასწორი პაროლი');
    }
  }

  Future<void> register() async {
    print('attempting to register...');
    await Future.delayed(const Duration(seconds: 1));
    print('registered!');
  }
}
