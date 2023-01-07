import 'package:flutter/material.dart';
import 'package:write_it/utils/colors.dart';

var darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(color: kYellow),
  scaffoldBackgroundColor: kBlack,
  
);

var authTextFieldInputBorderStyle = OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(width: 2, color: kYellow),
                      );