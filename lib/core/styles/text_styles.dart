import 'package:bookia/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  static double get scale => ScreenUtil().screenWidth > 600 ? 1.3 : 1.0;

  static TextStyle get headline => TextStyle(fontSize: 30.sp * scale);
  static TextStyle get title => TextStyle(fontSize: 24.sp * scale);
  static TextStyle get subtitle1 => TextStyle(fontSize: 20.sp * scale);
  static TextStyle get subtitle2 => TextStyle(fontSize: 18.sp * scale);
  static TextStyle get body => TextStyle(fontSize: 16.sp * scale);
  static TextStyle get caption1 => TextStyle(fontSize: 14.sp * scale);
  static TextStyle get caption2 => TextStyle(
    fontSize: 12.sp * scale,
    color: AppColors.greyColor,
  );
}
