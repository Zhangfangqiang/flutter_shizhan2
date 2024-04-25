import 'app.dart';
import 'package:flutter/material.dart';
import 'routers/router_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      onGenerateRoute: RouterTable.onGenerateRoute,
      initialRoute: RouterTable.splashPath,
    );
  }
}