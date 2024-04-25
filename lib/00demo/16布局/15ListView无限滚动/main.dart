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
        home: Scaffold(
          appBar: AppBar(
            title: Text("New route"),
          ),
          body: const Center(
            child: InfiniteListView(),
          ),
        ));
  }
}

/**
 * 有状态的组件
 */
class InfiniteListView extends StatefulWidget {
  const InfiniteListView({Key? key}) : super(key: key);
  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

/**
 * InfiniteListView状态和ui的具体实现
 */
class _InfiniteListViewState extends State<InfiniteListView> {
  final _words = <String>[loadingTag];
  static const loadingTag = "##loading##"; //表尾标记

  /**
   * 初始化方法
   */
  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        /*重新构建列表*/
        _words.insertAll(
          _words.length - 1,
          /*每次生成20个单词*/
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      /*item构建*/
      itemBuilder: (context, index) {
        /*如果到了表尾的字符串*/
        if (_words[index] == loadingTag) {
          /*不足100条，继续获取数据*/
          if ((_words.length - 1) < 100) {
            /*获取数据*/
            _retrieveData();
            /*加载时显示loading*/
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const SizedBox(
                width: 24.0,
                height: 24.0,
                /*进度条加载显示2秒*/
                child: CircularProgressIndicator(strokeWidth: 1.0),
              ),
            );
          }

          /*已经加载了100条数据，不再获取数据。*/
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "没有更多了",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        /*显示单词列表项*/
        return ListTile(title: Text(_words[index]));
      },
      /*分割线*/
      separatorBuilder: (context, index) => const Divider(height: .0)
    );
  }
}