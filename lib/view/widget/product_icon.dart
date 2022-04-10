import 'package:flutter/material.dart';

class ProductIcons extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  const ProductIcons({Key? key, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: 15,
    );
  }
}
