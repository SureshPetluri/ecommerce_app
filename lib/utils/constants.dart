import 'package:flutter/material.dart';

const DEV_API_BASE = "http://192.168.0.113:5001";
const BEARER = "";
const AUTHORIZATION = "";

bool isMobile(context) => MediaQuery.sizeOf(context).width < 600;

ValueNotifier<String> pageName = ValueNotifier("Signin");
