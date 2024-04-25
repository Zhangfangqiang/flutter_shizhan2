import 'pages/dynamic/dynamic.dart';
import 'pages/message/message.dart';
import 'pages/category/category.dart';
import 'package:flutter/material.dart';
import 'pages/mine_sliver/mine_sliver.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _index = 0;

  final List<Widget> _homeWidgets = [
    DynamicPage(),
    MessagePage(),
    CategoryPage(),
    MineSliverPage(),
  ];

  void _onBottomNagigationBarTapped(index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: IndexedStack(
          index: _index,
          children: _homeWidgets,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onBottomNagigationBarTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          _getBottomNavItem('动态', 'imgs/dynamic.png', 'imgs/dynamic-hover.png'),
          _getBottomNavItem('消息', 'imgs/message.png', 'imgs/message-hover.png'),
          _getBottomNavItem('分类浏览', 'imgs/category.png', 'imgs/category-hover.png'),
          _getBottomNavItem('个人中心', 'imgs/mine.png', 'imgs/mine-hover.png'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _getBottomNavItem(
      String title, String normalIcon, String activeIcon) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        normalIcon,
        width: 32,
        height: 28,
      ),
      activeIcon: Image.asset(
        activeIcon,
        width: 32,
        height: 28,
      ),
      label: title,
    );
  }
}
