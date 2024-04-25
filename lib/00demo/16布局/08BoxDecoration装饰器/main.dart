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
          body: const Center(
            child: DecoratedBoxRoute(),
          ),
        ));
  }
}


class DecoratedBoxRoute extends StatelessWidget {
  const DecoratedBoxRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
              gradient:
              LinearGradient(colors: [Colors.red, Colors.orange.shade700]),
              //背景渐变
              borderRadius: BorderRadius.circular(3.0),
              //3像素圆角
              boxShadow: const [
                //阴影
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 80.0,
              vertical: 18.0,
            ),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              image: const DecorationImage(
                image: AssetImage("imgs/avatar.png"),
                //alignment: Alignment.topLeft
              ),
            ),
          ),
        )
      ],
    );
  }
}