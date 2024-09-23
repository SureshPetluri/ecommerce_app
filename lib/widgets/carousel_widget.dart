import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key,required this.listOfItems});
final List<String> listOfItems;
  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {

  int currentIndex= 0;
  updateIndex(int index) {
    currentIndex = index;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            viewportFraction: 1,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              updateIndex(index);
            },
          ),
          items: widget.listOfItems.map((url) {
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.listOfItems.map((url) {
            int index = widget.listOfItems.indexOf(url);
            return Container(
              alignment: Alignment.center,
              width: currentIndex == index ? 30.0 : 8.0,
              height: currentIndex == index ? 16.0 : 8.0,
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: currentIndex == index
                    ? BoxShape.rectangle
                    : BoxShape.circle,
                borderRadius:
                currentIndex == index ? BorderRadius.circular(8.0) : null,
                color: currentIndex == index
                    ? const Color(0xFF472586)
                    : Colors.grey,
              ),
              child: currentIndex == index
                  ? Text(
                "${index + 1}/${widget.listOfItems.length}",
                style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Roboto'),
              )
                  : null,
            );
          }).toList(),
        ),
      ],
    );
  }
}
