import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:get/get.dart';

class AddReviewController extends GetxController {
  bool _InProgress = false;
  String? _errorMessage;
  bool get InProgress => _InProgress;
  String? get errorMeaagae => _errorMessage;

  Future <bool> AddReview ( String comment , int rating, String productId)  async {
    bool isSuccess = false;
    _InProgress = true;
    update();
    Map<String , dynamic> requestBody = {
      'product': productId,
      'comment': comment,
      'rating': rating,
    };

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: AppUrls.addProductReviewUrl , body: requestBody);
    if(response.isSuccess) {
      isSuccess= true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage;
    }
    _InProgress = false;
    update();
    return isSuccess;
  }
}