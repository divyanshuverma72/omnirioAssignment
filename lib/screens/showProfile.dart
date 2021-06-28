import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omnirio/preferencesUtils.dart';

import '../constants.dart';

class ShowProfileScreen extends StatefulWidget {
  static const String id = 'show_profile_screen';

  @override
  _ShowProfileScreen createState() => _ShowProfileScreen();
}

class _ShowProfileScreen extends State<ShowProfileScreen> {
  String _firstName = "";
  String _lastName = "";
  String _emailId = "";
  String _phoneNumber = "";
  String _address = "";

  bool _isEditingText = false;
  TextEditingController _nameEditingController;
  TextEditingController _lastNameEditingController;
  TextEditingController _emailEditingController;
  TextEditingController _phoneEditingController;
  TextEditingController _addressEditingController;

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
            _editTitleTextField("First name", PreferencesUtils.getFirstName(),
                _nameEditingController),
            SizedBox(
              height: 8.0,
            ),
            _editTitleTextField("Last name", PreferencesUtils.getLastName(),
                _lastNameEditingController),
            SizedBox(
              height: 8.0,
            ),
            _editTitleTextField("Email id", PreferencesUtils.getEmailId(),
                _emailEditingController),
            SizedBox(
              height: 8.0,
            ),
            _editTitleTextField("Phone no.", PreferencesUtils.getPhoneNo(),
                _phoneEditingController),
            SizedBox(
              height: 8.0,
            ),
            _editTitleTextField("Address", PreferencesUtils.getAddress(),
                _addressEditingController),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () => updateProfileInfo(),
                  height: 42.0,
                  child: Text(
                    "Update",
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
    _nameEditingController =
        TextEditingController(text: PreferencesUtils.getFirstName());
    _lastNameEditingController =
        TextEditingController(text: PreferencesUtils.getLastName());
    _emailEditingController =
        TextEditingController(text: PreferencesUtils.getEmailId());
    _phoneEditingController =
        TextEditingController(text: PreferencesUtils.getPhoneNo());
    _addressEditingController =
        TextEditingController(text: PreferencesUtils.getAddress());
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _lastNameEditingController.dispose();
    _emailEditingController.dispose();
    _phoneEditingController.dispose();
    _addressEditingController.dispose();
    super.dispose();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  updateProfileInfo() {
    try {
      assert(EmailValidator.validate(_emailId));
    } catch (error) {
      showToast("Enter a valid email");
      return;
    }

    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(_phoneNumber)) {
      showToast("Enter a valid phone number");
      return;
    }

    PreferencesUtils.setFirstName(_firstName);
    PreferencesUtils.setLastName(_lastName);
    PreferencesUtils.setEmailId(_emailId);
    PreferencesUtils.setPhoneNo(_phoneNumber);
    PreferencesUtils.setAddress(_address);

    showToast("Updated successfully");
  }

  Widget _editTitleTextField(
      String field, String value, TextEditingController controller) {
    if (_isEditingText)
      return TextField(
        onChanged: (newValue) {
          if (field == "First name") {
            _firstName = newValue;
          } else if (field == "Last name") {
            _lastName = newValue;
          } else if (field == "Email id") {
            _emailId = newValue;
          } else if (field == "Phone no.") {
            _phoneNumber = newValue;
          } else if (field == "Address") {
            _address = newValue;
          }
          _isEditingText = false;
        },
        autofocus: true,
        controller: controller,
        decoration:
            kTextFieldDecoration.copyWith(hintText: 'Enter your $field'),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          field + " : " + value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
}
