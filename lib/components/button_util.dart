import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonUtil {
  static Widget primaryTextButton(
      String title, Function onPressed, BuildContext context,
      {double height = 50, double width = 200}) {

    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        ),
        child: Text(
          title,
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
