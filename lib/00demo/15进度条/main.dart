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

        home: Scaffold(
          appBar: AppBar(
            title: Text("New route"),
          ),
          body: Center(
            child: ProgressRoute(),
          ),
        ));
  }
}

/**
 * 状态组件
 */
class ProgressRoute extends StatefulWidget {
  /**
   * 构造方法
   */
  const ProgressRoute({Key? key}) : super(key: key);

  /**
   * 创建状态的方法
   */
  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

/**
 * 它允许一个类在继承另一个类的同时，还能够引入和使用另一个类的功能，而不必完全继承它
 */
class _ProgressRouteState extends State<ProgressRoute> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;    //关键字表示该变量在声明后会被延迟初始化

  /**
   * 当对象树被插入到树中就会执行这个方法
   */
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));

    super.initState();
  }

  /**
   * 从树中移除就是调用这个方法
   */
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          /*进度条*/
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
          ),

          /*进度条*/
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            value: .5,
          ),

          /*圆圈进度条*/
          SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
          ),

          /*圆圈进度条*/
          SizedBox(
            height: 100,
            width: 130,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              value: .7,
            ),
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            value: .5,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
            value: _animationController.value,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
            value: _animationController.value,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
          )
        ].map((e) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: e,
          );
        }).toList(),
      ),
    );
  }
}
