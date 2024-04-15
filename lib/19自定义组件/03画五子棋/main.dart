import './common.dart';
import 'package:flutter/material.dart' hide Page;

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
            appBar: AppBar(title: const Text("滚动控制")), body: const CustomPaintRoute()));
  }
}


class CustomPaintRoute extends StatelessWidget {
  const CustomPaintRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              size: const Size(300, 300), /*指定画布大小*/
              painter: MyPainter(),
            ),
          ),
          RepaintBoundary(
              child: ElevatedButton(onPressed: () {}, child: const Text("刷新")))
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    //画棋盘
    drawChessboard(canvas, rect);
    //画棋子
    drawPieces(canvas, rect);
  }

  // 在实际场景中正确使用此方法可以避免重绘开销，我们简单的返回false
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
