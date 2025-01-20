import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salonguru_shop/app.dart';
import 'package:salonguru_shop/core/service_locator/service_locator.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initiate EasyLocalization
  await EasyLocalization.ensureInitialized();

  /// Initiate Service Locator (Get It)
  await sl.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en', 'US'),
      child: const App(),
    ),
  );
}
