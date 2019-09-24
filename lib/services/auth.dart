import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AuthService {
  String token;

  Future<dynamic> authenticate(String email, String password) async {
    final url = 'http://172.30.1.54:3000/auth/signin';

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
      token = responseData['accessToken'];
      return responseData;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
