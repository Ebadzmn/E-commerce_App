import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/common/data/models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _InProgress = false;
  late ProductModel _productModel;

  String? _errorMessage;
  bool get InProgress => _InProgress;
  ProductModel get product => _productModel;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails (String productId) async {
    bool isSuccess = false;
    _InProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.productDetailsUrl(productId));

    if (response.isSuccess) {
      _productModel = ProductModel.fromJson(response.responseData!['data']);
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