import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remainder_app/Database/taskModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
//variables

  static const dbName = 'remainderDB.db';
  static const dbVersion = 1;
  static const dbTable = 'remainderTable';

  static const colId = 'id';
  static const colRmTime = 'Rtime';
  static const colTitle = 'title';
// custructure
  DatabaseHelper._();
  static DatabaseHelper instance = DatabaseHelper._();

//get Database
  Database? db;
  Future<Database> getDb() async {
    db ??= await inilDb();
    return db!;
  }

//initialize Database
  Future<Database> inilDb() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var path = join(docDirectory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _oncreate);
  }

  _oncreate(Database db, int version) {
    var autoincrimentType = 'integer primary key autoincrement not null ';
    var stringType = 'text not null';
    var intType = "integer not null";
    db.execute('''
CREATE TABLE $dbTable(
  $colId $autoincrimentType,
  $colRmTime $intType,
  $colTitle $stringType
)
''');
  }
//Crud

//Create

  void createNote(rModel rmodel) async {
    var db = await getDb();
    db.insert(dbTable, rmodel.toMap());
  }

// facth task
  Future<List<rModel>> facthNotes() async {
    var db = await getDb();

    List<rModel> arrydata = [];
    var data = await db.query(dbTable);

    for (Map<String, dynamic> eachData in data) {
      var rmModel = rModel.fromMap(eachData);
      arrydata.add(rmModel);
    }
    return arrydata;
  }

  //delete task

  Future<void> delet(int id) async {
    var db = await getDb();
    db.delete(dbTable, where: "${colId} = ?", whereArgs: ['${id}']);
  }

  Future<void> update(rModel rmodels) async {
    var db = await getDb();
    db.update(dbTable, rmodels.toMap(),
        where: '${colId} = ?', whereArgs: ['${rmodels.modelId}']);
  }
}
