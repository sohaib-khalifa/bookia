import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppColors.primaryColor,
    this.borderColor,
    this.minWidth = double.infinity,
    this.minHeight = 56,
    this.textColor = AppColors.backgroundColor,
  });
  final String text;
  final Function() onPressed;
  final Color bgColor;
  final Color? borderColor;
  final double minWidth;
  final double minHeight;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.zero,
        maximumSize: Size(minWidth == double.infinity ? double.infinity : minWidth.w, minHeight.h),
        minimumSize: Size(minWidth == double.infinity ? double.infinity : minWidth.w, minHeight.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyles.body.copyWith(color: textColor)),
    );
  }
}
