import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  late ThemeMode _tempThemeMode;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;
  void toggleTheme(bool isDarkMode) {
    _tempThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    print('$_tempThemeMode is selected now');
    notifyListeners();
  }
  void applyTheme() {
    _themeMode = _tempThemeMode;
    print('Theme is $_themeMode now');
    notifyListeners();
    }
}
final ThemeData lightTheme= ThemeData(
  primaryColor:const Color.fromRGBO(207, 226, 238, 1),
  primaryColorLight: Colors.white,
  focusColor: const Color.fromRGBO(29, 93, 84, 1),
  dividerColor: const Color.fromARGB(255, 70, 70, 70),
  disabledColor: Colors.red,
  splashColor: Colors.black
);
final ThemeData darkTheme= ThemeData(
  primaryColor: Colors.black,
  primaryColorLight: CupertinoColors.darkBackgroundGray,
  focusColor: Colors.green,
  dividerColor: const Color.fromRGBO(136, 148, 157, 1),
  disabledColor: Colors.blueAccent,
  splashColor: Colors.white
);