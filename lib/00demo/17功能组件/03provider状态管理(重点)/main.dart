import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';     //常用工具类
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        /*数据提供者*/
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
}

/**
 * 数据内容
 */
class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  /**
   * debugFillProperties 方法是 DiagnosticableTreeMixin 类提供的一个方法，用于填充诊断信息。
   * 在 Flutter 中，开发者可以使用诊断工具来检查和调试 Widget 树的结构和状态，以便更好地理解应用程
   * 序的行为和问题。当开发者使用 Flutter DevTools 或其他诊断工具检查应用程序时，它们可以调用对象的
   * debugFillProperties 方法，以便在诊断信息中显示有关对象的一些重要属性和状态。这些信息可以帮助开
   * 发者更好地理解对象的状态和行为，并且有助于快速定位和解决问题。在上面的代码中，debugFillProperties
   * 方法被覆盖，并使用 DiagnosticPropertiesBuilder 对象将 count 属性添加到诊断信息中。这样，
   * 在使用诊断工具检查 Counter 对象时，将显示其 count 属性的值，从而更好地了解 Counter 对象的状态。
   */
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

/**
 * 无状态的组件
 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

/**
 * 无状态的组件 首页
 */
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/**
 * 总数组件
 */
class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${context.watch<Counter>().count}',
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}