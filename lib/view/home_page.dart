import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pypicker/blocs/product/product_bloc.dart';
import 'package:pypicker/repository/product_repository.dart';

import '../model/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductBloc productBloc;
  // final List<Map> myProducts =
  //     List.generate(100000, (index) => {"id": index, "name": "Product $index"})
  //         .toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(repository: ProductRepository()),
      child: Builder(builder: (context) {
        productBloc = BlocProvider.of<ProductBloc>(context);
        return Scaffold(
          body:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is ProductLoadedState) {
              return buildGridList(state.products);
            }
            return Container();
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
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: products.length,
          itemBuilder: (BuildContext ctx, index) {
            Product product = products[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  product.productName!,
                  style: const TextStyle(color: Colors.blue),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10)),
                  child: GestureDetector(
                    onTap: () {
                      ProductRepository().setProduct(product);
                    },
                    child: CachedNetworkImage(
                      imageUrl: product.productImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
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
