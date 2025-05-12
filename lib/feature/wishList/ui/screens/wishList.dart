import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/feature/common/ui/widget/product_card.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/product_list_controller.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/special_productList_controller.dart';
import 'package:ecomarce_hello/feature/wishList/ui/controllers/wishList_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WishProductsList extends StatefulWidget {
  const WishProductsList({super.key});

  @override
  State<WishProductsList> createState() => _WishProductsListState();
}

class _WishProductsListState extends State<WishProductsList> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<WishListController>().getWishList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wish Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GetBuilder<WishListController>(
            builder: (controller) {
              if (controller.InProgress) {
                return CenterProgressIndecator();
              }
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        itemCount: controller.wishList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3 ,mainAxisSpacing: 15), itemBuilder: (context,index) {
                      return  FittedBox(child: ProductCard(productModel: controller.wishList[index].toProductModel()));
                    }),
                  ),
                  Visibility(visible: controller.InProgress, child: LinearProgressIndicator(),)
                ],
              );

            }
        ),
      ),
    );
  }
}
