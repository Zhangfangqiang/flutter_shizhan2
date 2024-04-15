import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Page;

import 'event_bus.dart';

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
            appBar: AppBar(title: Text("滚动控制")), body: EventConflictTest()));
  }
}

class EventConflictTest extends StatefulWidget {
  const EventConflictTest({Key? key}) : super(key: key);
  @override
  _EventConflictTest createState() => _EventConflictTest();
}

class _EventConflictTest extends State<EventConflictTest> {
  var bus = EventBus();

  @override
  void initState() {
    bus.on("login", (arg) {
      print(arg);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      TextButton(
          onPressed: () {
            print(1111);
            bus.emit("login","这个就是数据");
          },
          child: Text("发送数据")),
    ]);
  }
}
