import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';

class Calculator extends StatefulWidget {
  static const String id = 'calculator_screen';

  @override
  _Calculator createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  String _firstNumber = "";
  String _secondNumber = "";
  String _chosenOperation;
  String _result = "";

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
                _firstNumber = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter first number here.'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                _secondNumber = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter second number here.'),
            ),
            DropdownButton<String>(
              focusColor: Colors.white,
              value: _chosenOperation,
              //elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: <String>[
                'Addition',
                'Substraction',
                'Multiplication',
                'Division',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              hint: Text(
                "Please choose an operation",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (String value) {
                setState(() {
                  _chosenOperation = value;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () => calculate(),
                  height: 42.0,
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Result : " + _result,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  calculate() {
    if (RegExp(r'^[0-9]+$').hasMatch(_firstNumber) &&
        RegExp(r'^[0-9]+$').hasMatch(_secondNumber)) {
      if ((_firstNumber.length > 1 && _firstNumber[0] == "0") ||
          (_secondNumber.length > 1 && _secondNumber[0] == "0")) {
        showToast("First digit can not be zero");
        return;
      } else if ((int.parse(_firstNumber) < int.parse(_secondNumber)) &&
          _chosenOperation == "Substraction") {
        showToast("First number can not be less than second number.");
        return;
      } else {
        if (_chosenOperation == "Addition") {
          setState(() {
            _result =
                (int.parse(_firstNumber) + int.parse(_secondNumber)).toString();
          });
        } else if (_chosenOperation == "Substraction") {
          setState(() {
            _result =
                (int.parse(_firstNumber) - int.parse(_secondNumber)).toString();
          });
        } else if (_chosenOperation == "Multiplication") {
          setState(() {
            _result =
                (int.parse(_firstNumber) * int.parse(_secondNumber)).toString();
          });
        } else if (_chosenOperation == "Division") {
          setState(() {
            _result =
                (int.parse(_firstNumber) / int.parse(_secondNumber)).toString();
          });
        }
      }
    } else {
      showToast("Kindly enter a valid or non negative number");
      return;
    }
  }
}
