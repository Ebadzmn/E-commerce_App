import 'package:ecomarce_hello/core/widget/progress_indecator.dart';
import 'package:ecomarce_hello/feature/reviews/data/models/reviews_model.dart';
import 'package:ecomarce_hello/feature/reviews/ui/controllers/reviews_list_controllers.dart';
import 'package:ecomarce_hello/feature/reviews/ui/screens/add_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsList extends StatefulWidget {
  const ReviewsList({super.key , required this.productId});

  static const String name = '/reviews_list';
  final String productId;

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  final ReviewsListController _reviewsListController = Get.find<ReviewsListController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewsListController.GetReviewsList(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews List'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ReviewsListController>(
          builder: (controller) {
            if(controller.InProgress) {
              return CenterProgressIndecator();
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(itemCount: controller.reviewsList.length ,itemBuilder: (context,index) {
                    ReviewsModel reviewsList = controller.reviewsList[index];
                    return Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                        title: Text(reviewsList.userModel.firstName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reviewsList.comment , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text('Rating ${reviewsList.rating}')
                          ],
                        )
                      ),
                    );
                  }),
                )
              ],
            );
          }
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Navigator.pushNamed(context, AddReviewScreen.name, arguments: widget.productId);
      // } , child: Icon(Icons.add),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReviewScreen(productId: widget.productId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
