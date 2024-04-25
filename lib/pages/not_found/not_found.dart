import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Center(
        child: Text('404！抱歉，页面未找到！'),
      ),
    );
  }
}
