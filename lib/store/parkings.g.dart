// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parkings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ParkingsStore on _ParkingsStore, Store {
  final _$parkingsAtom = Atom(name: '_ParkingsStore.parkings');

  @override
  ObservableList<ParkingStore> get parkings {
    _$parkingsAtom.context.enforceReadPolicy(_$parkingsAtom);
    _$parkingsAtom.reportObserved();
    return super.parkings;
  }

  @override
  set parkings(ObservableList<ParkingStore> value) {
    _$parkingsAtom.context.conditionallyRunInAction(() {
      super.parkings = value;
      _$parkingsAtom.reportChanged();
    }, _$parkingsAtom, name: '${_$parkingsAtom.name}_set');
  }

  final _$clustersAtom = Atom(name: '_ParkingsStore.clusters');

  @override
  ObservableList<Cluster> get clusters {
    _$clustersAtom.context.enforceReadPolicy(_$clustersAtom);
    _$clustersAtom.reportObserved();
    return super.clusters;
  }

  @override
  set clusters(ObservableList<Cluster> value) {
    _$clustersAtom.context.conditionallyRunInAction(() {
      super.clusters = value;
      _$clustersAtom.reportChanged();
    }, _$clustersAtom, name: '${_$clustersAtom.name}_set');
  }

  final _$getParkingsByBoundsAsyncAction = AsyncAction('getParkingsByBounds');

  @override
  Future<void> getParkingsByBounds(Map<String, String> parameters) {
    return _$getParkingsByBoundsAsyncAction
        .run(() => super.getParkingsByBounds(parameters));
  }

  final _$getParkingsByClusteringAsyncAction =
      AsyncAction('getParkingsByClustering');

  @override
  Future<void> getParkingsByClustering(Map<String, String> parameters) {
    return _$getParkingsByClusteringAsyncAction
        .run(() => super.getParkingsByClustering(parameters));
  }
}
