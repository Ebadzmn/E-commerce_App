import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/feature/common/controller/slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homeSlider extends StatefulWidget {
  const homeSlider({
    super.key,
  });

  @override
  State<homeSlider> createState() => _homeSliderState();
}

class _homeSliderState extends State<homeSlider> {
  int _selectedSlider = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSliderController>(
      builder: (controller) {
        return Visibility(
          visible: controller.InProgress == false,
          replacement: const SizedBox(
              height: 200,
              child: CenterProgressIndecator()),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 200.0 , viewportFraction: 0.90 ,autoPlay: true,  onPageChanged: (index , reason) {
                  _selectedSlider = index;

                  setState(() {});
                }),
                items: controller.slider.map((slider) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                              color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: NetworkImage(slider.photo_url), fit: BoxFit.cover)
                          ),
                          // child: Padding(
                          //   padding: const EdgeInsets.all(20.0),
                          //   child: Text(slider.description, style: TextStyle(fontSize: 16.0 , color: Colors.grey),),
                          // )
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 13,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i=0; i< controller.slider.length; i++)
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
              )
            ],
          ),
        );
      }
    );
  }
}