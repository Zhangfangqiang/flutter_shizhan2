import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicDetail extends StatelessWidget {
  const DynamicDetail({Key ?key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var routeParams = ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>?;
    print('routeParams${routeParams}');

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('动态详情'), systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Center(
          child: Text("产品 id: ${routeParams?['id']}"),
        ),
      ),
      /**
       * 当用户尝试关闭页面的时候调用它
       */
      onWillPop: () async {
        print('routeParams:${routeParams?['id']}');
        Navigator.of(context).pop({'id': routeParams?['id']});
        return true;
      },
    );
  }
}
