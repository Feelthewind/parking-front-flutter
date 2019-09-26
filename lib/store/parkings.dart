import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/cluster.dart';
import 'package:parking_flutter/services/parking.dart';
import 'package:parking_flutter/store/parking.dart';

part 'parkings.g.dart';

class ParkingsStore = _ParkingsStore with _$ParkingsStore;

abstract class _ParkingsStore with Store {
  final authService = locator<ParkingService>();

  @observable
  ObservableList<ParkingStore> parkings = ObservableList<ParkingStore>();

  @observable
  ObservableList<Cluster> clusters = ObservableList<Cluster>();

  // @observable
  // ObservableList<Cluster> clusters = ObservableList<Cluster>();

  @action
  Future<void> getParkingsByBounds(Map<String, String> parameters) async {
    try {
      final result = await authService.getParkingsByBounds(parameters);
      // to make parking responsive too for like favorite function
      final parkingsResult = result.map((parking) {
        return ParkingStore(
          id: parking.id,
          coordinates: parking.coordinates,
          isAvailable: parking.isAvailable,
          price: parking.price,
          // timezones: parking.timezones,
        );
      });
      parkings = ObservableList.of(parkingsResult);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @action
  Future<void> getParkingsByClustering(Map<String, String> parameters) async {
    try {
      final result = await authService.getParkingsByClustering(parameters);
      clusters = ObservableList.of(result);
      // clusters = ObservableList.of(result.clusters);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
