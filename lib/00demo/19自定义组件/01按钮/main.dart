import './gradient_button.dart';
import 'package:flutter/material.dart' hide Page;

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
            appBar: AppBar(title: Text("滚动控制")), body: GradientButtonRoute()));
  }
}

class GradientButtonRoute extends StatefulWidget {
  const GradientButtonRoute({Key? key}) : super(key: key);
  @override
  _GradientButtonRouteState createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GradientButton(
          colors: const [Colors.orange, Colors.red],
          height: 50.0,
          child: const Text("Submit"),
          onPressed: onTap,
        ),
        GradientButton(
          height: 50.0,
          colors: [Colors.lightGreen, Colors.green.shade700],
          child: const Text("Submit"),
          onPressed: onTap,
        ),
        GradientButton(
          height: 50.0,
          //borderRadius: const BorderRadius.all(Radius.circular(5)),
          colors: [Colors.lightBlue.shade300, Colors.blueAccent],
          child: const Text("Submit"),
          onPressed: onTap,
        ),
      ],
    );
  }
  onTap() {
    print("button click");
  }
}