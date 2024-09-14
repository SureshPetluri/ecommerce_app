class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final List<Product> relatedProducts;


  Product({this.id = "", required this.name, required this.imageUrl, required this.price,this.description = "",this.relatedProducts= const <Product>[] });
}


class RelatedProduct {
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final List<RelatedProduct> relatedProducts;

  RelatedProduct({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.relatedProducts = const [],
  });
}
