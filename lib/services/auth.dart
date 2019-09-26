import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const BASE_URL = 'http://172.30.1.22:3000';

class AuthService {
  String token;

  Future<dynamic> authenticate(String email, String password) async {
    final url = '$BASE_URL/auth/signin';

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
      print('token');
      print(token);
      return responseData;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  googleLogin() async {
    final url = '$BASE_URL/auth/google';

    try {
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
