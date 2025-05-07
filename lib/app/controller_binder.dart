import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/auth_controller.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/signIn_controller.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/sign_up_controller.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/verify_otp_controller.dart';
import 'package:ecomarce_hello/feature/cart/ui/controllers/cart_list_controller.dart';
import 'package:ecomarce_hello/feature/common/controller/category_controller.dart';
import 'package:ecomarce_hello/feature/common/controller/main_bottom_nav_controller.dart';
import 'package:ecomarce_hello/feature/common/controller/slider_controller.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/popular_product_controller.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/special_productList_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainButtomNavbarController());
    Get.put(NetworkCaller());
    Get.put(AuthController());
    Get.put(HomeSliderController());
    Get.put(CategoryController());
    Get.put(SignUpController());
    Get.put(SignInController());
    Get.put(SpecialProductlistController());
    Get.put(PopularProductlistController());
    Get.put(VerifyOtpController());
    Get.put(CartListController());
    // Get.put(()=> VerifyOtpController());
  }
}