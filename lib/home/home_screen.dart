import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../data/models/product_model.dart';
import '../data/providers/provider_handler.dart';
import '../product/product_list_screen.dart';
import '../product_details/produt_details_screen.dart';
import '../utils/responsive_menu.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_show_list_grid.dart';

class AmazonHomePage extends StatefulWidget {
  AmazonHomePage({super.key});

  @override
  State<AmazonHomePage> createState() => _AmazonHomePageState();
}

class _AmazonHomePageState extends State<AmazonHomePage> {
  List<Product> popularProducts = [];

  List<Product> computerProducts = [];

  List<Product> groceriesProducts = [];

  List<Product> kidsProducts = [];
  int currentIndex = 0;
  List<Product> totalItems = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    getData();
    totalItems = List.generate(
      8,
      (index) => Product(
        name: "Related Product $index",
        price: 19.99,
        dealPrice: 19.99,
        description: "Description for related product $index",
        imageUrl: 'https://picsum.photos/500/300?random=$index',
      ),
    );
    super.initState();
  }

  getData() async {
    var returnMap = await _apiService.requestApi(
      RequestMethod.get,
      '/products',
    );
    print("returnMap....$returnMap");
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carousel Section
          const CarouselWidget(listOfItems: [
            'https://picsum.photos/500/300?random=1',
            'https://picsum.photos/500/300?random=2',
            'https://picsum.photos/500/300?random=3',
          ]),

          // Categories Section
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const CategoriesWidget(
            routeWidget: CategoryProductShowScreen(),
          ),

          // Product Grid
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Popular Products",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          _buildProductGrid(totalItems, isShowRows: "fillRow"),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Best Electronics",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          _buildProductGrid(totalItems, isShowRows: "onlyTwo"),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<Product> listOfItems, {required String isShowRows}) {
    return OrientationBuilder(builder: (context, orientation) {
      return LayoutBuilder(builder: (context, constraints) {
        const itemWidth = 180.0;
        final numColumns = (constraints.maxWidth / itemWidth).floor();
        final int itemCountToShow;

        if (isShowRows == "fillRow") {
          itemCountToShow = (listOfItems.length >= numColumns)
              ? (listOfItems.length ~/ numColumns) * numColumns
              : listOfItems.length;
        } else if (isShowRows == "onlyTwo") {
          const int maxRows = 2;
          final int itemsForTwoRows =
          min(maxRows * numColumns, listOfItems.length);
          itemCountToShow = (itemsForTwoRows < numColumns)
              ? listOfItems.length
              : itemsForTwoRows;
        } else {
          itemCountToShow = listOfItems.length;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCountToShow,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: numColumns,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: itemWidth / 190.0,
          ),
          itemBuilder: (context, index) {
            listOfItems[index].relatedProducts = List.generate(
              20,
                  (index) => Product(
                name: "Related Product $index",
                price: 19.99,
                dealPrice: 19.99,
                description: "Description for related product $index",
                imageUrl: 'https://picsum.photos/500/300?random=$index',
              ),
            );

            return AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: 1.0, // You can change this to animate visibility based on condition
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(product: listOfItems[index]),
                    ),
                  );
                },
                child: ProductItem(product: totalItems[index]),
              ),
            );
          },
        );
      });
    });
  }

}
