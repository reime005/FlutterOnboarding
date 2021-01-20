import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboarding/app.dart';

void main() {
  runApp(App());
  // hide status bar
  SystemChrome.setEnabledSystemUIOverlays([]);
}
