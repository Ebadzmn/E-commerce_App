import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({
    super.key, required this.imageList,
  });

  final List <String> imageList;

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  int _selectedSlider = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 250.0 , viewportFraction: 0.90 ,  onPageChanged: (index , reason) {
            _selectedSlider = index;
            setState(() {});
          }),
          items: widget.imageList.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(image , fit:BoxFit.cover);
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i=0; i<widget.imageList.length; i++)
                Container(
                  height: 20,
                  width: 20,
                  margin: EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                      color: _selectedSlider == i ? AppColors.themeColor : Colors.white
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}