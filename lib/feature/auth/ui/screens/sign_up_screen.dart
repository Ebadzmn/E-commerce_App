import 'package:ecomarce_hello/app/app.dart';
import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:ecomarce_hello/core/extension/localization_extention.dart';
import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/core/widget/snackBar_msg.dart';
import 'package:ecomarce_hello/feature/auth/data/models/signup_request_model.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/sign_up_controller.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/signIn_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/verify_otp_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/widget/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignUpController signUpController = Get.find<SignUpController>();


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
  }  Form buildForm(TextTheme textTheme) {
    return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 70,),
              const AppLogo(),
              const SizedBox(height: 10,),
              Text(context.localization.registerYourAccount, style: textTheme.titleLarge, ),
              const SizedBox(height: 5,),
              Text(context.localization.getStartedWithYourDetails , style: const TextStyle(
                  color: Colors.grey
              ),),
              const SizedBox(height: 30,),
              TextFormField(
                controller: _emailTEController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: context.localization.email
                ),
                validator: (String ? value) {
                  String email = value ?? '';
                  if (!EmailValidator.validate(email)) {
                    return 'Enter Your Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _firstNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: context.localization.firstName
                ),
                validator: (String ? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter Your First Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _lastNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: context.localization.lastName
                ),
                validator: (String ? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter Your Last Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _phoneController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: context.localization.phone
                ),
                validator: (String ? value) {
                  String PhoneNumber = value ?? '';
                  RegExp regExp = RegExp(r'^(\+88|88)?01[3456789]\d{8}$');
                  if (regExp.hasMatch(PhoneNumber) == false) {
                    return 'Enter Your Phone Number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _addressController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: context.localization.address
                ),
                validator: (String ? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter Your Address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _passwordTEController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: context.localization.password
                ),
                validator: (String ? value) {
                  if (value?.isEmpty ?? true ) {
                    return 'Enter Your Password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              GetBuilder<SignUpController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.InProgress == false,
                    replacement: const CenterProgressIndecator(),
                    child: ElevatedButton(
                        onPressed: _onTabSignUpButton
                        , child:  Text (context.localization.signIn)),
                  );
                }
              ),
              SizedBox(height: 20,),
              RichText(
                text: TextSpan(
                  text: context.localization.haveAccount,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400
                  ),
                  children: [
                    TextSpan(
                      text: context.localization.signIn,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.themeColor
                      ),
                      recognizer: TapGestureRecognizer()..onTap = _onTabSignInButton
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
  }
  Future<void> _onTabSignUpButton () async {
    if (_formKey.currentState!.validate()) {
      SignUpModel signUpModel = SignUpModel(
          email: _emailTEController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordTEController.text,
          address: _addressController.text.trim()
      );
      final bool isSuccess = await signUpController.signUp(signUpModel);
      if (isSuccess) {
        // Navigator.pushNamed(context, OtpVerifyScreen.name);
        Navigator.pushNamed(
          context,
          OtpVerifyScreen.name,
          arguments: _emailTEController.text.trim(),
        );

      } else {
        showSnackBarMsg(context, signUpController.errorMessage ?? "Something went wrong", true);
      }
    }
  }

  void _onTabSignInButton () {
    Navigator.pop(context);
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();

  }
}
