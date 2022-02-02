import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    fontFamily: 'Rubik',
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: kAppBarIconsColor),
    titleTextStyle: kAppBarTitleTextStyle,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
