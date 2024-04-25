import 'package:flutter/material.dart';
import 'dart:math' as math;

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
        home: Scaffold(
          appBar: AppBar(
            title: Text("New route"),
          ),
          body: const Center(
            child: TransformRoute(),
          ),
        ));
  }
}


class TransformRoute extends StatelessWidget {
  const TransformRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = [
      Container(
        color: Colors.black,
        child: Transform(
          alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
          transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.deepOrange,
            child: const Text('Apartment for rent!'),
          ),
        ),
      ),
      DecoratedBox(
        decoration: const BoxDecoration(color: Colors.red),
        //默认原点为左上角，左移20像素，向上平移5像素
        child: Transform.translate(
          offset: const Offset(-20.0, -5.0),
          child: const Text("Hello world"),
        ),
      ),
      DecoratedBox(
        decoration: const BoxDecoration(color: Colors.red),
        child: Transform.rotate(
          //旋转90度
          angle: math.pi / 2,
          child: const Text("Hello world"),
        ),
      ),
      DecoratedBox(
        decoration: const BoxDecoration(color: Colors.red),
        child: Transform.scale(
          scale: 1.5, //放大到1.5倍
          child: const Text("Hello world"),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5,
              child: const Text("Hello world"),
            ),
          ),
          const Text(
            "你好",
            style: TextStyle(color: Colors.green, fontSize: 18.0),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            //将Transform.rotate换成RotatedBox
            child: RotatedBox(
              quarterTurns: 1, //旋转90度(1/4圈)
              child: Text("Hello world"),
            ),
          ),
          Text(
            "你好",
            style: TextStyle(color: Colors.green, fontSize: 18.0),
          )
        ],
      ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children
          .map((e) => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: e,
      ))
          .toList(),
    );
  }
}
