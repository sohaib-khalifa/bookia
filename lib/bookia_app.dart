import 'dart:io';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:chili_debug_view/chili_debug_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.maybeOf(context) ?? MediaQueryData.fromView(View.of(context));
    final screenWidth = mediaQueryData.size.width;

    return ScreenUtilInit(
      designSize: screenWidth > 600 ? mediaQueryData.size : const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.routes,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppThemes.lightTheme,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: DebugView(
                navigatorKey: navigatorKey,
                showDebugViewButton: true,
                app: SafeArea(
                  top: false,
                  bottom: !kIsWeb && Platform.isAndroid,
                  child: child!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
