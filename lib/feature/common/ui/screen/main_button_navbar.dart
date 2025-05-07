import 'package:ecomarce_hello/feature/auth/ui/screens/signIn_screen.dart';
import 'package:ecomarce_hello/feature/cart/ui/screens/cart_list_screen.dart';
import 'package:ecomarce_hello/feature/cart/ui/screens/cart_screen.dart';
import 'package:ecomarce_hello/feature/categories/ui/screens/categories_list_screen.dart';
import 'package:ecomarce_hello/feature/common/controller/category_controller.dart';
import 'package:ecomarce_hello/feature/common/controller/main_bottom_nav_controller.dart';
import 'package:ecomarce_hello/feature/common/controller/slider_controller.dart';
import 'package:ecomarce_hello/feature/home/ui/screens/home.dart';
import 'package:ecomarce_hello/feature/wishList/ui/screens/wishList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainButtonNavbar extends StatefulWidget {
  const MainButtonNavbar({super.key});

  static const String name = '/MainButtomNavbar';

  @override
  State<MainButtonNavbar> createState() => _MainButtonNavbarState();
}

class _MainButtonNavbarState extends State<MainButtonNavbar> {


  final List <Widget> _screens = [
    const Home(),
    const CategoriesListScreen(),
    const CartListScreen(),
    const WishListScreen(),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   // Get.find<HomeSliderController>().getSlider();
  //   // Get.find<CategoryController>().getCategoryList();
  //   WidgetsBinding.instance.addPersistentFrameCallback((_) {
  //     Get.find<HomeSliderController>().getSlider();
  //     Get.find<CategoryController>().getCategoryList();
  //   });
  // }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeSliderController>().getSlider();
      Get.find<CategoryController>().getCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder <MainButtomNavbarController>(
        builder: (controller) {
          return _screens[controller.selectedIndex];
        }
      ),
      bottomNavigationBar: GetBuilder <MainButtomNavbarController>(
        builder: (controller) {
          return NavigationBar(
          selectedIndex: controller.selectedIndex,
              onDestinationSelected: (int index) {
            if (controller.shouldNavigate(index)) {
              controller.changeIndex(index);
            } else {
              Get.to(() => SignInScreen());
            }
              }
          ,destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.category), label: 'Category'),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            NavigationDestination(icon: Icon(Icons.favorite_border), label: 'WishList')
          ]);
        }
      ),
    );
  }
}
