import 'package:bookia/bookia_app.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();

  runApp(
    DevicePreview(
      // enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => const BookiaApp(),
    ),
  );
}
