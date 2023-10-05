import 'package:flutter/material.dart';

class ItemProductImage extends StatelessWidget {
  const ItemProductImage({Key? key, required this.imageLink}) : super(key: key);

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageLink,
      fit: BoxFit.contain,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
