import 'package:ecommerce_app/widgets/app_btn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/app_textField.dart';
import '../Sign_up/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildSignInForm(context),
    );
  }

  static Widget buildSignInForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppTextField(),
          const SizedBox(
            height: 10,
          ),
          const AppTextField(),
          const SizedBox(
            height: 20,
          ),
          AppButton(
            onPressed: () {},
            title: "LogIn",
          ),
          const SizedBox(
            height: 20,
          ),
          Text.rich(TextSpan(
              text: "Don't have an Account?",
              style: const TextStyle(
                  fontFamily: "Raleway",
                  color: Color(0xFF201B59),
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              children: [
                TextSpan(
                  text: "Register",
                  style: const TextStyle(
                      fontFamily: "Raleway",
                      color: Color(0xFFF67434),
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => (!isMobile(context))
                        ? pageName.value = "Register"
                        :Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen())),
                ),
              ]))
        ],
      ),
    );
  }

}
