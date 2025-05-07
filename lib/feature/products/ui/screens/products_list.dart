import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/feature/common/ui/widget/product_card.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/data/models/category_model.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key, required this.category});

  final CategoryModel category;

  static const String name = '/products_list';

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final ProductListController _productListController = ProductListController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productListController.getProductList(widget.category.id);
    _scrollController.addListener(_loadData);
  }

  void _loadData () {
    if (_scrollController.position.extentAfter < 300) {
      _productListController.getProductList(widget.category.id);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GetBuilder(
          init: _productListController,
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
