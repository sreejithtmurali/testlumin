import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart_products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE CartProducts (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        category TEXT,
        price TEXT,
        discountPercentage TEXT,
        rating TEXT,
        stock TEXT,
        brand TEXT,
        weight TEXT,
        thumbnail TEXT,
        cartCount INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insertProduct(Map<String, dynamic> product) async {
    Database db = await database;
    return await db.insert('CartProducts', product);
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    Database db = await database;
    return await db.query('CartProducts');
  }

  Future<int> updateProduct(int id, Map<String, dynamic> product) async {
    Database db = await database;
    return await db.update(
      'CartProducts',
      product,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteProduct(int id) async {
    Database db = await database;
    return await db.delete(
      'CartProducts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearCart() async {
    Database db = await database;
    await db.delete('CartProducts');
  }

  // Function to check if an item is in the cart
  Future<bool> isProductInCart(int productId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'CartProducts',
      where: 'id = ?',
      whereArgs: [productId],
    );
    return result.isNotEmpty;
  }

  // Function to increment cartCount by 1
  Future<void> incrementCartCount(int productId) async {
    Database db = await database;
    // Get the current cartCount for the product
    List<Map<String, dynamic>> result = await db.query(
      'CartProducts',
      columns: ['cartCount'],
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (result.isNotEmpty) {
      int currentCount = result.first['cartCount'] as int;
      int newCount = currentCount + 1;

      // Update the cartCount in the database
      await db.update(
        'CartProducts',
        {'cartCount': newCount},
        where: 'id = ?',
        whereArgs: [productId],
      );
    }
  }
}
