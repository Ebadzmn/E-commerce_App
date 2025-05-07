import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onChange});

  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  String? selectedSizes;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Text('Sizes' , style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        SizedBox(height: 14,),
        SizedBox(
          height: 40,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.sizes.length, itemBuilder: (context,index) {
                String size = widget.sizes[index];
            return GestureDetector(
              onTap: () {
                selectedSizes = size;
                widget.onChange(selectedSizes!);
                setState(() {});
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: selectedSizes == size ? AppColors.themeColor : null
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.only(right: 8),
                alignment: Alignment.center,
                child: Text(size , style: TextStyle(
                  color: selectedSizes == size ? Colors.white : null
                ),),
              ),
            );

          }),
        )
      ],
    );
  }
}
