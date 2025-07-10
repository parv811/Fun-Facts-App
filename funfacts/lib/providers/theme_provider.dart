import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isChecked = false;

  void updateMode({required bool switcher}) async {
    isChecked = switcher;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isChecked', switcher);

    notifyListeners();
  }

  void loadMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    isChecked = prefs.getBool('isChecked') ?? true;

    notifyListeners();
  }
}
