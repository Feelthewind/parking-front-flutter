import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/cluster.dart';
import 'package:parking_flutter/models/parking.dart';
import 'package:parking_flutter/services/auth.dart';

class ParkingService {
  AuthService authService;

  Future<ParkingList> getParkingsByBounds(
      Map<String, String> queryParameters) async {
    authService = locator<AuthService>();

    try {
      var uri =
          Uri.http('172.30.1.54:3000', '/parking/bounds', queryParameters);
      print('token');
      print(authService.token);
      var response = await http.get(uri, headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
        HttpHeaders.contentTypeHeader: 'application/json',
        'Accept': 'application/json',
      });

      print(response.body);

      final dynamic jsonResponse = jsonDecode(response.body);
      final ParkingList parkingList = ParkingList.fromJson(jsonResponse);

      return parkingList;
    } catch (e) {
      print(e);
    }
  }

  Future<ClusterList> getParkingsByClustering(
      Map<String, String> queryParameters) async {
    authService = locator<AuthService>();

    try {
      var uri =
          Uri.http('172.30.1.54:3000', '/parking/clustering', queryParameters);
      var response = await http.get(uri, headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
        HttpHeaders.contentTypeHeader: 'application/json',
        'Accept': 'application/json',
      });

      print(response.body);

      final dynamic jsonResponse = jsonDecode(response.body);
      return ClusterList.fromJson(jsonResponse);
    } catch (e) {
      print('error clustering');
      print(e);
      return null;
    }
  }
}
