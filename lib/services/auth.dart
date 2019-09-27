import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parking_flutter/shared/const.dart';

class AuthService {
  String token;

  Future<dynamic> authenticate(String email, String password) async {
    final url = 'http://$BASE_URL/auth/signin';

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

  saveSocialUser(String provider, String id) async {
    final url = 'http://$BASE_URL/auth/social-login';

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'provider': provider,
          'id': id,
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
}
