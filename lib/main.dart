import 'package:blogger_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


void main() {
  EquatableConfig.stringify = kDebugMode;
  runApp(MyApp());
}