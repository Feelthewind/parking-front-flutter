import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as LatLngPlugin;
import 'package:location/location.dart';
import 'package:parking_flutter/models/cluster.dart';
import 'package:parking_flutter/pages/create_parking.dart';
import 'package:parking_flutter/services/parking.dart';
import 'package:parking_flutter/store/parking.dart';
import 'package:parking_flutter/store/parkings.dart';
import 'package:parking_flutter/widgets/app_drawer.dart';
import 'package:parking_flutter/widgets/parking_bottom_modal.dart';
import 'package:parking_flutter/widgets/parking_expansion_tile.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  static const routeName = '/map';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<MarkerId, String> prices = <MarkerId, String>{};
  Map<MarkerId, ParkingStore> parkings = <MarkerId, ParkingStore>{};
  MarkerId selectedMarker;

  LocationData currentLocation;
  LocationData priorLocation;
  Location _locationService = new Location();
  bool _permission = false;
  String error;
  int count = 1;
  double zoom = 14.0;
  ParkingService parkingService;
  bool zoomingIn = false;
  Set<Circle> _circles = Set();
  int timer = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // _initLocationChanged();
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

  void _add(double lat, double lng, ParkingStore parking) {
    final String markerIdVal = parking.id.toString();
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
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {},
        // ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.publish,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, CreateParkingPage.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
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
                  rotateGesturesEnabled: false,
                  onCameraMove: _onGeoChanged,
                  onCameraIdle: _onGeoEnded,
                  circles: _circles,
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
                          controller.animateCamera(CameraUpdate.zoomIn());
                        },
                        backgroundColor: Colors.white,
                        elevation: 8.0,
                        mini: true,
                        heroTag: 'btn1',
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
                        heroTag: 'btn2',
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment(-1, -0.8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                            offset: Offset(1.0, 1.0),
                          )
                        ]),
                    child: IconButton(
                      icon: Icon(Icons.my_location),
                      onPressed: () async {
                        final location = await _locationService.getLocation();
                        this.setState(() {
                          currentLocation = location;
                        });
                        if (currentLocation is LocationData) {
                          print(currentLocation.latitude);
                          print(currentLocation.longitude);
                        }
                        controller.animateCamera(
                          CameraUpdate.newLatLngZoom(
                              LatLng(currentLocation.latitude,
                                  currentLocation.longitude),
                              16),
                        );
                      },
                    ),
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

  void _onGeoEnded() async {
    try {
      LatLngBounds bounds = await controller.getVisibleRegion();
      var queryParameters = {
        'xmin': bounds.southwest.latitude.toString(),
        'ymin': bounds.southwest.longitude.toString(),
        'xmax': bounds.northeast.latitude.toString(),
        'ymax': bounds.northeast.longitude.toString(),
      };

      ParkingsStore parkingsStore =
          Provider.of<ParkingsStore>(context, listen: false);

      if (zoom < 14.0) {
        print('Get parkings by clustering');
        await parkingsStore.getParkingsByClustering(queryParameters);
        _addClusters(parkingsStore.clusters);
        final newCircles = Set<Circle>();
        if (zoom < 13.0) {
          _circles.forEach((c) {
            newCircles.add(c.copyWith(radiusParam: (c.radius) * (14 - zoom)));
          });
          setState(() {
            _circles = newCircles;
          });
        }
      } else if (zoom >= 14.0) {
        print('Get parkings by bounds');
        await parkingsStore.getParkingsByBounds(queryParameters);
        _addParkings(parkingsStore.parkings);
      }
    } catch (e) {
      print(e);
    }
  }

  void _onGeoChanged(CameraPosition position) async {
    if (zoom - position.zoom < 0) {
      setState(() {
        zoomingIn = true;
      });
    } else if (zoom - position.zoom > 0) {
      setState(() {
        zoomingIn = false;
      });
    }
    setState(() {
      zoom = position.zoom;
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    this.controller = controller;

    LatLngBounds bounds = await controller.getVisibleRegion();
    var queryParameters = {
      'xmin': bounds.southwest.latitude.toString(),
      'ymin': bounds.southwest.longitude.toString(),
      'xmax': bounds.northeast.latitude.toString(),
      'ymax': bounds.northeast.longitude.toString(),
    };

    ParkingsStore parkingsStore =
        Provider.of<ParkingsStore>(context, listen: false);

    try {
      await parkingsStore.getParkingsByBounds(queryParameters);
      if (parkingsStore.parkings.isNotEmpty) {
        _addParkings(parkingsStore.parkings);
      }
    } catch (e) {
      print(e);
    }
  }

  void _addParkings(List<ParkingStore> parkingList) async {
    setState(() {
      _circles = Set();
    });
    for (var i = 0; i < parkingList.length; i++) {
      final lat = parkingList[i].coordinates[0];
      final lng = parkingList[i].coordinates[1];
      _add(lat, lng, parkingList[i]);
    }
  }

  void _addClusters(List<Cluster> clusters) {
    // TODO: Show count text within circle
    Set<Circle> newCircles = Set();
    int total = 0;
    clusters.forEach((c) {
      total = total + int.parse(c.count);
    });
    clusters.forEach((c) {
      newCircles.add(
        Circle(
          circleId: CircleId(c.center.toString()),
          center: LatLng(c.center[0], c.center[1]),
          radius: 3000 * (int.parse(c.count) / total),
          fillColor: Colors.green.withOpacity(0.3),
          strokeWidth: 0,
          onTap: () {
            print('==========');
            print('circle tapped');
            controller.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(c.center[0], c.center[1]),
                zoom + 1,
              ),
            );
          },
          consumeTapEvents: true,
        ),
      );
    });
    setState(() {
      _circles = newCircles;
      markers = {};
    });
  }

  void _initLocationChanged() {
    _locationService.onLocationChanged().listen((LocationData location) {
      if (timer == 0) {
        setState(() {
          priorLocation = location;
        });
      }
      if (timer % 10 == 0) {
        setState(() {
          priorLocation = location;
        });
      }
      setState(() {
        currentLocation = location;
      });
      timer++;

      // calculate distance between current and prior location and if it is greater than threshold value, get parkings by bounds.
      final LatLngPlugin.Distance distance = LatLngPlugin.Distance();
      final double meter = distance(
        LatLngPlugin.LatLng(priorLocation.latitude, priorLocation.longitude),
        LatLngPlugin.LatLng(
            currentLocation.latitude, currentLocation.longitude),
      );

      print('distance');
      print(meter);

      if (meter >= 10.0) {
        controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(currentLocation.latitude, currentLocation.longitude),
          ),
        );
      }
    });
  }
}
