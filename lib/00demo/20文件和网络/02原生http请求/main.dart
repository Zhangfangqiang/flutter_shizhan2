import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
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
            appBar: AppBar(title: const Text("滚动控制")),
            body:  HttpTestRoute()));
  }
}

class HttpTestRoute extends StatefulWidget {
  @override
  _HttpTestRouteState createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            child: Text("获取百度首页"),
            onPressed: _loading ? null : request,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(_text.replaceAll(RegExp(r"\s"), "")),
          )
        ],
      ),
    );
  }

  request() async {
    setState(() {
      _loading = true;
      _text = "正在请求...";
    });

    try {
      HttpClient httpClient = HttpClient();                                                         //创建一个HttpClient
      HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));      //打开Http连接

      /*使用iPhone的UA*/
      request.headers.add(
        "user-agent",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
      );

      HttpClientResponse response = await request.close();      //等待连接服务器（会将请求信息发送给服务器）
      _text = await response.transform(utf8.decoder).join();    //读取响应内容
      print(response.headers);                                  //输出响应头
      httpClient.close();                                       //关闭client后，通过该client发起的所有请求都会中止。
    } catch (e) {
      _text = "请求失败：$e";
      /*finally 关键字用于定义一段无论是否发生异常都会执行的代码块*/
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
