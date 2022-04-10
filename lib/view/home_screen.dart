import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pypicker/blocs/product/product_bloc.dart';
import 'package:pypicker/repository/product_repository.dart';
import 'package:pypicker/view/widget/product_icon.dart';

import '../model/product.dart';
import 'favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductBloc productBloc;
  List<Product> _products = [];
  // final List<Map> myProducts =
  //     List.generate(100000, (index) => {"id": index, "name": "Product $index"})
  //         .toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(repository: ProductRepository()),
      child: Builder(builder: (context) {
        productBloc = BlocProvider.of<ProductBloc>(context);
        productBloc.add(GetProductEvent());
        return Scaffold(
          body:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is ProductLoadedState) {
              _products = state.products;
              return buildGridList(state.products);
            }
            return _products.isNotEmpty
                ? buildGridList(_products)
                : Container();
          }),
        );
      }),
    );
  }

  Padding buildGridList(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.6,
              crossAxisSpacing: 10,
              mainAxisExtent: MediaQuery.of(context).size.height * 0.4),
          itemCount: products.length,
          itemBuilder: (BuildContext ctx, index) {
            Product product = products[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.values[5],
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridTile(
                    child: GestureDetector(
                  onTap: () {
                    productBloc.add(SaveFavouriteProductEvent(product));
                  },
                  child: CachedNetworkImage(
                    imageUrl: product.productImage!,
                    fit: BoxFit.cover,
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.productName!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.favorite_outline_sharp,
                        color: Colors.black45,
                      ),
                    )
                  ],
                ),
                Text(
                  product.brand!.toUpperCase(),
                  style: const TextStyle(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Rs. ${product.discountPrice!.toString()}  ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rs. ${product.originalPrice!.toString()} ',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '${product.discountPercentage.toString()} %',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    ProductIcons(
                        icon: Icons.star, color: Colors.deepOrangeAccent),
                    ProductIcons(
                        icon: Icons.star, color: Colors.deepOrangeAccent),
                    ProductIcons(
                        icon: Icons.star, color: Colors.deepOrangeAccent),
                    ProductIcons(
                        icon: Icons.star, color: Colors.deepOrangeAccent),
                    ProductIcons(
                        icon: Icons.star_outline,
                        color: Colors.deepOrangeAccent),
                  ],
                )
              ],
            );
          }),
    );
  }
}

// https://blog.logrocket.com/how-to-build-a-bottom-navigation-bar-in-flutter/
// https://www.willowtreeapps.com/craft/how-to-use-flutter-to-build-an-app-with-bottom-navigation
// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
// https://www.figma.com/proto/reeNF0QCoaEMarFi8Iloir/Plypicker-App?node-id=1%3A15&scaling=scale-down&page-id=0%3A1&starting-point-node-id=1%3A15
