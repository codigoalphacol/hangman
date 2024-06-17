import 'package:hangman/core/data/models/hangman_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class GameRepository {
  static final GameRepository instance = GameRepository._init();
  static sql.Database? _database;

  GameRepository._init();

  Future<sql.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dbhangmanx.db');
    return _database!;
  }

  Future<sql.Database> _initDB(String filePath) async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath, filePath);

    return await sql.openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(sql.Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';    

    await db.execute('''
      CREATE TABLE tbwords ( 
        id $idType, 
        vocabulary $textType       
      )
    ''');
  }

  Future<void> create(HangmanModel game) async {
    final db = await instance.database;
    await db.insert('tbwords', game.toMap());
  }

  Future<HangmanModel?> read(String id) async {
    final db = await instance.database;
    final maps = await db.query(
      'tbwords',
      columns: ['id', 'vocabulary'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return HangmanModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<HangmanModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query('tbwords');

    return result.map((json) => HangmanModel.fromMap(json)).toList();
  }

  Future<int> update(HangmanModel game) async {
    final db = await instance.database;

    return db.update(
      'tbwords',
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;

    return db.delete(
      'tbwords',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getWordColumn() async {
    final db = await GameRepository.instance.database;
    return db.query('tbwords', columns: ['vocabulary'], orderBy: "id");
  }

  Future<String?> getWordRandom() async {
    final allWords = await getAllWords();
    if (allWords.isEmpty) {      
      return 'HOLA';
    }
    allWords.shuffle();
    return allWords.first;
  }
 
  Future<List<String>> getAllWords() async {    
    final List<HangmanModel> games = await readAll();
    final List<String> allWords = games.map((game) => game.vocabulary).toList();
    return allWords;
  }
}
