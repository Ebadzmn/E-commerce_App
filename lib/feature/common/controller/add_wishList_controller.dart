import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:get/get.dart';

class AddToWishController extends GetxController {
  bool _InProgress = false;

  String? _errorMessage;

  bool get InProgress => _InProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> addToWish (String productId) async {
    bool isSuccess = false;
    _InProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: AppUrls.addToWishtUrl, body: {
      'product' : productId,

    });
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage;
    }
    _InProgress = false;
    update();
    return isSuccess;
  }
}