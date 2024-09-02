import 'package:bytebrain_project_akhir/core/notes/model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DBHelper {
  static Database? _db; // Menyimpan instance database
  static const _databaseName = 'Todo.db'; // Nama file database

  // Getter untuk mendapatkan instance database, jika belum diinisialisasi, panggil initDatabase
  Future<Database?> get db async {
    if (_db != null) {
      return _db; // Mengembalikan instance database yang telah diinisialisasi
    }
    _db = await initDatabase();
    return null;
  }

  // Inisialisasi database dan buat tabel jika belum ada
  Future<Database?> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    debugPrint(
        'db location :${documentDirectory.path}'); // Menampilkan lokasi database
    String path =
        join(documentDirectory.path, _databaseName); // Menentukan path database
    var db = await openDatabase(path,
        version: 1, onCreate: _createDatabase); // Membuka database
    return db;
  }

  // Fungsi untuk membuat tabel di database
  void _createDatabase(Database db, int version) async {
    await db.execute(
      "CREATE TABLE mytodo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, dateandtime TEXT NOT NULL)",
    );
  }

  // Menyisipkan data todo baru ke dalam tabel
  Future<TodoModel> insert(TodoModel todoModel) async {
    var dbClient = await db;
    await dbClient?.insert('mytodo', todoModel.toMap());
    return todoModel;
  }

  // Mengambil semua data todo dari tabel
  Future<List<TodoModel>> getDataList() async {
    await db;
    // ignore: non_constant_identifier_names
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM mytodo');
    return QueryResult.map((e) => TodoModel.fromMap(e)).toList();
  }

  // Menghapus data todo berdasarkan ID
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('mytodo', where: 'id = ?', whereArgs: [id]);
  }

  // Memperbarui data todo berdasarkan model yang diberikan
  Future<int> update(TodoModel todoModel) async {
    var dbClient = await db;
    return await dbClient!.update('mytodo', todoModel.toMap(),
        where: 'id = ?', whereArgs: [todoModel.id]);
  }
}
