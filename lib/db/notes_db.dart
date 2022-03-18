import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('notes.db');
    return _database;
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

    // final json = note.toJson();
    // const columns = '${NoteTable.title}, ${NoteTable.description}, ${NoteTable.time}';
    // final values = '${json[NoteTable.title]}, ${json[NoteTable.description]}, ${json[NoteTable.time]}';
    // final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db?.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<MyNote> readNote(int id) async {
    final db = await instance.database;

    final maps = await db?.query(
      tableNotes,
      columns: NoteTable.values,
      where: '${NoteTable.id} = ?',
      whereArgs: [id],
    );
    if (maps!.isNotEmpty) {
      return MyNote.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<MyNote>> readAllNotes() async {
    final db = await instance.database;
    const orderBy = '${NoteTable.time} ASC';
    // final result = await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db?.query(tableNotes, orderBy: orderBy);
    return result!.map((json) => MyNote.fromJson(json)).toList();
  }

  Future<int> update(MyNote note) async {
    final db = await instance.database;

    return db!.update(tableNotes, note.toJson(), where: '${NoteTable.id} = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db!.delete(tableNotes, where: '${NoteTable.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db?.close();
  }
}
