import 'package:blogger_app/storage/share_prefs_app_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginRepository{

  Future<String> userLogin(String email, String password) async {
    // ignore: prefer_collection_literals
    var reqBody = Map();

    reqBody['email'] = email;
    reqBody['password'] = password;
    // reqBody['password'] = sha1.convert(utf8.encode(password)).toString();


    final response = await http.post(
        'https://3ded615a21de.ngrok.io/distributor/login',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reqBody)
    );

    if (response.statusCode == 200) {
      print(response.body.runtimeType);
      var object = json.decode(response.body);

      if(object['status'] == 'pass') {
        SharedPref sharedPref = SharedPref();
        await sharedPref.save(json.encode(object['user']));

        return null;
      }

      return object['message'];

    } else if (response.statusCode == 422) {
      //
      return "Input errors";

    } else {
      // When the device is not connected to the internet
      return "Network";
    }

  }

}