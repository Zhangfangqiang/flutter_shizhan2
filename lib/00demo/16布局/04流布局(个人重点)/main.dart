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
          body: const Center(
            child: WrapAndFlowRoute(),
          ),
        ));
  }
}

class WrapAndFlowRoute extends StatelessWidget {
  const WrapAndFlowRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [buildWrap(), buildFlow()],
    );
  }

  Widget buildWrap() {
    return const Wrap(
      spacing: 8.0, // 主轴(水平)方向间距
      runSpacing: 4.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center, //沿主轴方向居中
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
          label: Text('Lafayette'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
          label: Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
          label: Text('Laurens'),
        ),
      ],
    );
  }

  Widget buildFlow() {
    return Flow(
      delegate: TestFlowDelegate(margin: const EdgeInsets.all(10.0)),
      children: <Widget>[
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.red,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.green,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.blue,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.yellow,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.brown,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  double width = 0;
  double height = 0;
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return const Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
