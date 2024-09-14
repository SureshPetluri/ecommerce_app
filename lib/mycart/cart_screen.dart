import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../repository/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: ListView.builder(
          itemCount: controller.cart.length,
          itemBuilder: (context, index) {
            final item = controller.cart[index];
            return CartItemWidget(
              item: item,
              controller: controller,
            );
          },
        ),
      );
    });
  }
}

class CartItemWidget extends StatelessWidget {
  final Product item;
  final ProductProvider controller;

  const CartItemWidget(
      {super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 150,
                    maxHeight: 200,
                    minWidth: 50,
                    minHeight: 50,
                  ),
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Icon(Icons.error));
                    },
                  ),
                ),

                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      _buildRatingBar(item.rating),
                      SizedBox(height: 8.0),
                      Text(
                        'Price: \$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      if (item.color != null) ...[
                        SizedBox(height: 4.0),
                        Text(
                          'Color: ${item.color}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                      if (item.size != null) ...[
                        SizedBox(height: 4.0),
                        Text(
                          'Size: ${item.size}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                      if (item.discount > 0) ...[
                        SizedBox(height: 4.0),
                        Text(
                          'Discount: \$${item.discount.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.removeFromCart(item);
                    // Handle remove item
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Remove'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle buy now
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Buy This Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          color: index < rating ? Colors.amber : Colors.grey,
          size: 20,
        );
      }),
    );
  }
}
