import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pypicker/model/product.dart';
import 'package:pypicker/repository/sqflite_reference.dart';

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

  Future<int> saveFavouriteProduct(Product product) async {
    var dbClient = await SqfLiteReference().getDataBase();

    int result = await dbClient.insert('products', product.toMap());

    return result;
  }

  Future<List<Product>> getFavouriteProduct() async {
    var dbClient = await SqfLiteReference().getDataBase();

    var result = await dbClient.rawQuery(
      "SELECT * FROM products",
    );
    return result.toList().map((product) => Product.fromJson(product)).toList();
  }
}
