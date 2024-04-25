import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/routers/router_table.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 120,
          height: 120,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(120 / 2)),
          ),
          child: Image.asset(
            'imgs/logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  /**
   * 可以加载一些广告
   */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      Timer(const Duration(milliseconds: 2000), () {
        Navigator.of(context).pushReplacementNamed(RouterTable.homePath);
      });
    }
  }
}
