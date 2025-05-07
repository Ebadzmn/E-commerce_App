import 'package:ecomarce_hello/core/extension/localization_extention.dart';
import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/feature/common/controller/category_controller.dart';
import 'package:ecomarce_hello/feature/common/controller/main_bottom_nav_controller.dart';
import 'package:ecomarce_hello/feature/common/ui/widget/categoryItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key});

  static const String name = '/category-list';

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {

  final CategoryController _categoryController = Get.find<CategoryController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryController.getCategoryList();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (_scrollController.position.extentAfter > 300) {
      _categoryController.getCategoryList();
    }
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
          }, icon: Icon(Icons.arrow_back_outlined)),
          title: Text(context.localization.categories),
        ),
        body: GetBuilder<CategoryController>(
          builder: (controller) {
            if (controller.isPageLoading) {
              return const CenterProgressIndecator();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        controller.initialLoad();
                      },
                      child: GridView.builder(
                        controller: _scrollController,
                          itemCount: controller.categoryList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8 ), itemBuilder: (context , index){
                        return FittedBox(child: CategoryItem(
                          categoryModel: controller.categoryList[index],

                        ));
                      }),
                    ),
                  ),
                   Visibility(
                      visible: controller.isLoading ,
                      child: LinearProgressIndicator())
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
