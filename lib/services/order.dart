import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/services/auth.dart';

const BASE_URL = '172.30.1.22:3000';

class OrderService {
  AuthService authService = locator<AuthService>();

  Future<void> orderParking(Map<String, dynamic> order) async {
    var uri = Uri.http(BASE_URL, '/order');
    var response = await http.post(uri,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(order));

    print(response.body);
    // return OrderEntity.fromJson(jsonDecode(response.body));
  }
}
