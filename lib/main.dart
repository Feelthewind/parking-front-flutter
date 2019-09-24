import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:parking_flutter/pages/map.dart';
import 'package:parking_flutter/pages/signin.dart';
import 'package:parking_flutter/store/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  // debugPaintSizeEnabled = true;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(builder: (_) => Auth()),
      ],
      child: Observer(
        builder: (ctx) {
          final auth = Provider.of<Auth>(ctx, listen: false);

          return MaterialApp(
            title: 'Flutter Google Maps Demo',
            home: auth.token != null ? MapPage() : Signin(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
