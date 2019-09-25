import 'package:get_it/get_it.dart';
import 'package:parking_flutter/services/auth.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(AuthService());
}
