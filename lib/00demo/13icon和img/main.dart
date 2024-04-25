import 'package:flutter/material.dart';

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
        /*外部必须套一个Navigator*/
        home:Scaffold(
          appBar: AppBar(
            title: Text("New route"),
          ),
          body: Center(
            child: IconFontsRoute(),
          ),
        )
    );
  }
}

/**
 * 无状态组件 展示Image组件的使用
 **********************************8
 * this.width,                            //图片的宽
 * this.height,                           //图片高度
 * this.color,                            //图片的混合色值
 * this.colorBlendMode,                   //混合模式
 * this.fit,                              //缩放模式
 * this.alignment = Alignment.center,     //对齐方式
 * this.repeat = ImageRepeat.noRepeat,    //重复方式
 */
class ImageAndIconRoute extends StatelessWidget {
  const ImageAndIconRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var img = const AssetImage("imgs/avatar.png");

    return SingleChildScrollView(
      child: Column(
          children: <Image>[
        Image(
          image: img,
          height: 50.0,
          width: 100.0,
          fit: BoxFit.fill,
        ),
        Image(
          image: img,
          height: 50,
          width: 50.0,
          fit: BoxFit.contain,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 50.0,
          fit: BoxFit.fitWidth,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 50.0,
          fit: BoxFit.fitHeight,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 50.0,
          fit: BoxFit.scaleDown,
        ),
        Image(
          image: img,
          height: 50.0,
          width: 100.0,
          fit: BoxFit.none,
        ),
        Image(
          image: img,
          width: 100.0,
          color: Colors.blue,
          colorBlendMode: BlendMode.difference,
          fit: BoxFit.fill,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 200.0,
          repeat: ImageRepeat.repeatY,
        ),
            Image(
              image: NetworkImage("https://www.zfajax.com/wp-content/uploads/2023/10/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20231017225150.png"),
              width: 100.0,
            )
      ].map((e) {
        return Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 100,
                child: e,
              ),
            ),
            Text(e.fit.toString())
          ],
        );
      }).toList()),
    );
  }
}

/**
 * 无状态组件 展示 Icon组件的使用
 * 打开 https://fonts.google.com/icons?selected=Material+Icons:search:&icon.platform=flutter
 * 选择选择对应的图标直接进行复制粘贴
 */
class IconFontsRoute extends StatelessWidget {
  const IconFontsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*粘贴下来的案例*/
        Icon(
          Icons.search,
        ),
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text(
          '\uE287' * 20,
          style: const TextStyle(
            fontFamily: "MaterialIcons",
            fontSize: 24.0,
            color: Colors.green,
          ),
        ),
        showIcons(),
      ],
    );
  }


  Widget showIcons() {
    String icons = "";
    // accessible: 0xe03e
    icons += "\uE03e";
    // error:  0xe237
    icons += " \uE237";
    // fingerprint: 0xe287
    icons += " \uE287";

    return Text(
      icons,
      style: const TextStyle(
        fontFamily: "MaterialIcons",
        fontSize: 24.0,
        color: Colors.green,
      ),
    );
  }
}
