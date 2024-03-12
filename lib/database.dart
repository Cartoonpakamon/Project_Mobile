import 'package:login/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class appDatabase {
  static Database? _database; // ประกาศตัวแปรว่ามีชนิดข้อมูลเป็นData base ต้องimport sqflite มาก่อน
  final String tableName = 'topic';

  Future<Database> initializedb () async{
    if(_database == null) _database = await createdb ();
    return _database!;// ! ? ใช้ในเมื่อกรณีที่ต้องการให้เป็นค่าว่าง
  }
  Future<Database> createdb() async {
    final path = await getDatabasesPath();

    var database =await openDatabase(
    join(path, 'topicDB.db'),
     version:  1, 
     onCreate: (db, version) async{
       await db.execute(
         '''CREATE TABLE $tableName(
           id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
           title TEXT,
           conversation TEXT)''',//''' สามตัวคือใส่ข้อมูลอะไรก็ได้่
       );
     }, 
     );
     return database;
  }

  Future insertData(topicModel model) async{
    var db = await initializedb();
    var result = await db.insert(tableName, model.toMap());
    return result;
  }
  Future updataData(topicModel model) async{
  var db = await initializedb();
  var result = await db.update(
    tableName,
    model.toMap(),
    where: 'id = ?',
    whereArgs: [model.id],
  );
  return result;
}
  Future<List<topicModel>> getAllData() async{
    var db = await initializedb();
    List<Map<String,dynamic>> result = await db.query(tableName);
    return List.generate(
      result.length,
      (index) => topicModel(
        id: result[index]['id'],
        title: result[index]['title'],
        conversation:result[index] ['conversation']
        ),
        );
  }
  Future deleteData(topicModel model) async {
    var db = await initializedb();
    var result = db.delete(
      'topic',
      where: 'id=?',
      whereArgs: [model.id],
    );
    return result;
  }
}
