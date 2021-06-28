import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:omnirio/screens/calculator.dart';
import 'package:omnirio/screens/settings.dart';
import 'package:omnirio/screens/showProfile.dart';
import '../preferencesUtils.dart';
import 'addProfile.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName;

  @override
  void initState() {
    super.initState();
    _userName = PreferencesUtils.getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.black),
          onPressed: () => signOutUser(),
        ),
        title: Text('Hi ' + _userName.toString(),
            style: TextStyle(color: Colors.black, fontSize: 16)),
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          NavigationScreenWidget(
              navScreenId: AddProfileScreen.id, navHeader: "Add profile"),
          NavigationScreenWidget(
              navScreenId: Settings.id, navHeader: "Settings"),
          NavigationScreenWidget(
              navScreenId: Calculator.id, navHeader: "Calculator"),
          NavigationScreenWidget(
              navScreenId: ShowProfileScreen.id, navHeader: "Show profile"),
        ],
      ),
    );
  }

  signOutUser() {
    PreferencesUtils.setLoginStatus(false);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }
}

class NavigationScreenWidget extends StatelessWidget {
  NavigationScreenWidget({this.navScreenId, this.navHeader});

  final String navScreenId;
  final String navHeader;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, navScreenId);
          },
          child: Text(navHeader),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
        ),
      ),
    );
  }
}
