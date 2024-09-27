import 'package:ecommerce_app/home/home_screen.dart';
import 'package:flutter/material.dart';

class SignInController extends ChangeNotifier{
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignInController() {
    passwordController.addListener(updatePassword);

  }

  updatePassword() {
    notifyListeners(); // Notify listeners to rebuild UI when text changes
  }

  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners(); // Notify listeners to rebuild the UI for visibility toggle
  }

  submit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AmazonHomePage()));
    }
  }
}
