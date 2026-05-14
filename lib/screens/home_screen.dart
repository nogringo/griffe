import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';

import 'login_screen.dart';
import 'sign_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ndk = Get.find<Ndk>();

    return StreamBuilder<Account?>(
      stream: ndk.accounts.authStateChanges,
      initialData: ndk.accounts.getLoggedAccount(),
      builder: (context, snapshot) {
        final account = snapshot.data;
        if (account == null) {
          return const LoginScreen();
        }
        return SignScreen(account: account);
      },
    );
  }
}
