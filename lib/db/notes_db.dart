import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // const boolType = 'BOOLEAN NOT NULL';
    // const textType = 'TEXT NOT NULL';
    // const intType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNotes(
    ${NoteTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${NoteTable.isImportant} BOOLEAN NOT NULL,
    ${NoteTable.number} INTEGER  NOT NULL,
    ${NoteTable.title} TEXT NOT NULL,
    ${NoteTable.description} TEXT NOT NULL,
    ${NoteTable.time} TEXT NOT NULL)
    ''');
  }

  Future<MyNote> create(MyNote note) async {
    final db = await instance.database;
    final id = await db.insert(tableNotes, note.toJson());
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
