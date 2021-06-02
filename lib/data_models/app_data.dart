import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserData {
  String _userId;
  String _username;
  String _token;
  double _balance;

  UserData(String userId, String username, String token, double age) {
    _userId = userId;
    _username = username;
    _token = token;
    _balance = age;
  }

  Map<String, dynamic> toJson() => {
        "userId": _userId,
        "username": _username,
        "token": _token,
        "balance": _balance
      };

  UserData.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _username = json['username'];
    _token = json['token'];
    _balance = json['balance'];
  }


  String get userId => _userId;
  String get username => _username;
  String get token => _token;
  double get balance => _balance;
}
