import 'package:ecommerce_app/mycart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/product.dart';

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
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartScreen()));
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
}
