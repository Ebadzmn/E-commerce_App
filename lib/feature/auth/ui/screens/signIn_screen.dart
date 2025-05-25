import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:ecomarce_hello/core/extension/localization_extention.dart';
import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/core/widget/snackBar_msg.dart';
import 'package:ecomarce_hello/feature/auth/data/models/signIn_request_model.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/signIn_controller.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/sign_up_screen.dart';
import 'package:ecomarce_hello/feature/auth/ui/widget/app_logo.dart';
import 'package:ecomarce_hello/feature/common/ui/screen/main_button_navbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController _signInController = Get.find<SignInController>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildForm( textTheme),
        ),
      ),
    );
  }

  Form buildForm(TextTheme textTheme) {
    return Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 70,),
             const AppLogo(),
               const SizedBox(height: 10,),
               Text(context.localization.welcome, style: textTheme.titleLarge, ),
              const SizedBox(height: 5,),
                Text(context.localization.enterYourEmailandPassword , style: const TextStyle(
                 color: Colors.grey
               ),),
              const SizedBox(height: 30,),
              TextFormField(
                validator: (String ? value) {
                  String email = value ?? '';
                  if (!EmailValidator.validate(email)) {
                    return 'Enter Your Email';
                  }
                  return null;
                },
                controller: _emailTEController,
                decoration: InputDecoration(
                  hintText: context.localization.email
                ),
              ),
              const SizedBox(height: 15,),
              TextFormField(
                validator: (String ? value) {
                  if (value?.isEmpty ?? true ) {
                    return 'Enter Your Password';
                  }
                  return null;
                },
                controller: _passwordTEController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: context.localization.password
                ),
              ),
              const SizedBox(height: 20,),
              GetBuilder<SignInController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.InProgress == false,
                    replacement: const CenterProgressIndecator(),
                    child: ElevatedButton(
                        onPressed: _onTabSignInButton, child:  Text (context.localization.signIn)),
                  );
                }
              ) ,
              const SizedBox(height: 20,),
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
  void _onTabSignUpButton () {
    Navigator.pushNamed(context, SignUpScreen.name);
  }
  void _onTabSignInButton () async {
    if (_formKey.currentState!.validate()) {
      SignInRequestModel signInRequestModel = SignInRequestModel(email: _emailTEController.text.trim(), password: _passwordTEController.text);
      final bool isSuccess = await _signInController.signIn(signInRequestModel);
      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(context, MainButtonNavbar.name, (value) => false);
      } else {
        showSnackBarMsg(context, _signInController.errorMessage!, true);
      }
    }
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

