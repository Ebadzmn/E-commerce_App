import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:get/get.dart';

import '../../../common/data/models/product_model.dart';

class PopularProductlistController extends GetxController {

  final int _perPageDataCount = 30;
  int _currentPage = 0;
  int? _totalPage;
  bool _isPageLoading = true;
  bool _isLoading = false;
  bool _isInitialized = false;
  List<ProductModel> _productList = [];
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  List <ProductModel> get productList => _productList;
  bool get isLoading => _isLoading;
  bool get isPageLoading => _isPageLoading;

  @override
  void onInit() {
    super.onInit();
    _autoInitLoad(); // ✅ Auto-trigger on controller init
  }

  void _autoInitLoad() {
    if (!_isInitialized) {
      _isInitialized = true;
      Future.delayed(Duration.zero, () {
        initialLoad();
      });
    }
  }

  Future<bool> initialLoad() async {
    _currentPage = 0;
    _productList = [];
    _isPageLoading = true;
    update();
    return getPopularProductList();
  }


  Future <bool> getPopularProductList() async {

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
      'category' : '67c35af85e8a445235de197b',
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


// Future<bool> initialLoad () {
//   _currentPage = 0;
//   _productList = [];
//   _isPageLoading = true;
//   return getSpecialProductList();
// }
}