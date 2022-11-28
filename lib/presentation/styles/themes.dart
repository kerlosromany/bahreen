import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme = ThemeData(
  fontFamily: 'cairo',
  scaffoldBackgroundColor: AppColor.white,
  colorScheme: ColorScheme.fromSwatch(accentColor: AppColor.lightRed),
  appBarTheme: const AppBarTheme(
    elevation: 4.0,
    color: AppColor.red,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColor.red,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        color: AppColor.white,
        fontSize: 15,
      ),
      primary: AppColor.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
);
