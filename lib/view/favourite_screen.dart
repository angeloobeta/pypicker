import 'package:flutter/material.dart';
import 'package:pypicker/repository/product_repository.dart';

import '../model/product.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late List<Product> products;

  @override
  void initState() {
    products = ProductRepository().get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: products.length,
          itemBuilder: (BuildContext ctx, index) {
            Product product = products[index];
            return Container(
              alignment: Alignment.center,
              child: Text(product.productName!),
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(15)),
            );
          }),
    );
  }
}
