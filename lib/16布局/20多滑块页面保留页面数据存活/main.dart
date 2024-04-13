import 'dart:ui';
import 'dart:math' as math;
import './keepalive.dart';
import './page_scaffold.dart';
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
            appBar: AppBar(title: Text("滚动控制")), body: PageViewTest()));
  }
}

class PageViewTest extends StatefulWidget {
  const PageViewTest({Key? key}) : super(key: key);
  @override
  _PageViewTestState createState() => _PageViewTestState();
}
class _PageViewTestState extends State<PageViewTest> {
  PageController pageController = PageController();

  Map<String, dynamic> jsonData = {
    'buildType': 1,
    'reverse': false,
    'pageSnapping': true,
    'withPageStorageKey': false,
    'allowImplicitScrolling': false,
    'wrapWithKeepAliveWrapper': false,
    'scrollDirection': Axis.horizontal,
  };

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    print("build");

    for (int i = 0; i < 6; ++i) {
      Widget child = Page(
        key: jsonData['withPageStorageKey'] ? PageStorageKey('$i') : null,
        text: '$i',
        buildType: jsonData['buildType'],
      );
      if (jsonData['wrapWithKeepAliveWrapper']) child = KeepAliveWrapper(child: child);
      children.add(child);
    }

    return PageView(
      controller: pageController,
      pageSnapping: jsonData['pageSnapping'],
      scrollDirection: jsonData['scrollDirection'],
      reverse: jsonData['reverse'],
      allowImplicitScrolling: jsonData['allowImplicitScrolling'],
      children: [buildConfigPage(context), ...children],
    );
  }

  /**
   * 配置页面
   */
  Widget buildConfigPage(context) {
    var size = MediaQueryData.fromWindow(window).size;

    return FittedBox(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: size.width),
        child: Column(
          children: [
            /*表单开始*/
            ExpansionTile(
              title: const Text("页面类型"),
              initiallyExpanded: true,
              children: [
                RadioListTile(
                  value: 1,
                  title: const Text('数字'),
                  groupValue: jsonData['buildType'] as int,
                  onChanged: buildTypeChange,
                ),
                RadioListTile(
                  value: 2,
                  title: const Text('别表'),
                  groupValue: jsonData['buildType'] as int,
                  onChanged: buildTypeChange,
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("滑动方向"),
              initiallyExpanded: true,
              children: [
                RadioListTile(
                  value: Axis.horizontal,
                  title: const Text('水平'),
                  groupValue: jsonData['scrollDirection'] as Axis,
                  onChanged: scrollDirectionChange,
                ),
                RadioListTile(
                  value: Axis.vertical,
                  title: const Text('垂直'),
                  groupValue: jsonData['scrollDirection'] as Axis,
                  onChanged: scrollDirectionChange,
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("其它配置"),
              initiallyExpanded: true,
              children: [
                CheckboxListTile(
                  value: jsonData['reverse'],
                  title: const Text('反方向滑动'),
                  onChanged: (v) => setState(() {
                    jsonData['reverse'] = v!;
                  }),
                ),
                CheckboxListTile(
                  value: jsonData['pageSnapping'],
                  title: const Text('一页一页翻'),
                  onChanged: (v) => setState(() {
                    jsonData['pageSnapping'] = v!;
                  }),
                ),
                CheckboxListTile(
                  value: jsonData['withPageStorageKey'],
                  title: const Text('添加PageStorageKey'),
                  onChanged: (v) => setState(() {
                    jsonData['withPageStorageKey'] = v!;
                  }),
                ),
                CheckboxListTile(
                  value: jsonData['wrapWithKeepAliveWrapper'],
                  title: const Text('KeepAlive'),
                  onChanged: (v) {
                    setState(() {
                      jsonData['wrapWithKeepAliveWrapper'] = v!;
                      if (jsonData['wrapWithKeepAliveWrapper']) {
                        jsonData['allowImplicitScrolling'] = false;
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  value: jsonData['allowImplicitScrolling'],
                  title: const Text('allowImplicitScrolling'),
                  onChanged: (v) {
                    setState(() {
                      jsonData['allowImplicitScrolling'] = v!;
                      if (jsonData['allowImplicitScrolling']) {
                        jsonData['wrapWithKeepAliveWrapper'] = false;
                      }
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              child: const Text("打开新路由页"),
              onPressed: () {
                /*路由跳转开始*/
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PageScaffold(
                    title: 'xx',
                    body: const Center(child: Text('xx')),
                  );
                }));
                /*路由跳转结束*/
              },
            ),
            /*表单结束*/
          ],
        ),
      ),
    );
  }

  /**
   * 页面类型修改
   */
  buildTypeChange(int? v) {
    setState(() {
      jsonData['buildType'] = v!;
      if (jsonData['buildType'] == 2) {
        jsonData['scrollDirection'] = Axis.horizontal;
      }
    });
  }

  /**
   * 滚动方向修改
   */
  scrollDirectionChange(Axis? v) {
    setState(() {
      jsonData['scrollDirection'] = v!;
      if (jsonData['scrollDirection'] == Axis.vertical) {
        jsonData['buildType'] = 1;
      }
    });
  }
}


class Page extends StatefulWidget {
  final String text;
  final int buildType;
  const Page({
    Key? key,
    required this.text,
    required this.buildType,
  }) : super(key: key);
  @override
  _PageState createState() => _PageState();
}
class _PageState extends State<Page> {
  @override
  void initState() {
    super.initState();
    print("initState ${widget.text}");
  }

  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    return widget.buildType == 1 ? buildNumber() : buildList();
  }

  Widget buildList() {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(title: Text('$index')),
    );
  }

  Widget buildNumber() {
    return Center(child: Text(widget.text, textScaleFactor: 5));
  }
}