import 'package:ecommerce_app/widgets/app_btn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/app_textField.dart';
import '../sign_in/sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildSignUpForm(context),
    );
  }

  static Widget buildSignUpForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(),
          const SizedBox(
            height: 10,
          ),
          AppTextField(),
          const SizedBox(
            height: 10,
          ),
          AppTextField(),
          const SizedBox(
            height: 10,
          ),
          AppTextField(),
          const SizedBox(
            height: 10,
          ),
          const AppTextField(),
          const SizedBox(
            height: 20,
          ),
          AppButton(
            onPressed: () {},
            title: "Register",
          ),
          const SizedBox(
            height: 20,
          ),
          Text.rich(TextSpan(
              text: "Already have an Account ?",
              style: const TextStyle(
                  fontFamily: "Raleway",
                  color: Color(0xFF201B59),
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              children: [
                TextSpan(
                    text: "Login",
                    style: const TextStyle(
                        fontFamily: "Raleway",
                        color: Color(0xFFF67434),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        (!isMobile(context))
                            ? pageName.value = "SignIn"
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()));
                      }),
              ]))
        ],
      ),
    );
  }
}
