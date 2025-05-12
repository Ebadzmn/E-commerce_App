import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/cart/data/models/cart_list_model.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _InProgress = false;
  bool _removeCartInProgress = false;
  String? _removeCarterrorMessage;

  bool get removeCartInprogress => _removeCartInProgress;
  String? get removeCarterrorMessage => _removeCarterrorMessage;
  String? _errorMessage;
  String? _UpdateerrorMessage;
  String? get errorMessage => _errorMessage;
  String? get UpdateerrorMessage => _UpdateerrorMessage;
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


  // void updateProduct (String cartId , int quantity) {
  //   for (CartListModel cartList in _cartList) {
  //     if (cartList.id == cartId) {
  //       cartList.quantity = quantity;
  //       break;
  //     }
  //   }
  //   update();
  // }

  Future <bool> UpdateCartProduct (String cartId, int quantity) async {
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>().patchRequest(url: AppUrls.updateCartUrl(cartId),
    body: {
      'quantity' : quantity
    }
    );

    if (response.isSuccess) {
      for (CartListModel cartList in _cartList) {
        if (cartList.id == cartId) {
          cartList.quantity = quantity;
          break;
        }
      }
    } else {
      _UpdateerrorMessage = response.errorMassage;
    }
    update();
    return isSuccess;
  }


  Future <bool> removeCartProduct (String cartId) async {
    bool isSuccess = false;
    _removeCartInProgress = true;
    update();
    
    final NetworkResponse response = await Get.find <NetworkCaller>().deleteRequest(url: AppUrls.deleteCartUrl(cartId));
    
    if (response.isSuccess) {
      _cartList.removeWhere((e) => e.id == cartId);
      isSuccess = true;
    } else {
      _removeCarterrorMessage = response.errorMassage;
    }
    _removeCartInProgress = false;
    update();
    return isSuccess;

  }




  int get totalPrice {
    int total = 0;
    for (CartListModel cartList in _cartList) {
      total += (cartList.productModel.currentPrice * cartList.quantity);
    }
    return total;
  }
}