import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:flutter/material.dart';

class IncrementDecrement extends StatefulWidget {
  const IncrementDecrement({super.key, required this.onChange});

  final Function (int) onChange;

  @override
  State<IncrementDecrement> createState() => _IncrementDecrementState();
}

class _IncrementDecrementState extends State<IncrementDecrement> {
  int Count = 1;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      children: [
        GestureDetector(
          onTap: () {
            if (Count >= 20 ) return;
            Count++;
            widget.onChange(Count);
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(Icons.add),

          ),
        ),

        Text('$Count',style: TextStyle(
          fontWeight: FontWeight.w600
        ),),

        GestureDetector(
          onTap: () {
            if (Count <=1 ) return;
            Count--;
            widget.onChange(Count);
            setState(() {

            });
          },
          child: Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(Icons.remove),

          ),
        )
      ],
    );
  }
}
