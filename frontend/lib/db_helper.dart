import 'dart:io'; 
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    _database = await _initDB('xrbone.db'); 
    return _database!;
  }

Future<Database> _initDB(String filePath) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, filePath);

  print('DB PATH => $path'); // optional, just to see actual path

  return await openDatabase(
    path,
    version: 2, // 🔺 change from 1 to 2
    onCreate: _createDB,
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute(
          'ALTER TABLE requests ADD COLUMN result_summary TEXT;'
        );
        await db.execute(
          'ALTER TABLE requests ADD COLUMN annotated_image_b64 TEXT;'
        );
      }
    },
  );
}

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL,
      password TEXT NOT NULL,
      email TEXT NOT NULL,
      phone TEXT NOT NULL,
      profile_pic_index INTEGER NOT NULL
    )
    ''');
    
await db.execute('''
  CREATE TABLE requests (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_name TEXT NOT NULL,
    body_part TEXT NOT NULL,
    date TEXT NOT NULL,
    status TEXT NOT NULL,
    result_summary TEXT,
    annotated_image_b64 TEXT
  )
''');
  }

  // --- User Management ---
  Future<int> registerUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    
    if (result.isNotEmpty) {
      return result.first; 
    }
    return null;
  }
  
  // --- Request History Management ---
  Future<int> insertRequest(Map<String, dynamic> request) async {
    final db = await instance.database;
    return await db.insert('requests', request);
  }

  Future<List<Map<String, dynamic>>> fetchRequests() async {
    final db = await instance.database;
    return await db.query('requests', orderBy: 'id DESC'); 
  }
}