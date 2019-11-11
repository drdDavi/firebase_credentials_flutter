import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({this.isLightTheme});

  ThemeData get getThemeData => isLightTheme ? lightTheme : darkTheme;

  set setThemeData(bool val) {
    if (val) {
      isLightTheme = true;
    } else {
      isLightTheme = false;
    }
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  fontFamily: 'GoogleSans',
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFF1E1F28),
  brightness: Brightness.dark,
  backgroundColor: Color(0xFF2A2C36),
  scaffoldBackgroundColor: Color(0xFF1E1F28),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.white12,
  buttonColor: Color(0xFFEF3651),
  appBarTheme: AppBarTheme(elevation: 0.0),
  textTheme: TextTheme(display1: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w600)),
);

final lightTheme = ThemeData(
  fontFamily: 'GoogleSans',
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: Color(0xFFFFFFFF),
  scaffoldBackgroundColor: Color(0xFFF9F9F9),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.black12,
  buttonColor: Color(0xFFDB3022),
  appBarTheme: AppBarTheme(elevation: 0.0, color: Color(0xFFF9F9F9)),
  textTheme: TextTheme(display1: TextStyle(fontSize: 34, color: Colors.black87, fontWeight: FontWeight.w600)),
);
