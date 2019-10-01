import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/clusters.dart';
import 'package:parking_flutter/models/error_response.dart';
import 'package:parking_flutter/models/parkings.dart';
import 'package:parking_flutter/services/auth.dart';
import 'package:parking_flutter/shared/constants.dart';
import 'package:path/path.dart';

class ParkingService {
  AuthService authService = locator<AuthService>();
  Dio dio = Dio();

  Future<dynamic> createParking(
    Map<String, dynamic> parking,
  ) async {
    try {
      return await dio.post(
        'http://$BASE_URL/parking',
        data: parking,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }),
      );
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return ErrorResponse.fromJson(
          e.response.data,
        ); // TODO: fix => error when message is not string
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }
  }

  Future<String> saveParkingImage(File image) async {
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
      var response = await http.get(uri, headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      });
      print(response.body);
      final jsonResponse = jsonDecode(response.body);
      final ParkingList parkingList = ParkingList.fromJson(jsonResponse);

      print('=========================');
      print(parkingList.parkings);
      return parkingList.parkings;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Cluster>> getParkingsByClustering(
      Map<String, String> queryParameters) async {
    try {
      var uri = Uri.http(BASE_URL, '/parking/clustering', queryParameters);
      var response = await http.get(uri, headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      });

      print(response.body);
      final jsonResponse = jsonDecode(response.body);
      final ClusterList clusterList = ClusterList.fromJson(jsonResponse);
      return clusterList.clusters;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future getTimeToExtend(int parkingId) async {
    authService = locator<AuthService>();

    try {
      var uri = Uri.http(BASE_URL, '/parking/extension/$parkingId');
      var response = await http.get(uri, headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ${authService.token}',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      });
      print(response.body);
      return response.body;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
