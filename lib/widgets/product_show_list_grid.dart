import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/product_model.dart';
import '../repository/product.dart';

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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '\$${product.dealPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF2196F3)),
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(5, (index) {
                        if (index < 3.5.floor()) {
                          // Full stars
                          return const Icon(
                            Icons.star,
                            size: 12,
                            color: Color(0xFFEE6C55),
                          );
                        } else if (index < 3.5 && 3.5 - index >= 0.5) {
                          // Half star
                          return const Icon(
                            Icons.star_half,
                            size: 12,
                            color: Color(0xFFEE6C55),
                          );
                        } else {
                          // Empty stars
                          return const Icon(
                            Icons.star_border,
                            size: 12,
                            color: Color(0xFFEE6C55),
                          );
                        }
                      }),
                    ),
                    IconButton(
                        tooltip: 'Add to Cart',
                        onPressed: (){
                          Provider.of<ProductProvider>(context, listen: false)
                              .addToCart(product);
                        }, icon: const Icon(Icons.shopping_cart,size: 15,))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
