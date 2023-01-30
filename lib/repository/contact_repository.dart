import 'package:geo_contacts/models/contact_model.dart';
import 'package:geo_contacts/providers/contact_provider.dart';

import '../data/db.dart';

class ContactRepository {
  static final Db _instance = Db.instance;

  Future<void> createContact(ContactModel contactModel) async {
    final db = await _instance.database;
    db.insert(tableContact, contactModel.toJson());
  }
  Future<void> updateContact(ContactModel contactModel) async {
    final db = await _instance.database;
    db.update(
      tableContact,
      contactModel.toJson(),
        where: '${ContactModelFields.nome} = ? AND ${ContactModelFields.cpf} = ?',
        whereArgs: [contactModel.nome, contactModel.cpf],

    );
  }

  Future<List<ContactModel>> readAllContactsFromUserCreator(ContactModel contactModel) async {
    final db = await _instance.database;
    List<Map<String, Object?>> result = [];
    result = await db.query(
      tableContact,
      where: '${ContactModelFields.usuarioCriador} = ?',
      whereArgs: [contactModel.usuarioCriador],
    );
    return result.map((json) => ContactModel.fromJson(json)).toList();
  }
  Future<void> delete(String nome)async{
    final db = await _instance.database;
    await db.delete(
      tableContact,
      where: '${ContactModelFields.nome} = ?',
      whereArgs: [nome]
    );
  }
  Future<void> deleteAllContacts()async{
    final db = await _instance.database;
    await db.delete(
      tableContact,
    );
  }


}