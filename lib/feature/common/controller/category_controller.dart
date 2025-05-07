import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/common/data/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {


  final int _perPageDataCount = 30;
  int _currentPage = 0;
  int? _totalPage;
  bool _isPageLoading = true;
  bool _isLoading = false;
  List<CategoryModel> _categoryList = [];
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  int? get totalPage => _totalPage;
  List <CategoryModel> get categoryList => _categoryList;
  bool get isLoading => _isLoading;
  bool get isPageLoading => _isPageLoading;


  Future <bool> getCategoryList() async {

    if (_totalPage != null && _currentPage > _totalPage!) {
      return true;
    }

    bool isSuccess = false;
    _currentPage++;
    if (_isLoading == false) {
      _isLoading = true;
    }
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.categoryListUrl , params: {
      'count' : _perPageDataCount,
      'page' : _currentPage
    });

    if (response.isSuccess) {
      List<CategoryModel> list = [];
      for (Map<String , dynamic> data in response.responseData!['data']['results']) {
        list.add(CategoryModel.fromJson(data));
      }
      _categoryList.addAll(list);
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


  Future<bool> initialLoad () {
    _currentPage = 0;
    _categoryList = [];
    _isPageLoading = true;
    return getCategoryList();
  }
}