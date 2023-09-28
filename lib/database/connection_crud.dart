import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'script.dart';

class Connection {
  static Database? _db;
  static Future<Database?> get() async {
    if (_db == null) {
      var path = join(await getDatabasesPath(), 'vendas');
      //deleteDatabase(path);
      _db = await openDatabase(path, version: 2, onCreate: (db, v) {
        db.execute(createTable2);
        db.execute(insertCli);
      });
    }

    return _db;
  }
}
