import 'package:flutter/material.dart' hide Page;

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
        home: Scaffold(
            appBar: AppBar(title: Text("滚动控制")), body: NotificationRoute()));
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}

class NotificationRoute extends StatefulWidget {
  const NotificationRoute({Key? key}) : super(key: key);

  @override
  NotificationRouteState createState() {
    return NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    /*监听通知*/
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        print(notification.msg);
        return false;
      },
      child: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + "  ";
          });
          return false;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              /**
               * 由于通知（MyNotification）的传播是通过 BuildContext 来定位到通知监听器的，
               * 因此在第一个按钮中，由于上下文不正确，导致无法将通知传播到监听器，而在第二个按钮中，
               * 由于使用了 Builder，使得上下文正确，所以可以成功将通知传播到监听器。
               */
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    /*按钮点击时分发通知*/
                    onPressed: () => MyNotification("Hi").dispatch(context),
                    child: const Text("Send Notification"),
                  );
                },
              ),
              Text(_msg)
            ],
          ),
        ),
      ),
    );
  }
}
