import 'package:ecommerce_app/views/sign_in/sign_in_controller.dart';
import 'package:ecommerce_app/widgets/app_btn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../widgets/app_textField.dart';
import '../Sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _signInAnimation;
  late Animation<Offset> _signUpAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _signInAnimation = Tween<Offset>(
      begin: Offset.zero, // On screen
      end: const Offset(-1.0, 0.0), // Move out to the left
    ).animate(_controller);

    _signUpAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Off-screen on the right
      end: Offset.zero, // Move into view
    ).animate(_controller);
  }

  void toggleForms(String name) {
    if (name.toUpperCase() == "SIGNIN") {
      _controller.reverse(); // Go back to sign-in
    } else {
      _controller.forward(); // Show sign-up
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x5B64ED10),
      body: Column(
        mainAxisSize: MainAxisSize.max,
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
                child: Center(
                    child: ValueListenableBuilder(
                        valueListenable: pageName,
                        builder: (context, String name, _) {
                          toggleForms(name);
                          return Stack(
                            children: [
                              SlideTransition(
                                  position: _signInAnimation,
                                  child: buildSignInForm(context)),
                              SlideTransition(
                                  position: _signUpAnimation,
                                  child: SignUpScreen.buildSignUpForm(context)),
                            ],
                          );
                        }))),
          ),
        ],
      ),
    );
  }
}

Widget buildSignInForm(BuildContext context) {
  final signInController = context.watch<SignInController>();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Form(
      key: signInController.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            controller: signInController.userController,
            hintText: "Email or mobile number",
            validator: (e) {
              if ((e?.isNotEmpty ?? false)) {
                return null;
              } else {
                return "! Enter your email or mobile number";
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          AppTextField(
            controller: signInController.passwordController,
            hintText: "Password",
            validator: (e) {
              if ((e?.isNotEmpty ?? false)) {
                return null;
              } else {
                return "! Enter your password";
              }
            },
            obscureText: !signInController.isPasswordVisible,
            suffix: signInController.passwordController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      signInController.togglePasswordVisibility();
                    },
                    icon: Icon(
                      signInController.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          AppButton(
            alignment: Alignment.centerRight,
            isTextBtn: true,
            onPressed: () {},
            title: "Forgot Password",
            titleFontSize: 12,
            titleColor: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          Text.rich(
            TextSpan(
              text: "By continuing, you agree to Ecommerce's",
              style: const TextStyle(
                fontFamily: "Raleway",
                color: Color(0xFF201B59),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: " Terms of Use ",
                  style: const TextStyle(
                    fontFamily: "Raleway",
                    color: Color(0xFFF67434),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(
                  text: "and",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    color: Color(0xFF201B59),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text: " Privacy Policy.",
                  style: const TextStyle(
                    fontFamily: "Raleway",
                    color: Color(0xFFF67434),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          AppButton(
            onPressed: () {
              signInController.submit(context);
            },
            title: "LogIn",
          ),
          const SizedBox(
            height: 20,
          ),
          AppButton(
            isTextBtn: true,
            onPressed: () {
              pageName.value = "Register";
              /* (!isMobile(context))
                        ? pageName.value = "Register"
                        : Navigator.pushReplacement(
                      context,
                        MaterialPageRoute(builder: (context)=>SignUpScreen(),));*/
              //
            },
            title: "New to Ecommerce? Create an account",
            titleColor: const Color(0xFF000000),
            titleFontSize: 16,
          ),
        ],
      ),
    ),
  );
}
