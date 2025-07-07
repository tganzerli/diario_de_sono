import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper();

  static Database? _database;

  String get tableName => 'sleep_log';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'sleep_diary.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Opens the database (creating it if it doesn't exist) and
  /// creates the `sleep_log` table.
  ///
  /// The table has the following columns:
  /// - `id`               INTEGER PRIMARY KEY AUTOINCREMENT
  /// - `date`             INTEGER               (MillisecondsSinceEpoch)
  /// - `bedtime`          TEXT                  (HH:MM)
  /// - `sleep_latency`    TEXT                  (HH:MM)
  /// - `sleep_duration`   TEXT                  (HH:MM)
  /// - `awakenings_count` INTEGER
  /// - `is_sent`          INTEGER DEFAULT 0     (0 = false, 1 = true)
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sleep_log(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date INTEGER NOT NULL,
        bedtime TEXT NOT NULL,
        sleep_latency TEXT NOT NULL,
        sleep_duration TEXT NOT NULL,
        awakenings_count INTEGER NOT NULL,
        is_sent INTEGER DEFAULT 0
      )
    ''');
  }
}
