import 'package:ecommerce_app/repository/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=> ProductProvider()),
      ],
      builder: (context, _)=> MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AmazonHomePage(),
        ),
    );
  }
}
