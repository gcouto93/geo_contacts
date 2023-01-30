import 'package:flutter/cupertino.dart';
import 'package:geo_contacts/services/i_contact_provider.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/contact_model.dart';
import '../repository/contact_repository.dart';
import 'auth_provider.dart';

class ContactProvider with ChangeNotifier implements IContactProvider {

  List<ContactModel> _listContact = [];
  List<ContactModel> get listContact => _listContact;

  Future<void> setListContact(BuildContext context,[bool listen = true]) async {
    // BuildContext context = MyAppS.navigatorKey.currentContext!;
    AuthProvider authProvider = Provider.of(context,listen: false);
    ContactModel contactModel = ContactModel(usuarioCriador: authProvider.emailUser);
    _listContact = await ContactRepository().readAllContactsFromUserCreator(contactModel);
    if(listen)notifyListeners();
  }

}