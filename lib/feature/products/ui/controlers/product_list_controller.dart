import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:get/get.dart';

import '../../../common/data/models/product_model.dart';

class ProductListController extends GetxController {

  final int _perPageDataCount = 30;
  int _currentPage = 0;
  int? _totalPage;
  bool _isPageLoading = true;
  bool _isLoading = false;
  List<ProductModel> _productList = [];
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  List <ProductModel> get productList => _productList;
  bool get isLoading => _isLoading;
  bool get isPageLoading => _isPageLoading;


  Future <bool> getProductList(String categoryId) async {

    if (_totalPage != null && _currentPage > _totalPage!) {
      return true;
    }

    bool isSuccess = false;
    _currentPage++;
    if (_isLoading == false) {
      _isLoading = true;
    }
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.productListUrl , params: {
      'count' : _perPageDataCount,
      'page' : _currentPage,
      'category' : categoryId,
    });

    if (response.isSuccess) {
      List<ProductModel> list = [];
      for (Map<String , dynamic> data in response.responseData!['data']['results']) {
        list.add(ProductModel.fromJson(data));
      }
      _productList.addAll(list);
      _totalPage = response.responseData!['data']['last_page'];
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMassage;
    }
    if (!isPageLoading) {
      _isLoading = false;
    } else {
      _isPageLoading = false;
    }
    update();
    return isSuccess;
  }


  Future<bool> initialLoad (String categoryId) {
    _currentPage = 0;
    _productList = [];
    _isPageLoading = true;
    return getProductList(categoryId);
  }
}