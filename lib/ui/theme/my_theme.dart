import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackgroundColor = Color(0xFFDFECDB);
  static const Color colorGrey = Color(0xFFC8C9CB);
  static final lightTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(color: lightPrimary),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: lightPrimary, size: 36),
        unselectedIconTheme: IconThemeData(color: colorGrey, size: 36)),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(18), topLeft: Radius.circular(18)),
      ),
    ),
    textTheme: const TextTheme(
      headline5:  TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
      headline6: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black
      )
    )
  );
}
