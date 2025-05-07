import 'package:ecomarce_hello/app/app_config.dart';
import 'package:ecomarce_hello/core/extension/localization_extention.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/signIn_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/sign_up_screen.dart';
import 'package:ecomarce_hello/feature/common/ui/screen/main_button_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widget/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future <void> _moveToNextScreen() async {
    await Future.delayed( const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, MainButtonNavbar.name);
  }

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const AppLogo(),
              const Spacer(),
              const CircularProgressIndicator(),
              const SizedBox(height: 12,),
              Text('${context.localization.version} ${AppConfig.currentAppVersion}')


            ],
          ),
        ),
      ),
    );
  }
}

