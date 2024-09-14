// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/product_model.dart';
//
// class ProductGridItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final product = Provider.of<Product>(context, listen: false);
//
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: GridTile(
//         child: GestureDetector(
//           onTap: () {
//             // Handle product tap
//           },
//           child: Image.network(
//             product.imageUrl,
//             fit: BoxFit.cover,
//           ),
//         ),
//         footer: GridTileBar(
//           backgroundColor: Colors.black87,
//           leading: Consumer<Product>(
//             builder: (ctx, product, _) => IconButton(
//               icon: Icon(
//                 product.isFavorite ? Icons.favorite : Icons.favorite_border,
//               ),
//               color: Theme.of(context).colorScheme.secondary,
//               onPressed: () {
//                 // Provider.of<ProductProvider>(context, listen: false)
//                 //     .toggleFavorite(product.id);
//               },
//             ),
//           ),
//           title: Text(
//             product.name,
//             textAlign: TextAlign.center,
//           ),
//           trailing: IconButton(
//             icon: const Icon(Icons.shopping_cart),
//             color: Theme.of(context).colorScheme.secondary,
//             onPressed: () {
//               // Add to cart action
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
