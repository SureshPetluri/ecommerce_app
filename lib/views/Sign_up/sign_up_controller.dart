

import 'package:flutter/material.dart';

import '../../home/home_screen.dart';

class SignUpController extends ChangeNotifier{
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
 GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  SignUpController(){
    passwordController.addListener(updateListener);
    confirmPasswordController.addListener(updateListener);
  }

  updateListener(){
    notifyListeners();
  }

  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();  // Notify listeners to rebuild the UI for visibility toggle
  }
  toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();  // Notify listeners to rebuild the UI for visibility toggle
  }

  submit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AmazonHomePage()));
    }
  }
}