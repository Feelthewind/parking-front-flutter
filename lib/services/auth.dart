import 'dart:convert';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:parking_flutter/shared/constants.dart';

class AuthService {
  String token;

  Future<dynamic> getMe() async {
    final url = 'http://$BASE_URL/auth/me';

    try {
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
      return responseData;
    } catch (e) {
      print(e);
      throw e;
    }
  }

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
      token = responseData['accessToken'];
      print(responseData);
      return responseData;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  socialLogin(String provider, GoogleSignInAccount googleUser) async {
    final url = 'http://$BASE_URL/auth/social-login';

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'provider': provider,
          'thirdPartyID': googleUser.id,
          'email': googleUser.email,
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
