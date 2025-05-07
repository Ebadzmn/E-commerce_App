import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/auth/data/models/signIn_request_model.dart';
import 'package:ecomarce_hello/feature/auth/data/models/user_model.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
  bool _InProgress = false;
  bool get InProgress => _InProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn (SignInRequestModel signInRequestModel) async {
    bool isSuccess = false;
    _InProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: AppUrls.signIn,body: signInRequestModel.toJson());

    if (response.isSuccess) {

      UserModel userModel = UserModel.fromJson(response.responseData!['data']['user']);
      String accessToken = (response.responseData!['data']['token']);
      Get.find<AuthController>().saveUserData(accessToken, userModel);
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