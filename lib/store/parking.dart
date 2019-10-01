import 'package:mobx/mobx.dart';
import 'package:parking_flutter/models/parkings.dart';

part 'parking.g.dart';

class ParkingStore extends _ParkingStore with _$ParkingStore {
  ParkingStore({
    int id,
    bool isAvailable,
    String price,
    List<double> coordinates,
    List<Timezone> timezones,
  }) : super(id, isAvailable, price, coordinates, timezones);
}

abstract class _ParkingStore with Store {
  _ParkingStore(
    this.id,
    this.isAvailable,
    this.price,
    this.coordinates,
    this.timezones,
  );

  int id;
  bool isAvailable;
  String price;
  List<double> coordinates;
  List<Timezone> timezones;
}
