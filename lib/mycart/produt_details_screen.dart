import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../repository/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ProductDetailsPage(
        product: Product(
            name: "Sample Product",
            price: 29.99,
            description:
                "This is a sample product description. It has many features and is very useful.",
            imageUrl: 'https://picsum.photos/500/300?random=1',
            relatedProducts: List.generate(
              20,
              (index) => Product(
                name: "Related Product $index",
                price: 19.99,
                description: "Description for related product $index",
                imageUrl: 'https://picsum.photos/500/300?random=$index',
              ),
            )),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Determine whether the screen is wide enough for a side-by-side layout
    bool isWideScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      // Navigate to cart page (not implemented)
                    },
                  ),
                  if (provider.cart.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          provider.cart.length.toString(),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
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
                        child: buildProductDetailsleftWidget(),
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
                      buildProductDetailsleftWidget(),
                      buildProductDetailsRightWidget(context),
                      // Related Products
                    ],
                  ),
            buildproductShowColumn('Related Products'),
            buildproductShowColumn('Related Products With Free Delivery'),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart!')),
                );
              },
              child: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 14),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildProductDetailsleftWidget() {
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
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),

          Center(
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }

  Column buildproductShowColumn(String header) {
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
