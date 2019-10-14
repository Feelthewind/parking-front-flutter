import 'dart:io';

import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parking_flutter/models/error_response.dart';
import 'package:parking_flutter/models/user.dart';
import 'package:parking_flutter/shared/constants.dart';

class AuthService {
  Dio dio = Dio();
  String token;

  Future<dynamic> getMe() async {
    final url = 'http://$BASE_URL/auth/me';

    try {
      final response = await dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }),
      );
      return User.fromJson(response.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return ErrorResponse.fromJson(e.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }
  }

  Future<dynamic> authenticate(String email, String password) async {
    final url = 'http://$BASE_URL/auth/signin';

    try {
      final response = await dio.post(
        url,
        data: {'email': email, 'password': password},
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }),
      );
      print(response.data);
      final user = User.fromJson(response.data);
      token = user.accessToken;
      return user;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return ErrorResponse.fromJson(e.response.data);
      } else {
        print(e.request);
        print(e.message);
      }
    }
  }

  Future<dynamic> socialLogin(
      String provider, GoogleSignInAccount googleUser) async {
    final url = 'http://$BASE_URL/auth/social-login';

    try {
      final response = await dio.post(
        url,
        data: {
          'provider': provider,
          'thirdPartyID': googleUser.id,
          'email': googleUser.email,
        },
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }),
      );
      final user = User.fromJson(response.data);
      token = user.accessToken;
      return user;
    } on DioError catch (e) {
      if (e.response != null) {
        return ErrorResponse.fromJson(e.response.data);
      } else {
        print(e.request);
        print(e.message);
      }
    }
  }
}
