import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Singleton
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  final int _version = 1;

  /// Get database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    return openDatabase(
      'database_example.db',
      version: _version,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT)',
        );
        db.execute(
          'CREATE TABLE posts (id INTEGER PRIMARY KEY, title TEXT, body TEXT, userId INTEGER, FOREIGN KEY(userId) REFERENCES users(id))',
        );
      },
      onConfigure: (db) => {},
      // Update database
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1 && newVersion == 2) {
          db.execute(
            'ALTER TABLE posts ADD COLUMN image TEXT',
          );
        }
      },
      onDowngrade: (db, oldVersion, newVersion) => {},
      onOpen: (db) => {},
    );
  }
}
