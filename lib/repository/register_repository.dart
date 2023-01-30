import 'package:geo_contacts/data/db.dart';
import 'package:geo_contacts/models/register_model.dart';

class RegisterRepository {
  static final Db _instance = Db.instance;

  Future<void> createOrUpdate(RegisterModel registerModel) async {
    final db = await _instance.database;
    // var allRegisters = await readAllRegister();
    // int idActual = registerModel.id!;
    // for(var aux in allRegisters){
    //   if(idActual == aux.id){//se existir na tabela faz update
    //     await db.update(tableRegister, registerModel.toJson());
    //     return;
    //   }
    // }
    await db.insert(tableRegister, registerModel.toJson());
    return;
  }

  Future<List<RegisterModel>> readAllRegister() async {
    final db = await _instance.database;
    List<Map<String, Object?>> result = [];
    result = await db.query(
      tableRegister,
      // where: '${RegisterFields.email} = ?',
      // whereArgs: [emailActualUser],
    );
    return result.map((json) => RegisterModel.fromJson(json)).toList();
  }
  Future<void> deleteAllRegister() async {
    final db = await _instance.database;
    db.delete(tableRegister);
  }
}