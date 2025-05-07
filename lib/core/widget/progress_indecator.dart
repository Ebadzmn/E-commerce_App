import 'package:flutter/material.dart';

class CenterProgressIndecator extends StatelessWidget {
  const CenterProgressIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center (
      child: CircularProgressIndicator(),
    );
  }
}
