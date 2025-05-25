import 'package:ecomarce_hello/feature/reviews/ui/controllers/add_review_controller.dart';
import 'package:ecomarce_hello/feature/reviews/ui/screens/reviews_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReviewScreen extends StatefulWidget {
  final String productId;
  const AddReviewScreen({super.key , required this.productId});

  static const String name = '/addReview';

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {

  final TextEditingController _commentTEController = TextEditingController();
  final TextEditingController _ratingTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddReviewController _addReviewController = Get.find<AddReviewController>();

  void _addNew () async {
    if(_formKey.currentState!.validate()) {
      final int ratingInt = int.parse(_ratingTEController.text);
      final bool isSuccess = await _addReviewController.AddReview(
        _commentTEController.text,
        ratingInt,
        widget.productId,
      );
      if (isSuccess) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add Your Review',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 30,),
              TextFormField(
                controller: _commentTEController,
                decoration: InputDecoration(
                  hintText: 'Comment'
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                controller: _ratingTEController,
                decoration: InputDecoration(
                    hintText: 'Rating'
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: _addNew, child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
