import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/reviews/data/models/reviews_model.dart';
import 'package:get/get.dart';

class ReviewsListController extends GetxController {
  bool _InProgress = false;
  String? _errorMessage;

  bool get InProgress => _InProgress;
  String? get errorMessage => _errorMessage;

  List <ReviewsModel> _reviewsList = [];
  List <ReviewsModel> get reviewsList =>  _reviewsList;

  // Future<bool> GetReviewsList(String productId) async {
  //   bool isSuccess = false;
  //   _InProgress = true;
  //   update();
  //
  //   final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.productReviewUrl ,params: {
  //     'product' : productId
  //   });
  //
  //   if (response.isSuccess) {
  //     List<ReviewsModel> list = [];
  //     for (Map <String , dynamic> json in response.responseData! ['data']['results']) {
  //       list.add(ReviewsModel.fromJson(json));
  //       _reviewsList = list;
  //       isSuccess = true;
  //     }
  //   } else {
  //     _errorMessage = response.errorMassage;
  //   }
  //   _InProgress = false;
  //   update();
  //   return isSuccess;
  // }

  Future<bool> GetReviewsList(String productId) async {
    bool isSuccess = false;
    _InProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: AppUrls.productReviewUrl,
      params: {'product': productId},
    );

    if (response.isSuccess && response.responseData != null) {
      final results = response.responseData!['data']['results'];
      if (results is List) {
        _reviewsList = results.map<ReviewsModel>((json) => ReviewsModel.fromJson(json)).toList();
        isSuccess = true;
      }
    } else {
      _errorMessage = response.errorMassage;
    }

    _InProgress = false;
    update();
    return isSuccess;
  }

}