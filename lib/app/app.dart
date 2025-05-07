import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:ecomarce_hello/app/app_route.dart';
import 'package:ecomarce_hello/app/controller_binder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class HelloShop extends StatefulWidget {
  const HelloShop({super.key});

  @override
  State<HelloShop> createState() => _HelloShopState();
}

class _HelloShopState extends State<HelloShop> {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold)
      ),
        inputDecorationTheme:  const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 16 ,vertical: 0),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.themeColor
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.themeColor
              )
          ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.themeColor
                )
            ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red
              )
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
         style:  ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
              foregroundColor: Colors.white,
              backgroundColor: AppColors.themeColor
          ),
        )
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en'), // English
        Locale('bn'), // Spanish
      ],
      initialBinding: ControllerBinder(),
    );
  }
}
