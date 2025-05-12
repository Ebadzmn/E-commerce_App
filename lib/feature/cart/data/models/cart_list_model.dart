import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';

class CartListModel {
  final ProductModel productModel;
   int quantity;
  final String id;
  final String? color;
  final String? size;

  CartListModel({required this.productModel,required this.id,required this.quantity, required this.color, required this.size});

  factory CartListModel.fromJson(Map<String , dynamic> jsonData) {
    return CartListModel (
      productModel: ProductModel.fromJson(jsonData['product']),
      id: jsonData['_id'],
      quantity: jsonData['quantity'],
      color: jsonData['color'],
      size: jsonData['size'],
    );
  }
}