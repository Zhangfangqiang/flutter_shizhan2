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
            child: ClipRoute(),
          ),
        ));
  }
}


class ClipRoute extends StatelessWidget {
  const ClipRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 头像
    Image avatar = Image.asset("imgs/avatar.png", width: 60.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /*不剪裁*/
        avatar,
        /*剪裁为圆形*/
        ClipOval(child: avatar),
        /*剪裁为圆角矩形*/
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: avatar,
        ),
        ClipPath(
          child: avatar,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              widthFactor: .5, //宽度设为原来宽度一半，另一半会溢出,但会显示
              child: avatar,
            ),
            const Text(
              "你好世界",
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRect(
              //将溢出部分剪裁
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: .5, //宽度设为原来宽度一半
                child: avatar,
              ),
            ),
            const Text("你好世界", style: TextStyle(color: Colors.green))
          ],
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: ClipRect(
            clipper: MyClipper(), //使用自定义的clipper
            child: avatar,
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: MyClipRect(
            child: avatar,
          ),
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => const Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
class MyClipRect extends StatelessWidget {
  const MyClipRect({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var rect = const Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);
    return ClipRect(
      child: SizedBox(
        width: rect.width,
        height: rect.height,
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
