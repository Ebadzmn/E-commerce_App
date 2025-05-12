import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/feature/common/ui/widget/product_card.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/product_list_controller.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/special_productList_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controlers/popular_product_controller.dart';

class PopularProductsList extends StatefulWidget {
  const PopularProductsList({super.key});



  static const String name = '/popular_products_list';

  @override
  State<PopularProductsList> createState() => _PopularProductsListState();
}

class _PopularProductsListState extends State<PopularProductsList> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_loadData);
  }

  void _loadData () {
    if (_scrollController.position.extentAfter < 300) {
      Get.find<PopularProductlistController>().getPopularProductList();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GetBuilder<PopularProductlistController>(
            builder: (controller) {
              if (controller.isPageLoading) {
                return CenterProgressIndecator();
              }
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        itemCount: controller.productList.length,
                        controller: _scrollController,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3 ,mainAxisSpacing: 15), itemBuilder: (context,index) {
                      return  FittedBox(child: ProductCard(productModel: controller.productList[index]));
                    }),
                  ),
                  Visibility(visible: controller.isLoading, child: LinearProgressIndicator(),)
                ],
              );

            }
        ),
      ),
    );
  }
}
