import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*页面开始*/
import '../app.dart';
import '../pages/login/login.dart';
import '../pages/splash/splash.dart';
import '../pages/not_found/not_found.dart';
import '../pages/dynamicDetail/dynamicDetail.dart';

class RouterTable {
  static String splashPath = 'splash';
  static String loginPath = 'login';
  static String homePath = '/';
  static String notFoundPath = '404';
  static String dynamicDetail = 'dynamicDetail';

  static Map<String, WidgetBuilder> routeTables = {
    //404页面
    notFoundPath: (context) => NotFound(),
    //启动页
    splashPath: (context) => Splash(),
    //登录
    loginPath: (context) => LoginPage(),
    //首页
    homePath: (context) => AppHomePage(),
    //详情页
    dynamicDetail: (context) => DynamicDetail(),
  };

  /**
   * 路由拦截
   */
  static Route onGenerateRoute<T extends Object>(RouteSettings settings) {
    return CupertinoPageRoute<T>(
      settings: settings,
      builder: (context) {
        String? name = settings.name;
        if (routeTables[name] == null) {
          name = notFoundPath;
        }

        Widget widget = routeTables[name]!(context);

        return widget;
      },
    );
  }

}