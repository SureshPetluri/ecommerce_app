import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.controller,
      this.validator,
      this.hintText,
      this.prefix,
      this.obscureText = false,
      this.suffix});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? prefix;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorHeight: 18,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1.5)),
          errorStyle: const TextStyle(fontWeight: FontWeight.w600),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: redColor, width: 1.5),
          ),
          hintStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Color(
              0xFFB4B1B1)),
          prefix: prefix,
          suffixIcon: SizedBox(width: 30, child: suffix)),
    );
  }
}
