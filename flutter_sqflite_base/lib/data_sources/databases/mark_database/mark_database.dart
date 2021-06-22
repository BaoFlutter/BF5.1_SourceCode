
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_sqflite_base/data_sources/databases/mark_database/mark_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MarkDatabase{
  final String DB_NAME ="mark_database.db";
  final String TABLE ="mark_table";
  final String ID ="id";
  final String USER_NAME ="user_name";
  final String MATH_MARK ="math_mark";
  final String LITETURE_MARK ="liteture_mark";
  final String ENGLISH_MARK ="english_mark";

  static final MarkDatabase _instance = MarkDatabase._();
  static Database _database;

  MarkDatabase._();

  factory MarkDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  // Database isn't available
  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, DB_NAME);

    var database = openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }
  // Database from Asset
 /*
  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, DB_NAME);
// Check if the database exists
    var exists = await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/databases", DB_NAME));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    var db = await openDatabase(path, readOnly: true);
    return db;
  }

  */


  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $TABLE(
        $ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $USER_NAME TEXT,
        $MATH_MARK REAL,
        $LITETURE_MARK REAL,
        $ENGLISH_MARK REAL)       
    ''');
    print("Mark Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }
  // Add Row
  Future<int> addMark(MarkModel mark) async {
    var client = await db;
    print("Adding...");
    return client.insert(TABLE, mark.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<MarkModel> fetchMark(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query(TABLE, where: '$ID = ?', whereArgs: [id]);

    var maps = await futureMaps;
    if (maps.length != 0) {
      return MarkModel.fromJson(maps.first);
    }
    return null;
  }

  Future<MarkModel> fetchMarkByWord(String username) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query(TABLE, where: '$USER_NAME = ?', whereArgs: [username]);

    var maps = await futureMaps;
    if (maps.length != 0) {
      return MarkModel.fromJson(maps.first);
    }
    return null;
  }

  Future<List<MarkModel>> fetchAll() async {
    var client = await db;
    var res = await client.query(TABLE);

    if (res.isNotEmpty) {
      var marks = res.map((markMap) => MarkModel.fromJson(markMap)).toList();
      return marks;
    }
    return [];
  }

  deleteAll() async {
    List<MarkModel> list = await fetchAll();
    for(int i = 0; i< list.length ; i++)
    {
      await removeMark(list[i].id);
    }

  }

  Future<void> removeMark(int id) async {
    var client = await db;
    client.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }





























}