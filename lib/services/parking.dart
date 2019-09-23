import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:parking_flutter/models/parking.dart';

class ParkingService {
  ParkingService(this.controller);

  GoogleMapController controller;

  Future<ParkingList> getParkingsByBounds() async {
    LatLngBounds bounds = await controller.getVisibleRegion();
    // var queryParameters = {
    //   'lat': '37.611538',
    //   'lng': '127.140162',
    // };
    var queryParameters = {
      'xmin': bounds.southwest.latitude.toString(),
      'ymin': bounds.southwest.longitude.toString(),
      'xmax': bounds.northeast.latitude.toString(),
      'ymax': bounds.northeast.longitude.toString(),
    };
    var uri = Uri.http('172.30.1.29:3000', '/parking/bounds', queryParameters);
    var response = await http.get(uri, headers: <String, String>{
      // HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'Accept': 'application/json',
    });

    print(response.body);

    final dynamic jsonResponse = jsonDecode(response.body);
    final ParkingList parkingList = ParkingList.fromJson(jsonResponse);

    return parkingList;
  }

  getParkingsByClustering() {
    //
  }
  // void getParkings([double zoom = 10.0]) async {
  //   if (zoom < 14.0) {
  //     // get parkings by clustering
  //   } else {
  //     // get parkings by bounds

  //   }
  // }
}
