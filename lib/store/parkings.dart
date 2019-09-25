import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/services/parking.dart';

part 'parkings.g.dart';

class Parkings = _Parkings with _$Parkings;

abstract class _Parkings with Store {
  final authService = locator<ParkingService>();

  @action
  Future<void> fetchParkings([bool byCluster = false]) async {
    try {
      //
    } catch (e) {
      print(e);
    }
  }
}
