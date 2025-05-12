import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';

class WishListModel {
  final ProductModel productModel;


  WishListModel({required this.productModel});

  factory WishListModel.fromJson(Map<String , dynamic> jsonData) {
    return WishListModel (
      productModel: ProductModel.fromJson(jsonData['product']),
    );
  }
  ProductModel toProductModel() => productModel;
}