import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/cluster.dart';
import 'package:parking_flutter/models/parking.dart';
import 'package:parking_flutter/services/auth.dart';

const BASE_URL = '172.30.1.22:3000';

class ParkingService {
  AuthService authService = locator<AuthService>();

  Future<List<Parking>> getParkingsByBounds(
      Map<String, String> queryParameters) async {
    try {
      var uri = Uri.http(BASE_URL, '/parking/bounds', queryParameters);
      print('token');
      print(authService.token);
      var response = await http.get(uri, headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
        HttpHeaders.contentTypeHeader: 'application/json',
        'Accept': 'application/json',
      });

      print(response.body);

      final jsonResponse = jsonDecode(response.body);
      final ParkingList parkingList = ParkingList.fromJson(jsonResponse);

      print('=========================');
      print('=========================');
      print(parkingList);
      print(parkingList.parkings);

      return parkingList.parkings;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Cluster>> getParkingsByClustering(
      Map<String, String> queryParameters) async {
    authService = locator<AuthService>();

    try {
      var uri = Uri.http(BASE_URL, '/parking/clustering', queryParameters);
      var response = await http.get(uri, headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
        HttpHeaders.contentTypeHeader: 'application/json',
        'Accept': 'application/json',
      });

      print(response.body);

      final dynamic jsonResponse = jsonDecode(response.body);
      final ClusterList clusterList = ClusterList.fromJson(jsonResponse);
      return clusterList.clusters;
    } catch (e) {
      print('error clustering');
      print(e);
      throw e;
    }
  }
}
