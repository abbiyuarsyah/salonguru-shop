import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salonguru_shop/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initiate EasyLocalization
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en', 'US'),
      child: const App(),
    ),
  );
}
