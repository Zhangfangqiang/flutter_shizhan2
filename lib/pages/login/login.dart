import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/form_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, Map<String, Object>> _formData = {
    'username': {
      'value': '',
      'controller': TextEditingController(),
      'obsecure': false,
    },
    'password': {
      'value': '',
      'controller': TextEditingController(),
      'obsecure': true,
    },
  };

  _handleTextFieldChanged(String formKey, String value) {
    setState(() {
      _formData[formKey]?['value'] = value;
    });
  }

  _handleClear(String formKey) {
    setState(() {
      _formData[formKey]?['value'] = '';
      (_formData[formKey]?['controller'] as TextEditingController)?.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'), systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getRoundImage('imgs/logo.png', 100.0),
            SizedBox(
              height: 60,
            ),
            FormUtil.textField(
              'username',
              _formData['username']!["value"] as String,
              controller: _formData['username']?['controller'],
              hintText: '请输入手机号',
              prefixIcon: Icons.mobile_friendly,
              onChanged: _handleTextFieldChanged,
              onClear: _handleClear
            ),
            FormUtil.textField(
              'password',
              _formData['password']!['value'] as String,
              controller: _formData['password']?['controller'],
              obscureText: true,
              hintText: '请输入密码',
              prefixIcon: Icons.lock_open,
              onChanged: _handleTextFieldChanged,
              onClear: _handleClear,
            ),
            SizedBox(
              height: 10,
            ),
            _getLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _getRoundImage(String imageName, double size) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      ),
      child: Image.asset(
        imageName,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _getLoginButton() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
          MaterialStateProperty.all<Color>(Theme
              .of(context)
              .primaryColor),
        ),
        child: Text(
          '登录',
        ),
        onPressed: () {
          print('''Login: username=${(_formData['username']?['value'] as String).trim()}, 
              password=${(_formData['password']?['value'] as String).trim()}''');
        },
      ),
    );
  }
}