import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:parking_flutter/widgets/parking_bottom_modal.dart';
import 'package:parking_flutter/widgets/parking_expansion_tile.dart';

import 'models/parking.dart';

void main() {
  runApp(MyApp());
  // debugPaintSizeEnabled = true;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<MarkerId, String> prices = <MarkerId, String>{};
  Map<MarkerId, Parking> parkings = <MarkerId, Parking>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  LocationData currentLocation = null;
  Location _locationService = new Location();
  bool _permission = false;
  String error;
  int count = 1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getParkings();
  }

  void handleTimeSelected(int count) {
    setState(() {
      count = count;
    });
    markers.forEach((markerId, marker) {
      marker = marker.copyWith(
          infoWindowParam: InfoWindow(
            title: (int.parse(prices[markerId]) * count).toString(),
          ),
          onTapParam: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ParkingBottomModal(parkings[markerId], count);
              },
            );
          });
      setState(() {
        markers[markerId] = marker;
      });
    });
  }

  void getParkings() async {
    var queryParameters = {
      'lat': '37.611538',
      'lng': '127.140162',
    };
    var uri =
        Uri.http('172.30.1.29:3000', '/parking/distance', queryParameters);
    var response = await http.get(uri, headers: {
      // HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    final dynamic jsonResponse = jsonDecode(response.body);
    final ParkingList parkingList = ParkingList.fromJson(jsonResponse);

    for (var i = 0; i < parkingList.parkings.length; i++) {
      final lat = parkingList.parkings[i].coordinates[0];
      final lng = parkingList.parkings[i].coordinates[1];
      _add(lat, lng, parkingList.parkings[i]);
    }
  }

  void _add(double lat, double lng, Parking parking) {
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    parkings[markerId] = parking;

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: parking.price.substring(1).toString(),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return ParkingBottomModal(parking);
          },
        );
      },
    );

    setState(() {
      markers[markerId] = marker;
      prices[markerId] = parking.price.substring(1);
    });
  }

  void initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      print('============================================');
      print('============================================');
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          final location = await _locationService.getLocation();
          this.setState(() {
            currentLocation = location;
          });
          if (currentLocation is LocationData) {
            print(currentLocation.latitude);
            print(currentLocation.longitude);
          }
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      this.setState(() {
        currentLocation = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.publish,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          currentLocation != null
              ? GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation.latitude, currentLocation.longitude),
                    zoom: 16.0,
                  ),
                  // TODO(iskakaushik): Remove this when collection literals makes it to stable.
                  // https://github.com/flutter/flutter/issues/28312
                  // ignore: prefer_collection_literals
                  markers: Set<Marker>.of(markers.values),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                )
              : Container(),
          Container(
            padding: const EdgeInsets.all(12.0),
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FloatingActionButton(
                        child: Icon(
                          Icons.add,
                          size: 20.0,
                          color: Colors.black45,
                        ),
                        onPressed: () {
                          controller.moveCamera(CameraUpdate.zoomIn());
                        },
                        backgroundColor: Colors.white,
                        elevation: 8.0,
                        mini: true,
                      ),
                      FloatingActionButton(
                        child: Icon(
                          Icons.remove,
                          size: 20.0,
                          color: Colors.black45,
                        ),
                        onPressed: () {
                          controller.animateCamera(CameraUpdate.zoomOut());
                        },
                        backgroundColor: Colors.white,
                        elevation: 8.0,
                        mini: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ParkingExpansionTile(this.handleTimeSelected),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }
}
