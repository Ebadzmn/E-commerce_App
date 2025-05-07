import 'package:ecomarce_hello/feature/common/ui/widget/product_card.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});



  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WishList'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3 ,mainAxisSpacing: 15), itemBuilder: (context,index) {
          return const FittedBox();
        }),
      ),
    );
  }
}
