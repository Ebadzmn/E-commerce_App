import 'package:ecomarce_hello/feature/auth/ui/screens/Splash_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/signIn_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/sign_up_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/verify_otp_screen.dart';
import 'package:ecomarce_hello/feature/cart/ui/screens/cart_screen.dart';
import 'package:ecomarce_hello/feature/categories/ui/screens/categories_list_screen.dart';
import 'package:ecomarce_hello/feature/common/data/models/category_model.dart';
import 'package:ecomarce_hello/feature/common/ui/screen/main_button_navbar.dart';
import 'package:ecomarce_hello/feature/products/ui/screens/popular_productList_screen.dart';
import 'package:ecomarce_hello/feature/products/ui/screens/products_details_screen.dart';
import 'package:ecomarce_hello/feature/products/ui/screens/products_list.dart';
import 'package:ecomarce_hello/feature/products/ui/screens/special_ProductList_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late Widget route;
    if (settings.name == SplashScreen.name) {
      route = const SplashScreen();
    }
    else if (settings.name == SignInScreen.name) {
      route = const SignInScreen();
    }
    else if (settings.name == SignUpScreen.name) {
      route = const SignUpScreen();
    }
    else if (settings.name == OtpVerifyScreen.name) {
      final String email = settings.arguments as String;
      route =  OtpVerifyScreen(email: email);
    }


    else if (settings.name == MainButtonNavbar.name) {
      route = const MainButtonNavbar();
    }
    else if (settings.name == CategoriesListScreen.name) {
      route = const CategoriesListScreen();
    }
    else if (settings.name == ProductsList.name) {
      final CategoryModel category = settings.arguments as CategoryModel;
      route =  ProductsList(category: category);
    }

    else if (settings.name == ProductsDetailsScreen.name) {
      String productId = settings.arguments as String;
      route =  ProductsDetailsScreen(productId: productId);
    }

    else if (settings.name == CartScreen.name) {
      route = const CartScreen();
    }
    else if (settings.name == SpecialProductsList.name) {
      route = const SpecialProductsList();
    }
    else if (settings.name == PopularProductsList.name) {
      route = const PopularProductsList();
    }
    return MaterialPageRoute(builder: (context) {
      return route;
    });
  }
}