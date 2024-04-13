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
            child: SwitchAndCheckBoxRoute(),
          ),
        ));
  }
}

/**
 * 有完整状态的组件
 */
class SwitchAndCheckBoxRoute extends StatefulWidget {

  /**
   * 构造函数
   */
  const SwitchAndCheckBoxRoute({Key? key}) : super(key: key);

  /**
   * 创建状态
   */
  @override
  _SwitchAndCheckBoxRouteState createState() => _SwitchAndCheckBoxRouteState();
}

/**
 * 实现状态更新的具体ui
 */
class _SwitchAndCheckBoxRouteState extends State<SwitchAndCheckBoxRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Switch(
              value: _switchSelected, //当前状态
              onChanged: (value) {
                //重新构建页面
                setState(() {
                  _switchSelected = value;
                });
              },
            ),
             const Text("关"),

            Switch(
              value: !_switchSelected, //当前状态
              onChanged: (value) {},
            ),
             const Text("开"),
          ],
        ),
        Row(
          children: <Widget>[
            Checkbox(
              value: _checkboxSelected,
              activeColor: Colors.red, //选中时的颜色
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value!;
                });
              },
            ),
            const Text("未选中"),


            Checkbox(
              value: !_checkboxSelected,
              activeColor: Colors.red, //选中时的颜色
              onChanged: (value) {},
            ),
            const Text("选中"),
          ],
        )
      ],
    );
  }
}