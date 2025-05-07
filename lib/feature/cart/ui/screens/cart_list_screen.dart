import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/feature/cart/data/models/cart_list_model.dart';
import 'package:ecomarce_hello/feature/cart/ui/controllers/cart_list_controller.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<CartListController>().getCartList();
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
                  return Card(
                    child: Row(
                      children: [
                        SizedBox( width: 100 , height: 100,
                          child: Image.network('', width: 100 , height: 100 , errorBuilder: (_,__,___) {
                            return const Icon(Icons.error_outline_rounded);
                          },),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                   Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(cartList.productModel.title),
                                        Row(
                                          children: [
                                            Text('Color : ${cartList.color}'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Size : ${cartList.size}'),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('BDT ${cartList.productModel.currentPrice}'),
                                  SizedBox( width: 80,child: FittedBox(child: IncrementDecrement(onChange: (int count){} ,)))

                                ],
                              )
                            ],
                          ),
                        )


                      ],
                    ),
                  );
                }))
              ],
            );
          }
        ),
      ),
    );
  }
}
