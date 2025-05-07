import 'package:ecomarce_hello/app/app_urls.dart';
import 'package:ecomarce_hello/core/networkCaller/network_caller.dart';
import 'package:ecomarce_hello/feature/auth/data/models/signup_request_model.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
   bool _InProgress = false;
   bool get InProgress => _InProgress;
   String? _errorMessage;
   String? get errorMessage => _errorMessage;

   Future<bool> signUp (SignUpModel signUpModel) async {
      bool isSuccess = false;
      _InProgress = true;
      update();
      final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: AppUrls.signUpUrl,body: signUpModel.toMap());

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