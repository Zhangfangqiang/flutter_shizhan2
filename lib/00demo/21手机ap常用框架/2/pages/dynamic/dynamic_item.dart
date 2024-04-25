import 'package:flutter/material.dart';
import '../../routers/router_table.dart';
import 'package:cached_network_image/cached_network_image.dart';


class DynamicItem extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;
  final int viewCount;
  static const double MARGIN_SIZE = 10;
  static const double ITEM_HEIGHT = 100;
  static const double TITLE_HEIGHT = 80;

  const DynamicItem(
      {Key? key,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.viewCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(MARGIN_SIZE),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageWrapper(imageUrl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleWrapper(context, title),
                  _viewCountWrapper(viewCount.toString()),
                ],
              ),
            )
          ],
        ),
      ),

      /**
       * 点击了item组件的时候
       */
      onTap: () async {
        var arguments = await Navigator.of(context).pushNamed(RouterTable.dynamicDetail, arguments: {'id': id});      //打开页面并且等待页面返回结果

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("从动态${(arguments as Map<String, dynamic>)['id']}返回"),
        ));
      },
    );
  }

  Widget _titleWrapper(BuildContext context, String text) {
    return Container(
      height: TITLE_HEIGHT,
      margin: EdgeInsets.fromLTRB(MARGIN_SIZE, 0, 0, 0),
      child: Text(
        this.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _viewCountWrapper(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(MARGIN_SIZE, 0, 0, 0),
      height: ITEM_HEIGHT - TITLE_HEIGHT,
      child: Row(children: [
        const Icon(
          Icons.remove_red_eye_outlined,
          size: 14.0,
          color: Colors.grey,
        ),
        SizedBox(width: 5),
        Text(
          this.viewCount.toString(),
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
      ]),
    );
  }

  Widget _imageWrapper(String imageUrl) {
    try {
      return SizedBox(
        width: 150,
        height: ITEM_HEIGHT,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              LinearProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) =>
              Image.asset('imgs/image-failed.png'),
        ),
      );
    } catch (e, stacktrace) {
      return SizedBox(width: 150, height: ITEM_HEIGHT);
    }
  }
}
