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
        home: ThemeTestRoute());
  }
}

class ThemeTestRoute extends StatefulWidget {
  const ThemeTestRoute({Key? key}) : super(key: key);
  @override
  _ThemeTestRouteState createState() => _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  var _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      /*从这里定义主题颜色*/
      data: ThemeData(
        primarySwatch: _themeColor,                       /*用于导航栏、FloatingActionButton的背景色等*/
        iconTheme: IconThemeData(color: _themeColor),     /*用于Icon颜色*/
      ),

      child: Scaffold(
        appBar: AppBar(title: const Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /*第一行Icon使用主题中的iconTheme*/
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("  颜色跟随主题"),
                ]),

            /*为第二行Icon自定义颜色（固定为黑色)*/
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色固定黑色"),
                  ]),
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton(
            /*切换主题*/
            onPressed: () => setState(() => _themeColor = _themeColor == Colors.teal ? Colors.blue : Colors.teal),
            child: const Icon(Icons.palette)),
      ),
    );
  }
}
