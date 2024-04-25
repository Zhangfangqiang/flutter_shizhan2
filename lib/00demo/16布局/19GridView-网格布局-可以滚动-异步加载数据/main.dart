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
            appBar: AppBar(title: Text("滚动控制")),
            body: AnimatedListRoute())
    );
  }
}

/**
 * 有状态的组件
 */
class AnimatedListRoute extends StatefulWidget {
  const AnimatedListRoute({Key? key}) : super(key: key);
  @override
  _AnimatedListRouteState createState() => _AnimatedListRouteState();
}

class _AnimatedListRouteState extends State<AnimatedListRoute> {
  var data = <String>['1', '2', '3', '4', '5'];
  final globalKey = GlobalKey<AnimatedListState>();     //理解为ref

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedList(
          key: globalKey,
          initialItemCount: data.length,
          itemBuilder: (BuildContext context, int index, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: buildItem(context, index),
            );
          },
        ),
        buildAddBtn(),
      ],
    );
  }

  /**
   * 添加按钮
   */
  Widget buildAddBtn() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          data.add('${int.parse(data[data.length - 1]) + 1}');
          globalKey.currentState!.insertItem(data.length - 1);
          print('添加 ${int.parse(data[data.length - 1]) + 1}');
        },
      ),
    );
  }

  /**
   * item 行
   */
  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      // 数字不会重复，所以作为Key
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        // 点击时删除
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  /**
   * item 行里面的删除按钮
   */
  void onDelete(context, index) {
    setState(() {
      globalKey.currentState!.removeItem(index, (context, animation) {
          // 删除过程执行的是反向动画，animation.value 会从1变为0
          var item = buildItem(context, index);
          print('删除 ${data[index]}');
          data.removeAt(index);     //数据进行移除了

          //让透明度变化的更快一些
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0),
            ),
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0.0,
              child: item,
            ),
          );

        },
        duration: const Duration(milliseconds: 100),
      );
    });
  }
}
