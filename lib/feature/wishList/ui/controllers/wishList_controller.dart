import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/wishList/data/models/wishList_model.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _InProgress = false;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool get InProgress => _InProgress;
  List<WishListModel> _wishList = [];
  List<WishListModel> get wishList => _wishList;

  Future<bool> getWishList() async {
    bool isSuccess = false;
    _InProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.addToWishtUrl,);

    if(response.isSuccess) {
      List<WishListModel> list = [];
      for (Map<String , dynamic > json in response.responseData! ['data']['results']) {
        list.add(WishListModel.fromJson(json));
        _wishList = list;
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
