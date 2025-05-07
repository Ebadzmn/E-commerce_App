import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/cart/data/models/cart_list_model.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _InProgress = false;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool get InProgress => _InProgress;
   List<CartListModel> _cartList = [];
  List<CartListModel> get cartList => _cartList;
  
  Future<bool> getCartList() async {
    bool isSuccess = false;
    _InProgress = true;
    update();
    
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.addToCartUrl,);

    if(response.isSuccess) {
      List<CartListModel> list = [];
      for (Map<String , dynamic > json in response.responseData! ['data']['results']) {
        list.add(CartListModel.fromJson(json));
        _cartList = list;
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