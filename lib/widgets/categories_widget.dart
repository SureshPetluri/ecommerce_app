import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../product/product_list_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key,this.routeWidget});
final routeWidget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const CategoryProductShowScreen()));
              },
              child: AbsorbPointer(
                child: _buildCategoryCard(
                  'Electronics',
                  'https://picsum.photos/500/300?random=$index',
                ),
              ),
            );
          }),
    );
  }
}

Widget _buildCategoryCard(String title, String imageUrl) {
  return Container(
    width: 80,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0)),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}
