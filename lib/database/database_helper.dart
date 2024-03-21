import 'dart:convert';
import 'dart:developer';

import '../database/tbl_procession.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 20; // Last deployed 19

  final String table;

  static const columnId = '_id';
  static const columnName = 'name';
  static const columnAge = 'age';

  DatabaseHelper({required this.table});

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _loopCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    tblFunc(db);
  }

  Future<bool> tableExists(Database db, String table) async {
    List exist =
        await db.query('sqlite_master', where: 'name = ?', whereArgs: [table]);
    if (exist.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future tblFunc(Database db) async {
    explicit().forEach((key, value) async {
      try {
        if (await tableExists(db, key) == false) {
          await db.execute('''
          CREATE TABLE $key ( $value )''');
          log("table created$key");
        } else {
          log("table $key exists already");
        }
      } catch (e) {
        log("tbl create error:$e.toString()");
      }
    });

    procession().forEach(
      (key, value) async {
        try {
          String crtt = "";
          for (int i = 0; i < value.length; i++) {
            crtt += "${value[i]} TEXT NOT NULL";
            if (i < value.length - 1) {
              crtt += ",";
            }
          }
          if (await tableExists(db, key) == false) {
            await db.execute('''
          CREATE TABLE $key ( $crtt )''');
            log("table created$key");
          } else {
            log("table $key exists already");
          }
        } catch (e) {
          log("tbl create error:${e.toString()}");
        }
      },
    );
  }

  Future _loopCreate(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      tblFunc(db);
    }
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insertData(Map<String, dynamic> row) async {
    try {
      await init();

      log("data entry into $table in progress");
      return await _db.insert(table, row);
    } catch (e) {
      log("Entry error $e");
      return 0;
    }
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    await init();
    return await _db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    await init();
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<bool> rowExists(Map<String, dynamic> fields) async {
    await init();

    Map<String, dynamic> whr = whereClause(fields);
    List jjk = await _db.query(table,
        where: whr["constraint"], whereArgs: whr["entries"]);
    if (jjk.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row, String key, String value) async {
    return await _db.update(
      table,
      row,
      where: '$key = ?',
      whereArgs: [value],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(Map<String, dynamic> fields) async {
    await init();
    Map<String, dynamic> whr = whereClause(fields);
    return await _db.delete(
      table,
      where: whr["constraint"],
      whereArgs: whr["entries"],
    );
  }

  Map<String, dynamic> whereClause(Map<String, dynamic> fields) {
    String keys = "";
    List values = [];
    int p = 0;
    int c = fields.length;
    fields.forEach((key, value) {
      keys += "$key = ? ";
      if (c > p + 1) {
        keys += " AND ";
        p++;
        values.add(value);
      } else {
        values.add(value);
      }
    });
    Map<String, dynamic> whr = {"constraint": keys, "entries": values};
    log(jsonEncode(whr));

    return whr;
  }

  /*
  public Pair<String, String[]> whereClause(Map<String, Object> fields)
    {
        int p =0;
        int c =fields.size();
        StringBuilder sbb= new StringBuilder();
        ArrayList<String> vls = new ArrayList<>();

        for (Map.Entry<String,Object> fl:fields.entrySet())
        {
            sbb.append(fl.getKey()).append(" = ?");
            if(c>p+1)
            {
                sbb.append(" AND ");
            }
            p++;
            vls.add(fl.getValue().toString());
        }

        String[] values  = GetStringArray(vls);
        Log.e("Param",sbb.toString()+"***"+values.length);

        return new Pair<>(sbb.toString(),values);
    }
  */
}
