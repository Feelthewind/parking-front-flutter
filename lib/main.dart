import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/pages/create_parking.dart';
import 'package:parking_flutter/pages/map.dart';
import 'package:parking_flutter/pages/order_parking.dart';
import 'package:parking_flutter/pages/signin.dart';
import 'package:parking_flutter/store/auth.dart';
import 'package:parking_flutter/store/parkings.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
  // debugPaintSizeEnabled = true;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(builder: (_) => AuthStore()),
        Provider(builder: (_) => ParkingsStore()),
      ],
      child: Observer(
        builder: (ctx) {
          final auth = Provider.of<AuthStore>(ctx, listen: false);

          return MaterialApp(
            title: 'Flutter Google Maps Demo',
            debugShowCheckedModeBanner: false,
            home: auth.token != null ? MapPage() : SigninPage(),
            routes: {
              SigninPage.routeName: (_) => SigninPage(),
              MapPage.routeName: (_) => MapPage(),
              CreateParkingPage.routeName: (_) => CreateParkingPage(),
              OrderParkingPage.routeName: (_) => OrderParkingPage(),
            },
          );
        },
      ),
    );
  }
}
