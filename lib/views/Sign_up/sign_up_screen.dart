import 'package:ecommerce_app/views/Sign_up/sign_up_controller.dart';
import 'package:ecommerce_app/widgets/app_btn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../widgets/app_textField.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x5B64ED10),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.clear)),
                title: const Text("Ecommerce")),
          ),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Color(0xFFFFFFFF)),
                  child: Center(child: buildSignUpForm(context)))),
        ],
      ),
    );
  }

  static Widget buildSignUpForm(BuildContext context) {
    SignUpController signUpController = context.watch<SignUpController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: signUpController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: signUpController.userController,
              hintText: "First and last name",
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              controller: signUpController.emailController,
              hintText: "email",
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              controller: signUpController.mobileController,
              hintText: "Mobile number",
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              controller: signUpController.passwordController,
              hintText: "Password",
              obscureText: !signUpController.isPasswordVisible,
              suffix: signUpController.passwordController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        signUpController.togglePasswordVisibility();
                      },
                      icon: Icon(
                        signUpController.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              controller: signUpController.confirmPasswordController,
              hintText: "Confirm password",
              obscureText: !signUpController.isConfirmPasswordVisible,
              suffix: signUpController.confirmPasswordController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        signUpController.toggleConfirmPasswordVisibility();
                      },
                      icon: Icon(
                        signUpController.isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(TextSpan(
                text: "By continuing, you agree to Ecommerce's",
                style: const TextStyle(
                    fontFamily: "Raleway",
                    color: Color(0xFF201B59),
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
                children: [
                  TextSpan(
                    text: " Terms of Use ",
                    style: const TextStyle(
                        fontFamily: "Raleway",
                        color: Color(0xFFF67434),
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(
                      text: "and",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          color: Color(0xFF201B59),
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                  TextSpan(
                    text: " Privacy Policy.",
                    style: const TextStyle(
                        fontFamily: "Raleway",
                        color: Color(0xFFF67434),
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ])),
            const SizedBox(
              height: 10,
            ),
            AppButton(
              onPressed: () {
                signUpController.submit(context);
              },
              title: "Register",
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              isTextBtn: true,
              onPressed: () {
                pageName.value = "SignIn";
              },
              title: "Existing user? Log in",
              titleColor: const Color(0xFF000000),
              titleFontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
