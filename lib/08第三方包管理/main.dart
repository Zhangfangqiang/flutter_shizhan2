import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
        home: Container(child: RandomWordsWidget()));
  }
}

class RandomWordsWidget extends StatefulWidget {
  @override
  _RandomWordsWidgetState createState() => _RandomWordsWidgetState();
}

class _RandomWordsWidgetState extends State<RandomWordsWidget> {
  String _ranStr = WordPair.random().toString();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(_ranStr),
      TextButton(onPressed: () {
        setState(() {
          _ranStr = WordPair.random().toString();
        });
      }, child: Text("点我切换随机字符串"))
    ]);
  }
}
