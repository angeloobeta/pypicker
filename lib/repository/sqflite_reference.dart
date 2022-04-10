import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class SqfLiteReference {
  Future<Database> getDataBase() async {
    Database database = await initDb();
    return database;
  }

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'productsDB.db');

    var dataBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''CREATE TABLE products('product_image' TEXT,'product_name' TEXT,'original_price' INTEGER,'rating' REAL,'discount_percentage' INTEGER,'discounted_price' INTEGER,'brand' TEXT)''');
    });
    return dataBase;
  }
}
