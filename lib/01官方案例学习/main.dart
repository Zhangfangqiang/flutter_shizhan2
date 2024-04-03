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
      home: const MyHomePage(title: 'Flutter 实战2'),
    );
  }
}

/**
 * 继承有状态的组件
 */
class MyHomePage extends StatefulWidget {

  final String title;

  /**
   * 构造方法
   */
  const MyHomePage({super.key, required this.title});


  /**
   * 创建状态
   */
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/**
 * 我继承状态返回 MyHomePage 组件
 */
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var title = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(title)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _incrementCounter(),
          setState(() {
            title = "aaa";
          })
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
