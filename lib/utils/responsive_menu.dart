import 'package:ecommerce_app/mycart/cart_screen.dart';
import 'package:ecommerce_app/views/sign_in/sign_in_screen.dart';
import 'package:ecommerce_app/widgets/app_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/product.dart';
import '../views/Sign_up/sign_up_screen.dart';
import 'constants.dart';

class ResponsiveMenu extends StatelessWidget {
  const ResponsiveMenu({super.key, this.title = "", required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          AppButton(
            isTextBtn: true,
            alignment: Alignment.centerLeft,
            onPressed: () {
              (!isMobile(context))
                  ? buildShowDialogForWeb(context)
                  : Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            title: "Login",
            titleColor: Color(0xFF000000),
          ),
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.shopping_cart),
                    ),
                    if (provider.cart.isNotEmpty)
                      Positioned(
                        right: 4,
                        top: 2,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            provider.cart.length.toString(),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: body,
    );
  }

  Future<dynamic> buildShowDialogForWeb(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width > 700
                    ? 700
                    : MediaQuery.sizeOf(context).width * .7,
                height: MediaQuery.sizeOf(context).height > 600
                    ? 600
                    : MediaQuery.sizeOf(context).height,
                child: ValueListenableBuilder<String>(
                  valueListenable: pageName,
                  builder: (context, page, _) {
                    return Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0)),
                                color: Colors.green,
                              ),
                              alignment: Alignment.center,
                              child: Text("fkjkjhfv"),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: page.toUpperCase() == "SIGNIN"
                                ? SignInScreen.buildSignInForm(context)
                                : SignUpScreen.buildSignUpForm(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ));
  }
}
