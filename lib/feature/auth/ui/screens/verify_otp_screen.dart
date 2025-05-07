import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:ecomarce_hello/core/extension/localization_extention.dart';
import 'package:ecomarce_hello/core/widget/snackBar_msg.dart';
import 'package:ecomarce_hello/feature/auth/data/models/verify_otp_model.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/verify_otp_controller.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/signIn_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/sign_up_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/widget/app_logo.dart';
import 'package:ecomarce_hello/feature/auth/ui/widget/resend_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key, required this.email});
  final String email;
  static const String name = '/otpVerify';

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VerifyOtpController _verifyOtpController = Get.find<VerifyOtpController>();


  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildForm(textTheme),
        ),
      ),
    );
  }

  Form buildForm( TextTheme textTheme) {
    return Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 70,),
              const AppLogo(),
              const SizedBox(height: 10,),
              Text(context.localization.otpverify, style: textTheme.titleLarge, ),
              const SizedBox(height: 5,),
              Text(context.localization.otpSentOnYourEmailAddress , style: const TextStyle(
                  color: Colors.grey
              ),),
              const SizedBox(height: 30,),
              PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                  inactiveColor: AppColors.themeColor,
                  inactiveFillColor: AppColors.themeColor
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: _otpTEController, appContext: context,
                validator: (String? value) {
                  if ((value?.length ?? 0) < 4) {
                    return 'Enter Your Otp';
                  } else {
                    return null;
                  }
                },
              ),

              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: _onTabOtpVerifyButton, child:  Text (context.localization.buttonVerify)) ,
              const SizedBox(height: 20,),
              ResendOtp(),

              SizedBox(height: 40,),


              RichText(
                text: TextSpan(
                  text: context.localization.dontAccount,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400
                  ),
                  children: [
                    TextSpan(
                        text: context.localization.signUp,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _onTabSignUpButton
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
  void _onTabOtpVerifyButton () {
    if (_formKey.currentState!.validate()) {
      _verifyOtp();
    }
  }

  void _onTabSignUpButton () {
    navigator?.pop();
  }

  Future<void> _verifyOtp() async {
    VerifyOtpModel verifyOtpModel = VerifyOtpModel(email: widget.email, otp: _otpTEController.text);
    final bool isSuccess = await _verifyOtpController.VerifyOtp(verifyOtpModel);
    if (isSuccess) {
      showSnackBarMsg(context, 'Otp has been Verify Successs');
      Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate) => false);

    } else {
      showSnackBarMsg(context, _verifyOtpController.errorMessage! ,true);
      print(widget.email);

    }
  }
  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}

