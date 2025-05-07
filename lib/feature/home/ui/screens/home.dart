import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:ecomarce_hello/app/assets_path.dart';
import 'package:ecomarce_hello/core/extension/localization_extention.dart';
import 'package:ecomarce_hello/feature/common/controller/category_controller.dart';
import 'package:ecomarce_hello/feature/common/controller/main_bottom_nav_controller.dart';
import 'package:ecomarce_hello/feature/common/data/models/category_model.dart';
import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/popular_product_controller.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/special_productList_controller.dart';
import 'package:ecomarce_hello/feature/products/ui/screens/popular_productList_screen.dart';
import 'package:ecomarce_hello/feature/products/ui/screens/special_ProductList_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../products/ui/screens/products_list.dart';
import '../widget/appbar_action_button.dart';
import '../../../common/ui/widget/categoryItem.dart';
import '../widget/homeSlider.dart';
import '../../../common/ui/widget/product_card.dart';
import '../widget/section_header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildSearchTextFormField(),
              const SizedBox(height: 15,),
              const homeSlider(),
              const SizedBox(height: 16,),
              SelectionHeader(
                title: context.localization.categories,
                onTapSeeAll: () {
                  Get.find<MainButtomNavbarController>().moveToCategory();
                },
              ),
             const SizedBox(height: 15,),
             buildCategorySection(),
              const SizedBox(height: 15,),
              SelectionHeader(
                title: context.localization.popular,
                onTapSeeAll: () {
                  Navigator.pushNamed(context, PopularProductsList.name);
                },
              ),
              const SizedBox(height: 15,),
              buildPopularSection(),
              const SizedBox(height: 15,),
              SelectionHeader(title: context.localization.special, onTapSeeAll: () {
                Navigator.pushNamed(context, SpecialProductsList.name);
              }),
              const SizedBox(height: 15,),
              buildSpecialSection()
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildProductCard() {
    return const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // ProductCard(),
                    // ProductCard(),
                    // ProductCard()
                  ],
                ),
            );
  }

 Widget buildCategorySection() {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.isPageLoading) {
          return SizedBox( height: 38 , child: CircularProgressIndicator());
        }

        List<CategoryModel> list = controller.categoryList.length > 10 ? controller.categoryList.sublist(0,10) : controller.categoryList;

        return  SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 children: controller.categoryList.map((e) {
                   return CategoryItem(categoryModel: e);
                 }).toList(),
               ),
             );
      }
    );
  }

  Widget buildSpecialSection() {
    return GetBuilder<SpecialProductlistController>(
        builder: (controller) {
          if (controller.isPageLoading) {
            return SizedBox( height: 38 , child: CircularProgressIndicator());
          }

          List<ProductModel> list = controller.productList.length > 10 ? controller.productList.sublist(0,10) : controller.productList;

          return  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.productList.map((e) {
                return ProductCard(productModel: e);
              }).toList(),
            ),
          );
        }
    );
  }

  Widget buildPopularSection() {
    return GetBuilder<PopularProductlistController>(
        builder: (controller) {
          if (controller.isPageLoading) {
            return SizedBox( height: 38 , child: CircularProgressIndicator());
          }

          List<ProductModel> list = controller.productList.length > 10 ? controller.productList.sublist(0,10) : controller.productList;

          return  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.productList.map((e) {
                return ProductCard(productModel: e);
              }).toList(),
            ),
          );
        }
    );
  }

  TextFormField buildSearchTextFormField() {
    return TextFormField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none
              ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none
                )
            )

          );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.logoNavSvg),
      actions: [
        AppBarAction(icon: Icons.person_outlined, onTap: () {  },),
        AppBarAction(icon: Icons.call_outlined, onTap: () {  },),
        AppBarAction(icon: Icons.notification_important_outlined, onTap: () {  },)
      ],
    );
  }
}






