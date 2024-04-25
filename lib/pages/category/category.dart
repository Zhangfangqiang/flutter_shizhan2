import '../../components/button_util.dart';
import '../../routers/router_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('分类', style: Theme.of(context).textTheme.headline4),
          systemOverlayStyle: SystemUiOverlayStyle.light),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonUtil.primaryTextButton('登录', () {
              Navigator.of(context).pushNamed(RouterTable.loginPath);
            }, context),
            SizedBox(
              height: 10,
            ),

            ButtonUtil.primaryTextButton('404', () {
              Navigator.of(context).pushNamed('不存在的路由名称就会来到404');
            }, context),
          ],
        ),
      ),
    );
  }
}
