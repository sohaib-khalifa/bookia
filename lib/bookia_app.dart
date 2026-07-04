import 'dart:io';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:chili_debug_view/chili_debug_view.dart';
import 'package:flutter/material.dart';

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.routes,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      builder: (context, child) {
        return DebugView(
               navigatorKey: navigatorKey,
          showDebugViewButton: true,
          app: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: SafeArea(
              top: false,
              bottom: Platform.isAndroid,
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
