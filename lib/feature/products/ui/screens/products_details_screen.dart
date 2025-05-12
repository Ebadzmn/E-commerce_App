import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/core/widget/snackBar_msg.dart';
import 'package:ecomarce_hello/feature/auth/ui/controllers/auth_controller.dart';
import 'package:ecomarce_hello/feature/auth/ui/screens/signIn_screen.dart';
import 'package:ecomarce_hello/feature/common/controller/addTo_cart_controller.dart';
import 'package:ecomarce_hello/feature/common/controller/add_wishList_controller.dart';
import 'package:ecomarce_hello/feature/products/ui/controlers/product_details_controller.dart';
import 'package:ecomarce_hello/feature/products/ui/widget/color_picker.dart';
import 'package:ecomarce_hello/feature/products/ui/widget/increment_decrement.dart';
import 'package:ecomarce_hello/feature/products/ui/widget/productSlider.dart';
import 'package:ecomarce_hello/feature/products/ui/widget/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key, required this.productId});

  static const String name = '/products_details';

  final String productId;

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {


  final ProductDetailsController _productDetailsController = ProductDetailsController();
  final AddToCartController _addToCartController = AddToCartController();
  final AddToWishController _addToWishController = AddToWishController();

  String? _selectedColor;
  String? _selectedSize;
  int _selectedQuantity = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productDetailsController.getProductDetails(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (controller) {
          if (controller.InProgress) {
            return const CenterProgressIndecator();
          }
          if (controller.errorMessage != null) {
            return Center(
              child: Text(controller.errorMessage!),
            );
          }


          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      ProductSlider(imageList: controller.product.photos,),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.product.title , style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.w400) ,),
                                    Row(
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.star,color: Colors.amber, size: 18,),
                                            Text('4.3'),
                                          ],
                                        ),
                                        TextButton(onPressed: () {}, child: const Text('Reviews')),
                                        Card(
                                          // color: AppColors.themeColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3)
                                          ),
                                          child: TextButton(onPressed: () async {
                                            if (Get.find<AuthController>().isValidUser() == false) {
                                              Get.to( ()=> SignInScreen());
                                            }
                                            final bool isSuccess = await _addToWishController.addToWish(_productDetailsController.product.id);
                                            if (isSuccess) {
                                              showSnackBarMsg(context, 'Success to add wishlist');
                                            } else {
                                              showSnackBarMsg(context, _addToWishController.errorMessage!,true);
                                            }
                                          }, child: Text('Add to Wish')),
                                        )

                                      ],
                                    )
                                  ],

                                )),
                                IncrementDecrement(onChange: (int quantity ) {
                                  _selectedQuantity = quantity;
                                }, initialValue: controller.product.quantity,),
                              ],
                            ),
                            ColorPicker(colors: controller.product.colors, onChange: (selectedColor) {

                                _selectedColor = selectedColor;

                            }),
                            SizePicker(sizes: controller.product.sizes, onChange: (selectedSizes) {

                                _selectedSize = selectedSizes;

                            }),
                            const SizedBox(height: 18,),
                            const Text('Description' , style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            const SizedBox(height: 12,),
                            Text(controller.product.description ,style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54
                            ),)

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ),
              _buildPriceCard(controller.product.sizes.isNotEmpty , controller.product.colors.isNotEmpty)
            ],
          );
        }
      ),

    );
  }

  Widget _buildPriceCard(bool isSizeAvailable , bool isColorAvailable ) {
    return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.themeColor.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price'),
                  Text('%2990' , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,color: AppColors.themeColor
                  ),),
                ],
              ),
              SizedBox( width : 140 , child: GetBuilder(
                init: _addToCartController,
                builder: (controller) {
                  return Visibility(
                    visible: controller.InProgress == false,
                    replacement: const CenterProgressIndecator(),
                    child: ElevatedButton(onPressed: () async {
                      if (isSizeAvailable && _selectedSize == null) {
                        showSnackBarMsg(context, 'Please selected your Size' , true);
                        return;
                      }
                      if (isColorAvailable && _selectedColor == null) {
                        showSnackBarMsg(context, 'Please selected your color' ,true);
                        return;
                      }

                      if (Get.find<AuthController>().isValidUser() == false) {
                        Get.to(() => const SignInScreen());
                        return;
                      }


                     final bool isSuccess = await _addToCartController.addToCart(_productDetailsController.product.id , _selectedColor,
                       _selectedSize, quantity: _selectedQuantity);
                      if (isSuccess) {
                        showSnackBarMsg(context, 'add to cart');
                      }  else {
                        showSnackBarMsg(
                          context,
                          _addToCartController.errorMessage ?? 'Something went wrong',
                          true,
                        );
                      }
                    }, child: const Text('Add to Card')),
                  );
                }
              ))
            ],
          ),
        );
  }
}
