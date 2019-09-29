import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/order.dart';
import 'package:parking_flutter/services/auth.dart';
import 'package:parking_flutter/shared/constants.dart';

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

  Future<OrderEntity> getLatestOrder() async {
    try {
      var uri = Uri.http(BASE_URL, '/order');
      var response = await http.get(
        uri,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json',
        },
      );

      print(response.body);
      return OrderEntity.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<OrderEntity> extendOrderTime(int orderId, int timeToExtend) async {
    print('extendOrderTime called');
    print(orderId);
    print(timeToExtend);
    try {
      var uri = Uri.http(BASE_URL, '/order/extention/${orderId.toString()}');
      var response = await http.patch(
        uri,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"timeToExtend": timeToExtend.toString()}),
      );

      print(response.body);
      return OrderEntity.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> cancelOrder(int orderId) async {
    try {
      var uri = Uri.http(BASE_URL, '/order/cancel/${orderId.toString()}');
      var response = await http.patch(
        uri,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json',
        },
      );
      print(response.body);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
