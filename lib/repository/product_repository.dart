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

  Future<int> saveTask(Product product) async {
    var dbClient = await SqfLiteReference().db;
    int result = await dbClient!.insert('products', product.toJson());
    return result;
  }

  Future<List<Product>> geAllTask() async {
    var dbClient = await SqfLiteReference().db;

    var result = await dbClient!.rawQuery(
      "SELECT * FROM products",
    );
    return result.toList().map((product) => Product.fromJson(product)).toList();
  }
}
