import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/**
 * 继承无状态组件 StatelessWidget相对比较简单，它继承自widget类，重写了createElement()方法：
 * *****************************************************************************
 * 在 Flutter 开发中，我们一般都不用直接继承Widget类来实现一个新组件，相反，我们通常会通过继承
 * StatelessWidget或StatefulWidget来间接继承widget类来实现。
 * StatelessWidget和StatefulWidget都是直接继承自Widget类
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home()
    );
  }
}

/**
 * home 页面
 */
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return       TextButton(
      child: Text("open new route"),
      onPressed: () {
        // 导航到新路由
        Navigator.push(
          context,

          /*创建一个路由页面*/
          MaterialPageRoute(builder: (context) {
            return NewRoute();
          }),
        );
      },
    );
  }
}

/**
 * 路由页面具体填充的组件
 */
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}
