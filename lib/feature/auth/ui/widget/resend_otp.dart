import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class ResendOtp extends StatefulWidget {
  const ResendOtp({super.key});

  @override
  State<ResendOtp> createState() => _ResendOtpState();
}

class _ResendOtpState extends State<ResendOtp> {
  int start = 30;
  Timer? timer;
  bool isResendEnable = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer () {
    isResendEnable = false;
    start = 30;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == 0) {
       setState(() {
         isResendEnable = true;
       });
       timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void onTabResend () {
    if (isResendEnable) {
      print('Resend Button Tab');
      startTimer();
    }
  }


  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: isResendEnable ? '' : '$start sec  ',
        style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600
        ),
        children: [
          TextSpan(
              text: 'Resend',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isResendEnable ? Colors.blue : Colors.grey
              ),
              recognizer: isResendEnable ? (TapGestureRecognizer()..onTap = onTabResend) : null
          ),
        ],
      ),
    );
  }
}
