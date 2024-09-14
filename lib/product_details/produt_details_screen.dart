import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../repository/product.dart';
import '../utils/responsive_menu.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Determine whether the screen is wide enough for a side-by-side layout
    bool isWideScreen = MediaQuery.of(context).size.width > 800;

    return ResponsiveMenu(
     title: product.name,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isWideScreen
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Details
                      Expanded(
                        flex: 3,
                        child: buildProductDetailsLeftWidget(),
                      ),
                      // Related Products
                      Expanded(
                        flex: 2,
                        child: buildProductDetailsRightWidget(context),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      buildProductDetailsLeftWidget(),
                      buildProductDetailsRightWidget(context),
                      // Related Products
                    ],
                  ),
            buildRelatedProduct('Related Products'),
            buildRelatedProduct('Related Products With Free Delivery'),
          ],
        ),
      ),
    );
  }

  Padding buildProductDetailsRightWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          // Product Name
          Text(
            product.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Product Price
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24, color: Colors.green),
          ),
          SizedBox(height: 16),
          // Product Description
          Text(
            product.description,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 24),
          // Add to Cart Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 14),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildProductDetailsLeftWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          SizedBox(
            width: double.infinity,
            // height: 400,
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, _, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),

          Container(
            alignment: Alignment.center,
            height: 80,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10.0),
                    height: 50,
                    width: 50,
                    color: Colors.green,
                  );
                }),
          )
        ],
      ),
    );
  }

  Column buildRelatedProduct(String header) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            header,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.relatedProducts.length,
            itemBuilder: (context, index) {
              final relatedProduct = product.relatedProducts[index];
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: relatedProduct.imageUrl,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: 150,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      relatedProduct.name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${relatedProduct.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
