import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:omnirio/preferencesUtils.dart';

import '../constants.dart';

class AddProfileScreen extends StatefulWidget {
  static const String id = 'add_profile_screen';

  @override
  _AddProfileScreen createState() => _AddProfileScreen();
}

class _AddProfileScreen extends State<AddProfileScreen> {
  String _firstName = "";
  String _lastName = "";
  String _emailId = "";
  String _phoneNumber = "";
  String _address = "";

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
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                _firstName = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your first name'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                _lastName = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your last name'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _emailId = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onSubmitted: (value) {
                checkIfPhoneNumberIsValid();
              },
              onChanged: (value) {
                _phoneNumber = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your phone number'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                _address = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your address'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () => addProfileInfo(),
                  height: 42.0,
                  child: Text(
                    "Done",
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
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  addProfileInfo() {
    if (!checkIfEmailIsValid()) {
      return;
    }

    if (!checkIfPhoneNumberIsValid()) {
      return;
    }

    PreferencesUtils.setFirstName(_firstName);
    PreferencesUtils.setLastName(_lastName);
    PreferencesUtils.setEmailId(_emailId);
    PreferencesUtils.setPhoneNo(_phoneNumber);
    PreferencesUtils.setAddress(_address);

    showToast("Added successfully");
  }

  bool checkIfEmailIsValid() {
    try {
      assert(EmailValidator.validate(_emailId));
    } catch (error) {
      showToast("Enter a valid email");
      return false;
    }
    return true;
  }

  bool checkIfPhoneNumberIsValid() {
    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(_phoneNumber)) {
      showToast("Enter a valid phone number");
      return false;
    }
    return true;
  }
}
