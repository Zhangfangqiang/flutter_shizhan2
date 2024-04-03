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
      /*应用名称*/
      title: 'Flutter Demo',
      /*主题配置*/
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      /*应用首页路由 */
      home: ParentWidget(),
    );
  }
}

/**
 * 拥有完整状态的组件
 */
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

/**
 * ParentWidget 的实现
 */
class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;       //添加一个状态

  /**
   * 创建一个修改这个状态的方法
   */
  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

/**
 * 没有完整状态的组件
 */
class TapboxB extends StatelessWidget {
  /**
   * 构造方法
   * 给 active 一个默认值
   * onChanged 是一个必须填写的方法
   */
  TapboxB({Key? key, this.active = false, required this.onChanged}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  /**
   * 给onChanged 方法包一层
   */
  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
