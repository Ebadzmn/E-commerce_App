import 'package:ecomarce_hello/feature/auth/data/models/user_model.dart';
import 'package:ecomarce_hello/feature/auth/data/models/user_model.dart';
import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';
import 'package:intl/intl.dart';

import '../../../auth/data/models/user_model.dart';
import 'package:ecomarce_hello/feature/auth/data/models/user_model.dart';

class ReviewsModel {
  final ProductModel productModel;
  final UserModel userModel;
  final String comment;
  final int rating;

  ReviewsModel({
    required this.userModel,
    required this.comment,
    required this.rating,
    required this.productModel
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> jsonData) {
    return ReviewsModel(
      userModel: UserModel.fromJson(jsonData['user']),
      productModel: ProductModel.fromJson(jsonData['product']),
      comment: jsonData['comment'] ?? '',
      rating: jsonData['rating'] ?? 0,
    );
  }
}
