import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:thiran_task/models/transaction_data.dart';

class DatabaseHelper {
  late Database _db;
  final String tableName = 'transactions';

  Future<void> initializeDatabase() async {
    _db = await openDatabase(join(await getDatabasesPath(), 'errotable.db'),
        onCreate: (db, version) {
      return db.execute(
        '''
          CREATE TABLE $tableName (
            transId INTEGER PRIMARY KEY,
            transDesc TEXT,
            transStatus TEXT,
            transDateTime TEXT
          )
          ''',
      );
    }, version: 1, singleInstance: true);
  }

  Future<void> closeDatabase() async {
    await _db.close();
  }

  Future<void> insertTransaction(TransactionData transaction) async {
    await _db.insert(
      tableName,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TransactionData>> getErrorTransactions() async {
    final List<Map<String, dynamic>> maps = await _db.query(
      tableName,
      where: 'transStatus = ?',
      whereArgs: ['Error'],
    );

    return List.generate(maps.length, (i) {
      return TransactionData(
        transId: maps[i]['transId'],
        transDesc: maps[i]['transDesc'],
        transStatus: maps[i]['transStatus'],
        transDateTime: maps[i]['transDateTime'],
      );
    });
  }
}

