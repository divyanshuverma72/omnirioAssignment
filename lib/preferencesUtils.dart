import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtils {
  static SharedPreferences _pref;

  static Future<bool> init() async {
    _pref = await SharedPreferences.getInstance();
    return getLoginStatus();
  }

  static bool isUserAvailable(String userName) {
    return _pref.containsKey(userName);
  }

  static void setUserName(String name) {
    _pref.setString("userName", name);
  }

  static String getUserName() {
    return _pref.getString("userName");
  }

  static void setPassword(String pass) {
    _pref.setString("password", pass);
  }

  static String getPassword() {
    return _pref.getString("password");
  }

  static void setLoginStatus(bool isLoggedIn) {
    _pref.setBool("isLoggedIn", isLoggedIn);
  }

  static void setFirstName(String name) {
    _pref.setString("firstName", name);
  }

  static String getFirstName() {
    return _pref.getString("firstName") ??
        "First add your first name in add profile or click here to update.";
  }

  static void setLastName(String name) {
    _pref.setString("lastName", name);
  }

  static String getLastName() {
    return _pref.getString("lastName") ??
        "First add your last name in add profile or click here to update.";
  }

  static void setEmailId(String email) {
    _pref.setString("email", email);
  }

  static String getEmailId() {
    return _pref.getString("email") ??
        "First add your email in add profile or click here to update.";
  }

  static void setPhoneNo(String phone) {
    _pref.setString("phone", phone);
  }

  static String getPhoneNo() {
    return _pref.getString("phone") ??
        "First add your phone number in add profile or click here to update.";
  }

  static void setAddress(String address) {
    _pref.setString("address", address);
  }

  static String getAddress() {
    return _pref.getString("address") ??
        "First add your address in add profile or click here to update.";
  }

  static bool getLoginStatus() {
    return _pref.getBool("isLoggedIn") ?? false;
  }
}
