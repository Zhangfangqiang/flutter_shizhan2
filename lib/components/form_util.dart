import 'package:flutter/material.dart';

class FormUtil {
  /**
   * 文本输入框UI
   */
  static Widget textField(
    String formKey,
    String value, {
    TextInputType keyboardType = TextInputType.text,
    FocusNode? focusNode,
    required String hintText,
    required IconData prefixIcon,
    controller = TextEditingController,
    onChanged = Function,
    onClear = Function,
    obscureText = false,
    height = 55.0,
    margin = 10.0,
  }) {
    return Container(
      height: height,
      margin: EdgeInsets.all(margin),
      child: Column(
        children: [
          TextField(
              keyboardType: keyboardType,
              focusNode: focusNode,
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                icon: Icon(
                  prefixIcon,
                  size: 20.0,
                ),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  child: Offstage(
                    child: Icon(Icons.clear),
                    offstage: value == null || value == '',
                  ),
                  onTap: () {
                    onClear(formKey);
                  },
                ),
              ),
              onChanged: (value) {
                onChanged(formKey, value);
              }),
          Divider(
            height: 1.0,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
