import 'package:flutter/gestures.dart';
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
        /*外部必须套一个Navigator*/
        home: Container(child: ButtonRoute()));
  }
}

class ButtonRoute extends StatefulWidget {
  const ButtonRoute({Key? key}) : super(key: key);
  @override
  _ButtonRouteState createState() => _ButtonRouteState();
}

class _ButtonRouteState extends State<ButtonRoute> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        /*有实体的按钮*/
        ElevatedButton(
          child: const Text("normal"),
          onPressed: () => {},
        ),
        /*有实体的icon按钮*/
        ElevatedButton.icon(
          icon: const Icon(Icons.send),
          label: const Text("发送"),
          onPressed: _onPressed,
        ),

        /*边框按钮*/
        OutlinedButton(
          child: const Text("normal"),
          onPressed: () => {},
        ),
        /*边框按钮有icon*/
        OutlinedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("添加"),
          onPressed: _onPressed,
        ),

        /*文本按钮*/
        TextButton(
          child: const Text("Submit"),
          onPressed: () => {},
        ),
        /*文本按钮有icon*/
        TextButton.icon(
          icon: const Icon(Icons.info),
          label: const Text("详情"),
          onPressed: _onPressed,
        ),

        /*icon按钮*/
        IconButton(
          icon: const Icon(Icons.thumb_up),
          onPressed: () => {},
        ),
      ].map((e) => Padding(child: e, padding: const EdgeInsets.only(top: 20))).toList(),
    );
  }

  void _onPressed() {
    print("button pressed");
  }
}

