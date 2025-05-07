import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/auth/data/models/verify_otp_model.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController{
  bool _InProgress = false;
  bool get InProgress => _InProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> VerifyOtp (VerifyOtpModel verifyOtpModel) async {
    bool isSuccess = false;
    _InProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: AppUrls.verifyOtpUrl,body: verifyOtpModel.toJson());

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMassage;
    }
    _InProgress = false;
    update();
    return isSuccess;
  }
}