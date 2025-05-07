
import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/common/data/models/slide_model.dart';
import 'package:get/get.dart';

class HomeSliderController extends GetxController {
  bool _InProgress = false;
  bool get InProgress => _InProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List <SlideModel> _sliderList = [];
  List<SlideModel> get slider => _sliderList;

  Future<bool> getSlider() async {
    bool isSuccess = false;
    _InProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: AppUrls.sliderUrl);
    if (response.isSuccess) {
      List<SlideModel> list = [];
      for (Map<String , dynamic> data in response.responseData?['data']['results'] ?? []) {
        list.add(SlideModel.fromJson(data));
      }
      _sliderList = list;
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