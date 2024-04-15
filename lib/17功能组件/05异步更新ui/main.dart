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
        home: FutureAndStreamBuilderRoute());
  }
}

class FutureAndStreamBuilderRoute extends StatefulWidget {
  const FutureAndStreamBuilderRoute({Key? key}) : super(key: key);
  @override
  _FutureAndStreamBuilderRouteState createState() => _FutureAndStreamBuilderRouteState();
}

class _FutureAndStreamBuilderRouteState extends State<FutureAndStreamBuilderRoute> {
  late Future<String> _future;

  @override
  void initState() {
    _future = mockNetworkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 模拟网络请求
     */
    /*return Center(
      child: FutureBuilder<String>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Text("Contents: ${snapshot.data}");
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );*/

    /**
     * 模拟定时发送流
     */
    return Center(
      child: StreamBuilder<int>(
        stream: counter(), //
        initialData: null, // a Stream<int> or null
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('没有Stream');
            case ConnectionState.waiting:
              return Text('等待数据...');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return Text('Stream已关闭');
          }
        },
      ),
    );
  }

  /**
   * 异步加载模拟请求数据的方法
   */
  Future<String> mockNetworkData() async {
    return Future.delayed(const Duration(seconds: 3), () => "我是从互联网上获取的数据");
  }

  /**
   *  在给定的示例中，counter 方法返回了一个周期性的整数流（Stream），每秒发射一个整数。
   *  这个方法的作用是创建一个用于计数的流，每隔一秒钟发射一个整数，从0开始递增。
   */
  Stream<int> counter() {
    return Stream.periodic(const Duration(seconds: 1), (i) {
      return i;
    });
  }
}
