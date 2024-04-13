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
            child: SizeConstraintsRoute(),
          ),
        ));
  }
}

/**
 * 无状态组件
 */
class SizeConstraintsRoute extends StatelessWidget {
  const SizeConstraintsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget redBox = const DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          /*创建一个容器,宽度无限大高度最小高度50*/
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 50.0,
            ),
            child: SizedBox(height: 5.0, child: redBox),
          ),

          /*创建一个高80 宽80的容器*/
          SizedBox(width: 80.0, height: 80.0, child: redBox),

          /*在容器里面嵌套容器*/
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60.0, minHeight: 60.0),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(minWidth: 90.0, minHeight: 20.0),
              child: redBox,
            ),
          ),

          /*在容器里面嵌套容器*/
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(minWidth: 60.0, minHeight: 60.0),
              child: redBox,
            ),
          ),

          /*超出大小溢出报错*/
          UnconstrainedBox(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(children: [Text('信息' * 30)]),
            ),
          ),

          /*空间块*/
          AspectRatio(
              aspectRatio: 3, //宽是高的三倍
              child: redBox)


        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
