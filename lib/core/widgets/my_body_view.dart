import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBodyView extends StatelessWidget {
  const MyBodyView({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding ?? EdgeInsets.all(22.w), child: child);
  }
}
