import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/error_response.dart';
import 'package:parking_flutter/models/order.dart';
import 'package:parking_flutter/services/auth.dart';
import 'package:parking_flutter/shared/constants.dart';

class OrderService {
  AuthService authService = locator<AuthService>();
  Dio dio = Dio();

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

  Future<dynamic> getLatestOrder() async {
    try {
      final response = await dio.get(
        'http://$BASE_URL/order',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }),
      );
      print(response.data);
      return Order.fromJson(response.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return ErrorResponse.fromJson(
          e.response.data,
        );
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }
  }

  Future<Order> extendOrderTime(int orderId, int timeToExtend) async {
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
      return Order.fromJson(jsonDecode(response.body));
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
