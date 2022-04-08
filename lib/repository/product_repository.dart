import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pypicker/model/product.dart';

class ProductRepository {
  List<Product>? products = [];
  Future<List<Product>> getProducts() async {
    try {
      final jsonData = await rootBundle.loadString('assets/data.json');
      final productList = json.decode(jsonData) as List;
      return productList.map((product) => Product.fromJson(product)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  setProduct(Product product) {
    products!.add(product);
  }

  List<Product>? getProduct() {
    return products;
  }
}
