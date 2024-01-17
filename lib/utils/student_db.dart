import 'package:tb2_courseremainder/model/siswa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'student_db.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<int> insertStudent(Student newStudent) async {
    Database db = await database;
    return await db.insert('student', newStudent.toMap());
  }

  Future<int> updateStudent(Student updatedStudent) async {
    Database db = await database;
    return await db.update(
      'student',
      updatedStudent.toMap(),
      where: 'id = ?',
      whereArgs: [updatedStudent.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    Database db = await database;
    return await db.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllStudents() async {
    Database db = await database;
    await db.delete('student');
  }

  Future<List<Student>> getStudents() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('student');
    return List.generate(maps.length, (i) {
      return Student(
        id: maps[i]['id'],
        name: maps[i]['name'],
        nim: maps[i]['nim'],
        phone: maps[i]['phone'],
        email: maps[i]['email'],
      );
    });
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE student (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        nim TEXT NOT NULL UNIQUE,
        phone TEXT,
        email TEXT
      )
    ''');
  }

}
