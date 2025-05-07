import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';

class CartListModel {
  final ProductModel productModel;
  final int quantity;
  final String? color;
  final String? size;

  CartListModel({required this.productModel, required this.quantity, required this.color, required this.size});

  factory CartListModel.fromJson(Map<String , dynamic> jsonData) {
    return CartListModel (
      productModel: ProductModel.fromJson(jsonData['product']),
      quantity: jsonData['quantity'],
      color: jsonData['color'],
      size: jsonData['size'],
    );
  }
}