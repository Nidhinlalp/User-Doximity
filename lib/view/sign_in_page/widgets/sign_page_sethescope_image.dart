import 'package:flutter/material.dart';

class SingPageSethesCopeImage extends StatelessWidget {
  const SingPageSethesCopeImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
      ],
    );
  }
}
