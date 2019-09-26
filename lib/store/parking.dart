import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'parking.g.dart';

class ParkingStore extends _ParkingStore with _$ParkingStore {
  ParkingStore({
    int id,
    bool isAvailable,
    String price,
    List<double> coordinates,
  }) : super(id, isAvailable, price, coordinates);
}

abstract class _ParkingStore with Store {
  _ParkingStore(
    this.id,
    this.isAvailable,
    this.price,
    this.coordinates,
  );

  int id;
  bool isAvailable;
  String price;
  List<double> coordinates;
}
