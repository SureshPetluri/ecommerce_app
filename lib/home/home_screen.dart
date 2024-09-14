import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../product_details/produt_details_screen.dart';
import '../product/product_list_screen.dart';
import '../utils/responsive_menu.dart';

class AmazonHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveMenu(
      title: 'E-Commerce',
      /*appBar: AppBar(
        title: Text(),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),*/
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isWeb = MediaQuery.of(context).size.width > 600;

          return ListView(
            children: [
              // Carousel Section
              _buildCarousel(),

              // Categories Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Categories",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              _buildCategorySection(),

              // Product Grid
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Popular Products",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              _buildProductGrid(isWeb: isWeb),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
      ),
      items: [
        'https://picsum.photos/500/300?random=1',
        'https://picsum.photos/500/300?random=1',
        'https://picsum.photos/500/300?random=1',
      ].map((url) {
        return Builder(
          builder: (BuildContext context) {
            return CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCategorySection() {
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

            /*ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryCard('Fashion',  'https://picsum.photos/500/300?random=2',),
              _buildCategoryCard('Home Decor',  'https://picsum.photos/500/300?random=3',),
              _buildCategoryCard('Work Tools',  'https://picsum.photos/500/300?random=4',),
              _buildCategoryCard('Groceries',  'https://picsum.photos/500/300?random=5',),
            ],
          );*/
          }),
    );
  }

  Widget _buildCategoryCard(String title, String imageUrl) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProductGrid({required bool isWeb}) {
    return OrientationBuilder(builder: (context, orientation) {
      return LayoutBuilder(builder: (context, constraints) {
        const itemWidth = 220.0;
        final numColumns = (constraints.maxWidth / itemWidth).floor();
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          // Example product count
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: numColumns,
            // Set the number of columns dynamically
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: itemWidth / 230.0, // Fixed item width and height
          ),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          product: Product(
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
                              )),
                        ),
                      ));
                },
                child: AbsorbPointer(child: _buildProductCard(index)));
          },
        );
      });
    });
  }

  Widget _buildProductCard(int index) {
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
                'https://picsum.photos/500/300?random=$index',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Product Name', style: TextStyle(fontSize: 16)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    minLeadingWidth: 0.0,
                    minTileHeight: 40,
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0.0,
                    horizontalTitleGap: 0.0,
                    title: Text(
                      '\$49.99',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    subtitle: Text(
                      '\$99.99',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AmazonHomePage(),
  ));
}
