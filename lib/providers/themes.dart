import 'package:flutter/material.dart';
import '../services/storage_manager.dart';
import '../utils/constants.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      fontFamily: 'poppins',
      backgroundColor: const Color(0xFF212121),
      scaffoldBackgroundColor: kDarkBlueColor,
      // accentColor: Colors.white,
      // accentIconTheme: IconThemeData(color: Colors.black),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kDarkBlueColor, unselectedItemColor: Colors.white),
      dividerColor: Colors.black12,
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      inputDecorationTheme: getInputDecorationTheme(const Color(0xffffffff)));

  final lightTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, unselectedItemColor: Colors.black),
      fontFamily: 'poppins',
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      // accentColor: Colors.black,
      // accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.white54,
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: getInputDecorationTheme(const Color(0xffd1d1d1)));

  static InputDecorationTheme getInputDecorationTheme(Color borderColor) {
    return InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffd1d1d1))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor)
            ),
        disabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: borderColor)
            ),
        contentPadding:
            const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 10.0));
            
  }

  bool _isDark = false;
  ThemeData _themeData = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),

    // accentColor: Colors.black,
    // accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    appBarTheme:
        const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
  );
  ThemeData getTheme() => _themeData;
  bool get isDark => _isDark;
  //  set setIsDark(val) {
  //   _isDark = val;
  // }

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
        _isDark = false;
      } else {
        _themeData = darkTheme;
        _isDark = true;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    _isDark = true;
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    _isDark = false;
    notifyListeners();
  }
}
