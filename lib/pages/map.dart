import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as LatLngPlugin;
import 'package:location/location.dart';
import 'package:parking_flutter/models/clusters.dart';
import 'package:parking_flutter/pages/create_parking.dart';
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
  GoogleMapController _controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<MarkerId, String> prices = <MarkerId, String>{};
  Map<MarkerId, ParkingStore> parkings = <MarkerId, ParkingStore>{};
  Set<Circle> _circles = Set();
  MarkerId selectedMarker;

  Location _locationService = new Location();
  LocationData _currentLocation;
  LocationData priorLocation;
  int timer = 0;
  bool _permission = false;
  String _error;
  int count = 1;
  double zoom = 14.0;
  bool zoomingIn = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // _initLocationChanged();
  }

  void initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          final location = await _locationService.getLocation();
          this.setState(() {
            _currentLocation = location;
          });
          if (_currentLocation is LocationData) {
            print(_currentLocation.latitude);
            print(_currentLocation.longitude);
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
      this.setState(() {
        _currentLocation = null;
        _error = e.message;
      });
    }
  }

  // TODO: marker is not reactive right when it is clicekd. no idea why.
  void handleTimeSelected(int count) {
    setState(() {
      count = count;
    });
    markers.forEach((markerId, marker) {
      var newMarker = marker.copyWith(
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
        markers[markerId] = newMarker;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
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
          _currentLocation != null
              // TODO: refactor GoogleMap widget to anoher file
              ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        _currentLocation.latitude, _currentLocation.longitude),
                    zoom: 16.0,
                  ),
                  // TODO(iskakaushik): Remove this when collection literals makes it to stable.
                  // https://github.com/flutter/flutter/issues/28312
                  // ignore: prefer_collection_literals
                  markers: Set<Marker>.of(markers.values),
                  circles: _circles,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  rotateGesturesEnabled: false,
                  onMapCreated: _onMapCreated,
                  onCameraMove: _onGeoChanged,
                  onCameraIdle: _onGeoEnded,
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
                          _controller.animateCamera(CameraUpdate.zoomIn());
                        },
                        backgroundColor: Colors.white,
                        elevation: 8.0,
                        mini: true,
                        heroTag: 'btn1', // without it, error!
                      ),
                      FloatingActionButton(
                        child: Icon(
                          Icons.remove,
                          size: 20.0,
                          color: Colors.black45,
                        ),
                        onPressed: () {
                          _controller.animateCamera(CameraUpdate.zoomOut());
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
                          _currentLocation = location;
                        });
                        if (_currentLocation is LocationData) {
                          print(_currentLocation.latitude);
                          print(_currentLocation.longitude);
                        }
                        _controller.animateCamera(
                          CameraUpdate.newLatLngZoom(
                              LatLng(_currentLocation.latitude,
                                  _currentLocation.longitude),
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
      LatLngBounds bounds = await _controller.getVisibleRegion();
      var queryParameters = {
        'xmin': bounds.southwest.latitude.toString(),
        'ymin': bounds.southwest.longitude.toString(),
        'xmax': bounds.northeast.latitude.toString(),
        'ymax': bounds.northeast.longitude.toString(),
      };

      ParkingsStore parkingsStore =
          Provider.of<ParkingsStore>(context, listen: false);

      if (zoom < 14.0) {
        // get parkings by clustering
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
        // get parkings by bounds
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

  Future<void> _onMapCreated(GoogleMapController controller) async {
    this._controller = controller;
    LatLngBounds bounds = await _controller.getVisibleRegion();
    ParkingsStore parkingsStore =
        Provider.of<ParkingsStore>(context, listen: false);

    // make it string to send it as parameter using Uri
    final queryParameters = {
      'xmin': bounds.southwest.latitude.toString(),
      'ymin': bounds.southwest.longitude.toString(),
      'xmax': bounds.northeast.latitude.toString(),
      'ymax': bounds.northeast.longitude.toString(),
    };

    try {
      await parkingsStore.getParkingsByBounds(queryParameters);
      if (parkingsStore.parkings.isNotEmpty) {
        _addParkings(parkingsStore.parkings);
      }
    } catch (e) {
      print(e);
    }
  }

  void _addParkings(List<ParkingStore> parkingStoreList) async {
    setState(() {
      _circles = Set();
    });
    for (var i = 0; i < parkingStoreList.length; i++) {
      final lat = parkingStoreList[i].coordinates[0];
      final lng = parkingStoreList[i].coordinates[1];
      _add(lat, lng, parkingStoreList[i]);
    }
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

  void _addClusters(List<Cluster> clusters) {
    // TODO: Show count text within circle
    Set<Circle> newCircles = Set();
    int total = 0; // to paint circle proportinally
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
            _controller.animateCamera(
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

  // It crashes app. I guess because setState is called too fast
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
        _currentLocation = location;
      });
      timer++;

      // calculate distance between current and prior location and if it is greater than threshold value, get parkings by bounds.
      final LatLngPlugin.Distance distance = LatLngPlugin.Distance();
      final double meter = distance(
        LatLngPlugin.LatLng(priorLocation.latitude, priorLocation.longitude),
        LatLngPlugin.LatLng(
            _currentLocation.latitude, _currentLocation.longitude),
      );

      print('distance');
      print(meter);

      if (meter >= 10.0) {
        _controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(_currentLocation.latitude, _currentLocation.longitude),
          ),
        );
      }
    });
  }
}
