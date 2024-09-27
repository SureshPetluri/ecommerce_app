import 'package:ecommerce_app/mycart/cart_screen.dart';
import 'package:ecommerce_app/views/sign_in/sign_in_screen.dart';
import 'package:ecommerce_app/widgets/app_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/product.dart';
import '../views/Sign_up/sign_up_screen.dart';
import '../views/profile/profile_screen.dart';
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
              pageName.value = "SignIn";
              (!isMobile(context))
                  ? buildShowDialogForWeb(context)
                  : Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 800),
                  reverseTransitionDuration: const Duration(milliseconds: 800), // Ensure reverse animation matches
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Scaffold(body: SingleChildScrollView(child: body)),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = 0.0;
                    const end = 1.0;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var rotationAnimation = animation.drive(tween);

                    return AnimatedBuilder(
                      animation: rotationAnimation,
                      builder: (context, child) {
                        final angle = rotationAnimation.value * 3.1416; // 180 degrees
                        final isUnder = rotationAnimation.value > 0.5;

                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001) // Perspective
                            ..rotateY(angle), // Rotate along Y-axis
                          child: isUnder
                              ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(3.1416),
                            child: const SignInScreen(), // Flip to SignInScreen
                          )
                              : child,
                        );
                      },
                      child: Scaffold(body: SingleChildScrollView(child: body)), // Main screen being flipped out
                    );
                  },
                ),
              );

            },
            title: "Login",
            titleColor: const Color(0xFF000000),
          ),
          const SizedBox(
            width: 10.0,
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
          const SizedBox(
            width: 10.0,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: AbsorbPointer(
              child: Card(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  'https://picsum.photos/seed/904/600',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            body,
            Container(
              alignment: Alignment.center,
              color: Colors.green,
              // height: 500,
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ABOUT"),
                        Text("Contact Us"),
                        Text("Careers"),
                        Text("Ecommerce Stories"),
                        Text("Press"),
                        Text("Corporate Information"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("GROUP COMPANIES"),
                        Text("Myntra"),
                        Text("Cleartrip"),
                        Text("Shopsy"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("HELP"),
                        Text("Payments"),
                        Text("Shipping"),
                        Text("Cancellation & Returns"),
                        Text("FAQ"),
                        Text("Report Infringement"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CONSUMER POLICY"),
                        Text("Cancellation & Returns"),
                        Text("Terms Of Use"),
                        Text("Seccurity"),
                        Text("Privacy"),
                        Text("Sitemap"),
                        Text("Grievance Redressal"),
                        Text("EPR Compliance")
                      ],
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Mail Us:"),
                            const Text("Ecommerce Internet Private Limited,"),
                            const Text("Kummari Street,Santhi Nagar"),
                            const Text("Buchi Reddy Palem"),
                            const Text("SPSR Nellore"),
                            const Text("Andhra Pradesh,524305"),
                            const Text("India"),
                            const Text("Social"),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      radius: 30,
                                      child: Image.network(
                                          "https://picsum.photos/seed/904/600")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      radius: 30,
                                      child: Image.network(
                                          "https://picsum.photos/seed/904/600")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      radius: 30,
                                      child: Image.network(
                                          "https://picsum.photos/seed/904/600")),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Registered Office Address:"),
                            Text("Ecommerce Internet Private Limited,"),
                            Text("Kummari Street,Santhi Nagar"),
                            Text("Buchi Reddy Palem"),
                            Text("SPSR Nellore"),
                            Text("Andhra Pradesh,524305"),
                            Text("India"),
                            Text("Telephone:+918801115787"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Text("Telephone:+918801115787"),
                  Text("Telephone:+918801115787"),
                  Text("Telephone:+918801115787"),
                  Text("Telephone:+918801115787"),
                  Text("Telephone:+918801115787"),
                  Text("Telephone:+918801115787"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialogForWeb(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width > 800
                    ? 800
                    : MediaQuery.sizeOf(context).width * .7,
                height: MediaQuery.sizeOf(context).height > 600
                    ? 600
                    : MediaQuery.sizeOf(context).height,
                child: ValueListenableBuilder<String>(
                  valueListenable: pageName,
                  builder: (context, page, _) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0)),
                              color: Colors.green,
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        page.toUpperCase() == "SIGNIN"
                                            ? "Login"
                                            : "Looks like you're new here!",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFFFFFF)),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      page.toUpperCase() == "SIGNIN"
                                          ? "Get Access to your Orders,Wishlist and Recommendations"
                                          : "Sign up with your mobile number to get started",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFE7E7E9))),
                                  const Spacer(),
                                  Image.network(
                                      "https://picsum.photos/500/300?random=9"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.sizeOf(context).width > 800
                                        ? 18.0
                                        : 0.0),
                            child: page.toUpperCase() == "SIGNIN"
                                ?  buildSignInForm(context)
                                : SignUpScreen.buildSignUpForm(context),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ));
  }
}
