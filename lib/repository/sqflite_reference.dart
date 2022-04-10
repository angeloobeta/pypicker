import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class SqfLiteReference {
  static final SqfLiteReference _instance = SqfLiteReference.internal();

  factory SqfLiteReference() => _instance;
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return db;
  }

  SqfLiteReference.internal();

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'products.db');

    var dataBase = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dataBase;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE products(productId INTEGER PRIMARY KEY, productImage TEXT,productName TEXT,originalPrice INTEGER,rating REAL,discountPercentage INTEGER,discountPrice INTEGER,brand TEXT)",
    );
  }
}
