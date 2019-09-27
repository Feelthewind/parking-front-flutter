import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/cluster.dart';
import 'package:parking_flutter/models/parking.dart';
import 'package:parking_flutter/services/auth.dart';
import 'package:path/path.dart';

const BASE_URL = '172.30.1.22:3000';

class ParkingService {
  AuthService authService = locator<AuthService>();
  Dio dio = Dio();

  Future<void> createParking(
    Map<String, dynamic> parking,
    // String price,
    // String description,
    // List<double> coordinates,
    // List<String> images,
    // List<Map<String, dynamic>> timezones,
  ) async {
    try {
      var uri = Uri.http(BASE_URL, '/parking');
      var response = await http.post(uri,
          headers: <String, String>{
            HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
            HttpHeaders.contentTypeHeader: 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(parking));

      print(response.body);
      return;

      // final jsonResponse = jsonDecode(response.body);
      // final ParkingList parkingList = ParkingList.fromJson(jsonResponse);

      // print('=========================');
      // print('=========================');
      // print(parkingList);
      // print(parkingList.parkings);

      // return parkingList.parkings;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String> saveParkingImages(File image) async {
    // try {
    //   List uploadList = [];
    //   for (var imageFile in images) {
    //     uploadList.add(UploadFileInfo(imageFile, basename(imageFile.path)));
    //   }
    //   final response = await dio.post('http://$BASE_URL/parking/images',
    //       data: FormData.from({
    //         'images[]': uploadList,
    //       }));

    //   print(response);
    //   // return response.data['url'];
    // } catch (e) {
    //   print(e);
    //   throw e;
    // }
    try {
      FormData formData = FormData();

      formData.add("files", new UploadFileInfo(image, basename(image.path)));

      final response =
          await dio.post('http://$BASE_URL/parking/images', data: formData);

      print(response);
      return response.data['url'];
    } catch (e) {
      print(e);
      throw e;
    }

    // var uri = Uri.parse('http://$BASE_URL/parking/images');
    // var bytes = await image.readAsBytes();

    // var request = http.MultipartRequest("POST", uri);

    // var a = http.MultipartFile.fromBytes(
    //   'files',
    //   bytes,
    // );

    // // request.fields['files'] = 'someone@somewhere.com';
    // request.files.add(a);
    // request.send().then((response) {
    //   if (response.statusCode == 200) print("Uploaded!");
    // });
  }

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
