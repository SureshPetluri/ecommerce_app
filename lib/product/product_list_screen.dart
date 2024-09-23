import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../product_details/produt_details_screen.dart';
import '../repository/product.dart';
import '../utils/responsive_menu.dart';
import '../widgets/product_show_list_grid.dart';

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
                const itemWidth = 150.0;
                final numColumns = (constraints.maxWidth / itemWidth).floor();

                return GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numColumns,
                    // Set the number of columns dynamically
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio:
                        itemWidth / 170.0, // Fixed item width and height
                  ),
                  itemCount: products.length,
                  itemBuilder: (ctx, i) {
                    final product = products[i];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                    product:
                                        product /*Product(
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
                        child: ProductItem(product: product));
                  },
                );
              },
            );
          },
        ));
  }
}

