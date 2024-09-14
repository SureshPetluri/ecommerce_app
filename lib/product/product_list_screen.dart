import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../product_details/produt_details_screen.dart';
import '../repository/product.dart';
import '../utils/responsive_menu.dart';

class CategoryProductShowScreen extends StatelessWidget {
  const CategoryProductShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveMenu(
      title: 'E-Commerce Store',
        body: OrientationBuilder(
          builder: (context, orientation) {
            final productProvider = Provider.of<ProductProvider>(context);
            final products = productProvider.products;

            return LayoutBuilder(
              builder: (context, constraints) {
                // Calculate the number of columns based on the available width
                const itemWidth = 220.0;
                final numColumns = (constraints.maxWidth / itemWidth).floor();

                return GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numColumns,
                    // Set the number of columns dynamically
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio:
                        itemWidth / 250.0, // Fixed item width and height
                  ),
                  itemCount: products.length,
                  itemBuilder: (ctx, i) {
                    final product = products[i];
                    return SizedBox(
                      width: itemWidth,
                      height: 300.0, // Fixed height
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                    product: product /*Product(
                                        name: "Sample Product",
                                        price: 29.99,
                                        description:
                                            "This is a sample product description. It has many features and is very useful.",
                                        imageUrl:
                                            'https://picsum.photos/500/300?random=1',
                                        relatedProducts: List.generate(
                                          20,
                                          (index) => Product(
                                            name: "Related Product $index",
                                            price: 19.99,
                                            description:
                                                "Description for related product $index",
                                            imageUrl:
                                                'https://picsum.photos/500/300?random=$index',
                                          ),
                                        )),*/
                                  ),
                                ));
                          },
                          child: ProductItem(product: product)),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              minLeadingWidth: 0.0,
              minTileHeight: 40,
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0.0,
              horizontalTitleGap: 0.0,
              title: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              subtitle: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .addToCart(product);
              },
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
