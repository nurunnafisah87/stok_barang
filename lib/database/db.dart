import 'package:flutter_crud_uts_lagi/model/stok.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'tableStok';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnWarna = 'warna';
  final String columnUkuran = 'ukuran';
  final String columnHarga = 'harga';
  final String columnJumlah = 'jumlah';
  DbHelper._internal();
  factory DbHelper() => _instance;

  //cek database
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'stok.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnWarna TEXT,"
        "$columnUkuran TEXT,"
        "$columnHarga TEXT,"
        "$columnJumlah TEXT)";
    await db.execute(sql);
  }

  Future<int?> saveStok(Stok stok) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, stok.toMap());
  }

  Future<List?> getAllStok() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnHarga,
      columnJumlah,
      columnWarna,
      columnUkuran
    ]);

    return result.toList();
  }

  Future<int?> updateStok(Stok stok) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, stok.toMap(),
        where: '$columnId = ?', whereArgs: [stok.id]);
  }

  Future<int?> deleteStok(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
