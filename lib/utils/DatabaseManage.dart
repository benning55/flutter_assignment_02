import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Note.dart';
import 'dart:async';

final String noteTable = 'note_table';
final String colId = 'id';
final String colTitle = 'title';
final String colFinish = 'finish';

class DatabaseManage {
  static final DatabaseManage _instance = new DatabaseManage.internal();
  factory DatabaseManage() => _instance;
  static Database _db;
  DatabaseManage.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colFinish TEXT)');
  }

  Future<int> saveNewNote(Note note) async {
    var dbClient = await db;
    var result = await dbClient.insert(noteTable, note.toMap());
    return result;
  }

  Future<List> getAllNote() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(noteTable,
        columns: [colId, colTitle, colFinish],
        where: '$colFinish = ?',
        whereArgs: [0]);
    return result;
  }

  Future<List> getAllFinish() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(noteTable,
        columns: [colId, colTitle, colFinish],
        where: '$colFinish = ?',
        whereArgs: [1]);
    return result;
  }

  Future<int> deleteAllDone() async {
    var dbClient = await db;
    return await dbClient
        .delete(noteTable, where: '$colFinish = ?', whereArgs: [1]);
  }

  Future<int> updateNote(Note note) async {
    var dbClient = await db;
    return await dbClient.update(noteTable, note.toMap(),
        where: "$colId = ?", whereArgs: [note.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
