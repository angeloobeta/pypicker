import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pypicker/model/product.dart';

class ProductRepository {
  Future<List<Product>> getProducts() async {
    try {
      final jsonData = await rootBundle.loadString('assets/data.json');
      final productList = json.decode(jsonData) as List;
      return productList.map((product) => Product.fromJson(product)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  List<Product> _products = [];
  List<Product> get() => _products;
  void setProduct(Product product) {
    _products.add(product);
  }
}
