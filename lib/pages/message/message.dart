import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  /**
   * 页面编译开始
   */
  @override
  Widget build(BuildContext context) {

    List<String> _options = List<String>.generate(20, (index) => "选项$index");

    return Scaffold(
      appBar: AppBar(
        title: Text('消息', style: Theme.of(context).textTheme.headline4),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Center(
        child: Column(
          children: [
            _getTextButton(
              '基础底部弹层',
              onPressed: () async {
                int selectedIndex =
                    await _showBasicModalBottomSheet(context, _options) as int;
                print("基础底部弹层：选中了第$selectedIndex个选项");
              },
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            _getTextButton(
              '全屏底部弹层',
              onPressed: () async {
                int selectedIndex =
                    await _showFullScreenModalBottomSheet(context, _options)
                        as int;
                print("全屏底部弹层：选中了第$selectedIndex个选项");
              },
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            _getTextButton(
              '自定义底部弹层',
              onPressed: () async {
                int selectedIndex =
                    await _showCustomModalBottomSheet(context, _options) as int;
                print("自定义底部弹层：选中了第$selectedIndex个选项");
              },
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            _getTextButton(
              '多选弹层',
              onPressed: () async {
                List<int> selected = await _showMultiChoiceModalBottomSheet(context, _options) as List<int>;
                print("多选弹层：返回结果为$selected");
              },
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            _getTextButton(
              '非列表弹层',
              onPressed: () async {
                Object? obj = await _showWidgetModalBottomSheet(context);
                print("非列表弹层：返回结果为$obj");
              },
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  /**
   * 按钮组件
   */
  Widget _getTextButton(String title, {Function? onPressed, Color? foregroundColor, Color? backgroundColor}) {
    return Container(
      height: 50,
      width: 200,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor!),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor!),
        ),
        child: Text(title),
        onPressed: () {
          onPressed!();
        },
      ),
    );
  }

  /**
   * 01 基础底部弹层
   * ***************************************************************************
   * Future代表一个可能在未来完成的操作或计算。它是Dart中用于处理异步操作的概念。通常，
   * 当你需要执行一些耗时的操作，比如从网络获取数据或执行长时间的计算时，你会使用Future
   */
  Future<int?> _showBasicModalBottomSheet(context, List<String> options) async {
    return showModalBottomSheet<int>(
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(options[index]),
                onTap: () {
                  Navigator.of(context).pop(index);
                });
          },
          itemCount: options.length,
        );
      },
    );
  }

  /**
   * 02 全屏底部弹层
   * ***************************************************************************
   * Future代表一个可能在未来完成的操作或计算。它是Dart中用于处理异步操作的概念。通常，
   * 当你需要执行一些耗时的操作，比如从网络获取数据或执行长时间的计算时，你会使用Future
   */
  Future<int?> _showFullScreenModalBottomSheet(context, List<String> options) async {
    return showModalBottomSheet<int>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(options[index]),
                onTap: () {
                  Navigator.of(context).pop(index);
                });
          },
          itemCount: options.length,
        );
      },
    );
  }

  /**
   * 03 自定义底部弹出
   * ***************************************************************************
   * Future代表一个可能在未来完成的操作或计算。它是Dart中用于处理异步操作的概念。通常，
   * 当你需要执行一些耗时的操作，比如从网络获取数据或执行长时间的计算时，你会使用Future
   */
  Future<int?> _showCustomModalBottomSheet(context, List<String> options) async {
    return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: MediaQuery.of(context).size.height / 2.0,
          child: Column(children: [
            _getModalSheetHeader(context, '自定义底部弹窗'),
            const Divider(height: 1.0),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(options[index]),
                      onTap: () {
                        Navigator.of(context).pop(index);
                      });
                },
                itemCount: options.length,
              ),
            ),
          ]),
        );
      },
    );
  }

  /**
   * 04 多选弹层
   * ***************************************************************************
   * Future代表一个可能在未来完成的操作或计算。它是Dart中用于处理异步操作的概念。通常，
   * 当你需要执行一些耗时的操作，比如从网络获取数据或执行长时间的计算时，你会使用Future
   */
  Future<List<int>?> _showMultiChoiceModalBottomSheet(BuildContext context, List<String> options) async {
    Set<int> selected = <int>{};
    return showModalBottomSheet<List<int>>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context1, setState) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            height: MediaQuery.of(context).size.height / 2.0,
            child: Column(children: [
              _getModalSheetHeaderWithConfirm('多选底部弹窗',
                  /*取消按钮*/
                  onCancel: () {
                Navigator.of(context).pop();
              },
                  /*确认按钮*/
                  onConfirm: () {
                Navigator.of(context).pop(selected.toList());
              }),
              const Divider(height: 1.0),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: Icon(
                          selected.contains(index)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Theme.of(context).primaryColor),
                      title: Text(options[index]),
                      onTap: () {
                        setState(() {
                          if (selected.contains(index)) {
                            selected.remove(index);
                          } else {
                            selected.add(index);
                          }
                        });
                      },
                    );
                  },
                  itemCount: options.length,
                ),
              ),
            ]),
          );
        });
      },
    );
  }

  /**
   * 05 非列表按钮层
   * ***************************************************************************
   * Future代表一个可能在未来完成的操作或计算。它是Dart中用于处理异步操作的概念。通常，
   * 当你需要执行一些耗时的操作，比如从网络获取数据或执行长时间的计算时，你会使用Future
   */
  Future<Object?> _showWidgetModalBottomSheet(context) {
    return showModalBottomSheet<Object>(
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            height: 50,
            width: 200,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[400],
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue[400]!),
                ),
                child: Text('按钮'),
                onPressed: () {
                  Navigator.of(context).pop('非列表组件返回');
                }),
          ),
        );
      },
    );
  }

  Widget _getModalSheetHeaderWithConfirm(String title,
      {Function? onCancel, Function? onConfirm}) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              onCancel!();
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ),
          IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.blue,
              ),
              onPressed: () {
                onConfirm!();
              }),
        ],
      ),
    );
  }

  Widget _getModalSheetHeader(BuildContext context, String title) {
    return SizedBox(
      height: 50,
      child: Stack(
        textDirection: TextDirection.rtl,
        children: [
          Center(
            child: Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
