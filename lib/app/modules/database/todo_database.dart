import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_sqflite/app/modules/database/todo_fields.dart';
import 'package:todo_sqflite/app/modules/models/todo.dart';

class TodoDatabase {
  static TodoDatabase instance = TodoDatabase._init();

  TodoDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    var dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const strType = 'TEXT NOT NULL';
    const strTypeNullable = 'TEXT';
    const intType = 'INTEGER NOT NULL';
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    await db.execute('''
      CREATE TABLE $tableOfTodo (
        ${TodoFields.id} $idType,
        ${TodoFields.title} $strType,
        ${TodoFields.description} $strType,
        ${TodoFields.createdAt} $strType,
        ${TodoFields.updatedAt} $strTypeNullable,
        ${TodoFields.isComplete} $intType
      )
    ''');
  }

  Future<List<Todo>> getTodos() async {
    final db = await instance.database;
    final listMap = await db.query(tableOfTodo,
        columns: TodoFields.values, orderBy: '${TodoFields.createdAt} DESC');
    return listMap.map((map) => Todo.fromMap(map)).toList();
  }

  Future<Todo> getTodo(int id) async {
    final db = await instance.database;
    final listOfMap = await db.query(
      tableOfTodo,
      columns: TodoFields.values,
      where: '${TodoFields.id}=?',
      whereArgs: [id],
    );
    return Todo.fromMap(listOfMap.first);
  }

  Future<Todo> createTodo(Todo todo) async {
    final db = await instance.database;
    final newTodoId = await db.insert(tableOfTodo, todo.toMap());
    return todo.copy(id: newTodoId);
  }

  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return db.delete(
      tableOfTodo,
      where: '${TodoFields.id}=?',
      whereArgs: [id],
    );
  }

  Future<Todo> updateTodo(Todo todo, int id) async {
    final db = await instance.database;
    await db.update(
      tableOfTodo,
      todo.toMap(),
      where: '${TodoFields.id}=?',
      whereArgs: [id],
    );
    return await getTodo(id);
  }
}
