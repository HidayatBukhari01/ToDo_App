import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/model/notes_model.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDB();
    return _db;
  }

  _initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      final documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'notes.db');
      var db = openDatabase(path, version: 1, onCreate: _onCreate);
      return db;
    } catch (e) {
      print(e);
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, age INTEGER NOT NULL, description TEXT NOT NULL, email TEXT)",
    );
  }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = _db;
    await dbClient!.insert('notes', notesModel.toMap());
    return notesModel;
  }

  Future<List<NotesModel>> getTodoList() async {
    var dbClient = _db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('notes');
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }
}
