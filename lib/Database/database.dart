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
  static const colCompleted = 'completed';
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
  $colTitle $stringType,
  $colCompleted $intType
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
  Future<List<rModel>> facthNotes(bool completed) async {
    var db = await getDb();

    List<rModel> arrydata = [];
    var data;
    if (completed == false) {
      data = await db.query(dbTable);
    } else {
      data =
          await db.query(dbTable, where: '$colCompleted = ?', whereArgs: [1]);
    }

    for (Map<String, dynamic> eachData in data) {
      var rmModel = await rModel.fromMap(eachData);
      arrydata.add(rmModel);
    }
    return arrydata;
  }

  //delete task

  Future<void> delet(int id) async {
    var db = await getDb();
    db.delete(dbTable, where: "${colId} = ?", whereArgs: ['${id}']);
  }

// task update
  Future<void> update(rModel rmodels) async {
    var db = await getDb();
    db.update(dbTable, rmodels.toMap(),
        where: '${colId} = ?', whereArgs: ['${rmodels.modelId}']);
  }
  // completed update

  Future<void> completedUpdate(int id, int completed) async {
    // rModel rmodel = rModel(modelCompleted: modelCompleted, modelId: modelId, modelReTime: modelReTime, modelTitle: modelTitle);
    var db = await getDb();
    db.update(dbTable, {colCompleted: completed},
        where: "$colId = ?", whereArgs: ['$id']);
  }
}
