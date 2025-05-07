
import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';
import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';
import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';
import 'package:ecomarce_hello/feature/products/ui/screens/products_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/assets_path.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.productModel,
  });

final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductsDetailsScreen.name,arguments: productModel.id);
      },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: 155,
          child: Column(
            children: [
              Container(
                height: 120,
                width: 155,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8) , topRight: Radius.circular(8)),
                  image: productModel.photos.isNotEmpty ? DecorationImage(image: NetworkImage(productModel.photos.first), fit: BoxFit.cover) : null,
                ),

                child: productModel.photos.isEmpty ? Icon(Icons.error_rounded) : null,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                     Text(productModel.title ,maxLines: 1, style: TextStyle(
                        overflow: TextOverflow.fade,
                        fontWeight: FontWeight.w400
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text('${productModel.currentPrice}',style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w600
                        ),),
                        const Wrap(
                          children: [
                            Icon(Icons.star , size: 18, color: Colors.orange,),
                            Text('3.3')
                          ],
                        ),
                        Card(
                          color: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(Icons.favorite_border,size: 16, color: Colors.white,),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}