import 'package:flutter/material.dart';

class DarkMode{
  DarkMode._privateConstructor();
  static final DarkMode _instance = DarkMode._privateConstructor();
  final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.dark);
  factory DarkMode(){
    return _instance;
  }
  Widget darkModeButton() {
    Widget darkmodebutton = IconButton(
      onPressed: (){
        _themeNotifier.value = (_themeNotifier.value ==ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
      }, icon: Icon(_themeNotifier.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
    );
    return darkmodebutton;
  }

  get themeNotifier => _themeNotifier;
}