import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:ndk_flutter/l10n/app_localizations.dart' as ndk_flutter_l10n;

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ndk = Ndk(NdkConfig(
    cache: MemCacheManager(),
    eventVerifier: kIsWeb ? WebEventVerifier() : Bip340EventVerifier(),
  ));
  final ndkFlutter = NdkFlutter(ndk: ndk);
  await ndkFlutter.restoreAccountsState();

  Get.put<Ndk>(ndk);
  Get.put<NdkFlutter>(ndkFlutter);

  runApp(const GriffeApp());
}

class GriffeApp extends StatelessWidget {
  const GriffeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Griffe',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: const [
        ndk_flutter_l10n.AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: ndk_flutter_l10n.AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
