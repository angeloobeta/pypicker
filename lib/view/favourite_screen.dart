import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pypicker/repository/product_repository.dart';

import '../model/product.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

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
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: product.productImage!,
              ),
              title: Text(product.productName!),
              subtitle: Text(product.brand!),
              trailing: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.deepOrange,
                ),
                onPressed: () {},
              ),
            );
          }),
    );
  }
}
