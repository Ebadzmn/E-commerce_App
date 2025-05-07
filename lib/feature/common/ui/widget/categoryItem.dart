import 'package:ecomarce_hello/feature/common/data/models/category_model.dart';
import 'package:ecomarce_hello/feature/products/ui/screens/products_list.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key, required this.categoryModel,
  });

  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  () {
        Navigator.pushNamed(context, ProductsList.name,arguments: categoryModel);
      },
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            color: AppColors.themeColor.withOpacity(0.2),
            elevation: 0,
            child:  Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.network(categoryModel.icon, width: 48, height: 48, color: AppColors.themeColor,),
            ),
          ),
          Text(categoryModel.title,style: const TextStyle(
              color: AppColors.themeColor,
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),)
        ],
      ),
    );
  }
}