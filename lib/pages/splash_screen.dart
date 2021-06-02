import 'package:blogger_app/pages/login.dart';
import 'package:blogger_app/storage/share_prefs_app_data.dart';
import 'package:blogger_app/pages/home.dart';
import 'package:flutter/material.dart';

import 'package:splashscreen/splashscreen.dart';

class SplashScreenC extends StatefulWidget {
  SplashScreenC({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenC> {
  Future<Widget> loadSharedPrefs() async {
    SharedPref sharedPref = SharedPref();
    bool check = await sharedPref.check();

    if (check) {
      return Future.value(new HomePage());
    }

    return Future.value(new LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(51, 153, 255, 1),
        body: SplashScreen(
          navigateAfterFuture: loadSharedPrefs(),
          title: new Text(
            'Blogger Block',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          image: new Image.asset('assets/splashscreen.png'),
          photoSize: 80.0,
          backgroundColor: Color.fromRGBO(51, 153, 255, 1),
          loaderColor: Color.fromRGBO(0, 51, 153, 1),
        ));
  }
}