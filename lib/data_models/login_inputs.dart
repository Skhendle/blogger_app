import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginUser {
  String _username;
  String _password;

  LoginUser(String username, String password) {
    _username = username;
    _password = password;
  }

  String get username => _username;
  String get hashed_password => sha1.convert(utf8.encode(_password)).toString();
}