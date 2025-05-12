import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/auth_controller.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/signIn_screen.dart';
import 'package:ecomarce_hello/feature/cart/data/models/cart_list_model.dart';
import 'package:ecomarce_hello/feature/cart/ui/controllers/cart_list_controller.dart';
import 'package:ecomarce_hello/feature/cart/ui/widget/cartListwidget.dart';
import 'package:ecomarce_hello/feature/products/ui/widget/increment_decrement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/controller/main_bottom_nav_controller.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final CartListController _cartListController = Get.find<CartListController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartListController.getCartList();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_,__) {
        Get.find<MainButtomNavbarController>().moveToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Get.find<MainButtomNavbarController>().moveToHome();
          }, icon: const Icon(Icons.arrow_back_outlined)),
          title: const Text('Cart List'),
        ),

        body: GetBuilder<CartListController>(
          builder: (controller) {
            if (controller.InProgress) {
              return const CenterProgressIndecator();
            }
            return Column(
              children: [
                Expanded(child: ListView.builder(itemCount: controller.cartList.length, itemBuilder: (context,index) {
                  CartListModel cartList = controller.cartList[index];
                  return cartListWidget(cartList: cartList);
                })),
                // Expanded(
                //   child: GetBuilder<CartListController>(
                //     builder: (controller) {
                //       if (controller.InProgress) {
                //         return const CenterProgressIndecator();
                //       }
                //
                //       if (controller.cartList == null) {
                //         return const Center(child: CircularProgressIndicator());
                //       }
                //
                //       if (controller.cartList!.isEmpty) {
                //         return const Center(child: Text('Cart is empty.'));
                //       }
                //
                //       return ListView.builder(
                //         itemCount: controller.cartList.length,
                //         itemBuilder: (context, index) {
                //           final cartList = controller.cartList[index];
                //           return cartListWidget(cartList: cartList);
                //         },
                //       );
                //     },
                //   ),
                // ),


                Container(
                  child: _buildPriceCard(),
                )
              ],
            );
          }
        ),
      ),
    );
  }
  Widget _buildPriceCard( ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price'),
              Text('BDT ${_cartListController.totalPrice}' , style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,color: AppColors.themeColor
              ),),
            ],
          ),
          SizedBox( width : 140 , child: ElevatedButton(onPressed: () {}, child: const Text('CheckOut')),)
        ],
      ),
    );
  }
}

