import 'package:geo_contacts/models/contact_model.dart';
import 'package:geo_contacts/models/register_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Db {
  static const String _Database_geo_contacts = 'database_geo_contacts';

  static final Db instance = Db.init();

  static Database? _database;

  Db.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('$_Database_geo_contacts');
    return _database!;

  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textTypeNotNull = 'TEXT NOT NULL';
    const textType = 'TEXT';
    const boolTypeNotNull = 'BOOLEAN NOT NULL';
    const boolType = 'BOOLEAN';
    const integerTypeNotNull = 'INTEGER NOT NULL';
    const integerType = 'INTEGER';
    const floatType = 'FLOAT';
    // const blobType = 'BLOB';

    ///Register user
    var queryRegister = '''
CREATE TABLE $tableRegister ( 
  ${RegisterFields.id} $idType, 
  ${RegisterFields.nome} $textType,
  ${RegisterFields.email} $textTypeNotNull,
  ${RegisterFields.senha} $textTypeNotNull
  )
''';
    await db.execute(queryRegister);

    ///Contacts
    var queryConstacts = '''
CREATE TABLE $tableContact (
  ${ContactModelFields.nome} $textType,
  ${ContactModelFields.cpf} $textType,
  ${ContactModelFields.telefone} $textType,
  ${ContactModelFields.uf} $textType,
  ${ContactModelFields.cidade} $textType,
  ${ContactModelFields.rua} $textType,
  ${ContactModelFields.numero} $textType,
  ${ContactModelFields.cep} $textType,
  ${ContactModelFields.usuarioCriador} $textType,
  ${ContactModelFields.latitude} $textType,
  ${ContactModelFields.longitude} $textType
  )
''';
    await db.execute(queryConstacts);

  }//_createDB
}