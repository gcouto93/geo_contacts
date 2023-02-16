import 'package:flutter/cupertino.dart';
import 'package:geo_contacts/services/i_contact_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/contact_model.dart';
import '../repository/contact_repository.dart';
import 'auth_provider.dart';

class ContactProvider with ChangeNotifier implements IContactProvider {

  List<ContactModel> _listContact = [];
  List<ContactModel> get listContact => _listContact;
  var _markers= <Marker>{};
  get listMarks => _markers;

  Future<void> setListContact(BuildContext context,[bool listen = true]) async {
    // BuildContext context = MyAppS.navigatorKey.currentContext!;
    AuthProvider authProvider = Provider.of(context,listen: false);
    ContactModel contactModel = ContactModel(usuarioCriador: authProvider.emailUser);
    _listContact = await ContactRepository().readAllContactsFromUserCreator(contactModel);
    if(listen)notifyListeners();
  }

  addMarkerProv(ContactModel contactProv) {
    _markers.add(
        Marker(
            markerId: MarkerId(contactProv.nome!),
            position: LatLng(double.parse(contactProv.latitude!), double.parse(contactProv.longitude!)),
            infoWindow: InfoWindow(
              title: '${contactProv.nome} - ${contactProv.uf} - ${contactProv.cidade}, ${contactProv.rua}, N.:${contactProv.numero}',
            )
        )
    );
    notifyListeners();
  }
  deleteMarkerProv(ContactModel contactDelet) {
    // _markers= <Marker>{};
    try{

      Marker mark = _markers.firstWhere((element) => element.markerId.value == contactDelet.nome);//identifica a marcação p/ excluir
      _markers.remove(mark);
      notifyListeners();
    }catch(e){

    }
  }

}