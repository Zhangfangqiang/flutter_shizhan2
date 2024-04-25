import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './grid_mock_data.dart';

class MineSliverPage extends StatelessWidget {
  static const MARGIN = 8.0;
  static const INNER_MARGIN = 16.0;
  const MineSliverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          _getAppBar('个人中心'),
          _headerGridButtons(),
          _getMenuTitle('金融理财'),
          _gridButtons(GridMockData.financeGrids()),
          _getMenuTitle('生活服务'),
          _gridButtons(GridMockData.serviceGrids()),
          _getMenuTitle('购物消费'),
          _gridButtons(GridMockData.thirdpartyGrids()),
        ],
      ),
    );
  }

  SliverAppBar _getAppBar(String title) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title),
        background: Image.asset(
          "imgs/sea.png",
          fit: BoxFit.cover,
        ),
      ), systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _headerGridButtons() {
    double height = 144;
    List<Map<String, String>> buttons = GridMockData.headerGrids();
    return SliverToBoxAdapter(
      child: Container(
        height: height,
        margin: EdgeInsets.fromLTRB(MARGIN, MARGIN, MARGIN, MARGIN / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF56AF6D),
                Color(0xFF56AA6D),
              ]),
        ),
        child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons
                  .map((item) => _getMenus(item['icon']!, item['name']!, color: Colors.white))
                  .toList()),
        ),
      ),
    );
  }

  Widget _getMenuTitle(String title) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(MARGIN, MARGIN, MARGIN, MARGIN / 2),
        padding: EdgeInsets.all(MARGIN),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
    );
  }

  SliverGrid _gridButtons(List<Map<String, String>> buttons,
      {int crossAxisCount = 4, Color textColor = Colors.black}) {
    double gridSpace = 5.0;
    return SliverGrid.count(
      crossAxisSpacing: gridSpace,
      mainAxisSpacing: gridSpace,
      crossAxisCount: crossAxisCount,
      children: buttons.map((item) {
        return _getMenus(item['icon']!, item['name']!, color: textColor);
      }).toList(),
    );
  }
}

Column _getMenus(String icon, String name, {Color color = Colors.black}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(icon),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(name, style: TextStyle(fontSize: 14.0, color: color, height: 1)),
    ],
  );
}
