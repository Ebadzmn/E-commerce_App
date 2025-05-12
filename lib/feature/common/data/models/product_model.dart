import 'package:ecomarce_hello/feature/common/data/models/brand_model.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  // final BrandModel? brand;
  final int regularPrice;
  final int currentPrice;
  // final double rating;
  final List<String> photos;
  final List<String> sizes;
  final List<String> colors;
  final int quantity;

  ProductModel({required this.id, required this.title,required this.description, required this.regularPrice, required this.currentPrice,required this.quantity ,required this.photos, required this.sizes, required this.colors, });


  factory ProductModel.fromJson (Map<String , dynamic> jsonData) {
    List<dynamic> photoList = jsonData['photos'] ?? [];
    List<dynamic> sizeList = jsonData['sizes'] ?? [];
    List<dynamic> colorList = jsonData['colors'] ?? [];

    return ProductModel (
      id: jsonData['_id'],
      title: jsonData['title'],
      quantity: jsonData['quantity'],
      description: jsonData['description'] ?? '',
      // brand: BrandModel.fromJson(jsonData['brand']),
      regularPrice: jsonData['regular_price'] ?? 0,
      currentPrice: jsonData['current_price'] ?? 0,
      sizes: List<String>.from(sizeList),
      colors: List<String>.from(colorList),
      photos: List<String>.from(photoList),
      // availableQuantity: jsonData['availableQuantity'],
      // rating: jsonData['rating'] ?? 0.0,
    );
  }

}






