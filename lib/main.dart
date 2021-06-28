import 'package:flutter/material.dart';
import 'package:omnirio/screens/addProfile.dart';
import 'package:omnirio/screens/calculator.dart';
import 'package:omnirio/screens/login_screen.dart';
import 'package:omnirio/screens/home_screen.dart';
import 'package:omnirio/screens/settings.dart';
import 'package:omnirio/screens/showProfile.dart';
import 'preferencesUtils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: PreferencesUtils.init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data == false) {
              return LoginScreen();
            } else {
              return HomeScreen();
            }
          }
          return CircularProgressIndicator();
        },
      ),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddProfileScreen.id: (context) => AddProfileScreen(),
        ShowProfileScreen.id: (context) => ShowProfileScreen(),
        Settings.id: (context) => Settings(),
        Calculator.id: (context) => Calculator(),
      },
    );
  }
}
