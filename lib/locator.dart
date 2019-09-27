import 'package:get_it/get_it.dart';
import 'package:parking_flutter/services/auth.dart';
import 'package:parking_flutter/services/order.dart';
import 'package:parking_flutter/services/parking.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<ParkingService>(ParkingService());
  locator.registerSingleton<OrderService>(OrderService());
}
