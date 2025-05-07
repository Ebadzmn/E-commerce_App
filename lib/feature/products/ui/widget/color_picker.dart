import 'package:ecomarce_hello/app/app_colors.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onChange});

  final List<String> colors;
  final Function(String) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  String? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color' , style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        SizedBox(height: 14,),
        SizedBox(
          height: 40,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.colors.length, itemBuilder: (context,index) {
                String Color = widget.colors[index];
            return GestureDetector(
              onTap: () {
                selectedColor = Color;
                widget.onChange(selectedColor!);
                setState(() {});
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: selectedColor == Color ? AppColors.themeColor : null
                ),
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.only(right: 8),
                alignment: Alignment.center,
                child: Text(Color , style: TextStyle(
                  color: selectedColor == Color ? Colors.white : null
                ),),
              ),
            );

          }),
        )
      ],
    );
  }
}
