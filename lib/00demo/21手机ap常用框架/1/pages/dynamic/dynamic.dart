import './dynamic_item.dart';
import './dynamic_mock_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class DynamicPage extends StatefulWidget {
  DynamicPage({super.key});

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  int _currentPage = 1;
  static const int PAGE_SIZE = 20;
  List<Map<String, Object>> _listItems = [];

  /**
   * 生命周期方法初始化数据
   */
  @override
  initState(){
    super.initState();
    _requestNewItems();
  }

  void _refresh() async {
    _currentPage = 1;
    _requestNewItems();
  }

  void _load() async {
    _currentPage += 1;
    _requestNewItems();
  }

  void _requestNewItems() async {
    List<Map<String, Object>> _newItems = await DynamicMockData.list(_currentPage, PAGE_SIZE);
    setState(() {
      if (_currentPage > 1) {
        _listItems += _newItems;
      } else {
        _listItems = _newItems;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态', style: Theme.of(context).textTheme.headline4), systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: EasyRefresh(
        onRefresh: () async {
          _refresh();
        },
        onLoad: () async {
          _load();
        },
        child: ListView.builder(
            itemCount: _listItems.length,
            itemBuilder: (context, index) {
              return DynamicItem(
                  title     : _listItems[index]['title'] as String,
                  imageUrl  : _listItems[index]['imageUrl'] as String,
                  viewCount : _listItems[index]['viewCount'] as int);
            }),
      ),
    );
  }
}
