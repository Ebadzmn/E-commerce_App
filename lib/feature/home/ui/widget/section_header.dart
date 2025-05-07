import 'package:ecomarce_hello/core/extension/localization_extention.dart';
import 'package:flutter/material.dart';

class SelectionHeader extends StatelessWidget {
  const SelectionHeader({
    super.key, required this.title, required this.onTapSeeAll,
  });

  final String title;
  final VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title , style:  textTheme.titleMedium?.copyWith(
            fontSize: 24
        ),),
        TextButton(onPressed: onTapSeeAll, child: Text(context.localization.see_all))
      ],
    );
  }
}