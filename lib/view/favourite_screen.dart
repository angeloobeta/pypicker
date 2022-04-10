import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pypicker/blocs/product/product_bloc.dart';
import 'package:pypicker/repository/product_repository.dart';

import '../model/product.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  // late List<Product> products;
  // final List<Map> myProducts =
  //     List.generate(100000, (index) => {"id": index, "name": "Product $index"})
  //         .toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(repository: ProductRepository())
        ..add(GetFavouriteProductEvent()),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          body:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is ProductLoadedState) {
              return state.products.isNotEmpty
                  ? buildFavouriteList(state.products)
                  : const Center(
                      child: Text("You don't have any Favourite product"),
                    );
            }
            return Container();
          }),
        );
      }),
    );
  }

  Widget buildFavouriteList(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: products.length,
          itemBuilder: (BuildContext ctx, index) {
            Product product = products[index];
            return ListTile(
              leading: CachedNetworkImage(
                height: 80,
                width: 50,
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
