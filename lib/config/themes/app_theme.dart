import 'package:flutter/material.dart';
import '../../core/utils/app_strings.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    // primarySwatch: ,
    primaryColor: Colors.yellow,
    hintColor: AppColors.hint,

    // brightness: Brightness.light,
    // scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      elevation: 0,
    ),
    // fontFamily: AppStrings.fontFamily,
    // textTheme: TextTheme(
    //   bodyMedium: TextStyle(
    //     height: 1.3,
    //     fontSize: 22,
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
  );
}
