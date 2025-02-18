import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'planeta.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'planetas.db';
  static const String _tableName = 'planetas';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, _dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        distancia_sol REAL,
        tamanho REAL,
        apelido TEXT
      )
    ''');
  }

  Future<int> insertPlaneta(Planeta planeta) async {
    final db = await database;
    return await db.insert(_tableName, planeta.toMap());
  }

  Future<List<Planeta>> getPlanetas() async {
    final db = await database;
    final result = await db.query(_tableName);
    return result.map((map) => Planeta.fromMap(map)).toList();
  }

  Future<int> updatePlaneta(Planeta planeta) async {
    final db = await database;
    return await db.update(
      _tableName,
      planeta.toMap(),
      where: 'id = ?',
      whereArgs: [planeta.id],
    );
  }

  Future<int> deletePlaneta(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
