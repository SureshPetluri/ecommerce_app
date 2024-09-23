import 'package:flutter/foundation.dart';

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  ProductProvider() {
    _products = List.generate(
      20,
      (index) => Product(
          id: '$index',
          name: 'Product $index',
          imageUrl: getImageURL(index),
          price: 29.99,
          dealPrice: 29.99),
    );
  }

  String getImageURL(int index) {
    return 'https://picsum.photos/500/300?random=$index';
  }

  List<Product> get products => _products;

  List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }
}
