import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../repository/product.dart';
import '../utils/responsive_menu.dart';
import '../widgets/product_show_list_grid.dart';

class ProductDetailsPage extends StatefulWidget {
  Product product;

  ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // Determine whether the screen is wide enough for a side-by-side layout
    bool isWideScreen = MediaQuery.of(context).size.width > 800;

    return ResponsiveMenu(
      title: widget.product.name,
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
          const SizedBox(height: 16),
          // Product Name
          Text(
            widget.product.name,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Product Price
          Text(
            '\$${widget.product.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 24, color: Colors.green),
          ),
          const SizedBox(height: 16),
          // Product Description
          Text(
            widget.product.description,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          // Add to Cart Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .addToCart(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('${widget.product.name} added to cart!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Add to Cart'),
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
              imageUrl: widget.product.imageUrl,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, _, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),

          Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
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
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            header,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 170,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.product.relatedProducts.length,
            itemBuilder: (context, index) {
              final relatedProduct = widget.product.relatedProducts[index];
              return SizedBox(
                  width: 170,
                  child: Flexible(
                    child: InkWell(
                      onTap: () {
                        widget.product = relatedProduct;
                        widget.product.relatedProducts = List.generate(
                          20,
                              (index) => Product(
                            name: "Related Product $index",
                            price: 19.99,
                            dealPrice: 19.99,
                            description: "Description for related product $index",
                            imageUrl: 'https://picsum.photos/500/300?random=$index',
                          ),
                        );
                        setState(() {});
                      },
                      child: ProductItem(
                        product: relatedProduct,
                      ),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
