import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  // Check if local data exists
  Future<bool> check() async {
    return Future.delayed(Duration(seconds: 5))
    .then((value) async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('data')) {
        return true;
      }
      return false;

    });

  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString("data"));
  }

  save(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("data", json.encode(value));
  }

  remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("data");
  }
}
