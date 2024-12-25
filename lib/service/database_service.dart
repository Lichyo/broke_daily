import 'package:account/constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:account/model/event_detail_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('account.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE events (
        id $idType,
        title $textType,
        amount $doubleType,
        date $textType,
        type $textType
      )
    ''');
  }

  Future<void> insert({required EventDetailModel eventDetailModel}) async {
    final db = await instance.database;
    int id = await db.insert(
      'events',
      eventDetailModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted id: $id");
  }

  Future<void> delete({required int id}) async {
    final db = await instance.database;
    await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<EventDetailModel>> getEvents() async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT * FROM events");
    List<EventDetailModel> events = [];
    for (var item in result) {
      events.add(
        EventDetailModel(
          type: AccountingTypesExtension.fromString(item['type'] as String),
          title: item['title'] as String,
          amount: item['amount'] as double,
          date: DateTime.parse(item['date'] as String),
          id: item['id'] as int,
        ),
      );
    }
    return events;
  }

  Future<void> reset() async {
    final db = await instance.database;
    await db.delete('events');
  }
}
