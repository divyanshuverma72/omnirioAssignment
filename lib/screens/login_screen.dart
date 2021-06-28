import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omnirio/screens/home_screen.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../preferencesUtils.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _userName = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 150.0,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset('images/Ominiriologo.png')),
                radius: 80.0,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _userName = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your user name'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: loginUser,
                  height: 42.0,
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  loginUser() {
    if (PreferencesUtils.isUserAvailable("userName")) {
      if (PreferencesUtils.getUserName() == _userName &&
          PreferencesUtils.getPassword() == _password) {
        PreferencesUtils.setLoginStatus(true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      } else {
        showToast(
            "Wrong  user  name  or  password ,  kindly  use the credentials that  were  used  for the first time or the updated password.");
      }
    } else {
      PreferencesUtils.setUserName(_userName);
      PreferencesUtils.setPassword(_password);
      PreferencesUtils.setLoginStatus(true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }
}
