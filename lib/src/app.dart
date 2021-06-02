import 'package:blogger_app/pages/login.dart';
import 'package:blogger_app/pages/home.dart';
import 'package:blogger_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blogger App',
        theme: ThemeData(
          primaryColor: Colors.deepPurple[900],
          accentColor: Colors.deepPurple[900],
          fontFamily: 'Ubuntu',
        ),
        home: SplashScreenC(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new HomePage(),
          '/login': (BuildContext context) => new LoginPage(),
        });
  }
}
