import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geo_contacts/defaults/adaptive_text_field.dart';
import 'package:geo_contacts/models/response_consulta_cep.dart';
import 'package:geo_contacts/pages/drawer/drawer_page.dart';
import 'package:geo_contacts/utility/app_routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../models/contact_model.dart';
import '../providers/contact_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txtCep = TextEditingController();
  TextEditingController txtRua = TextEditingController();
  TextEditingController txtUf = TextEditingController();
  TextEditingController txtCidade = TextEditingController();
  List<ResponseConsultaCep> listResponse = [];

  String? emailUser = '';



  @override
  Widget build(BuildContext context) {


    Provider.of<ContactProvider>(context).setListContact(context);
    try{
      final args = ModalRoute.of(context)!.settings.arguments;
      if(args != null){
        emailUser = args as String;
      }
    }catch(e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Scaffold(
      appBar: AppBar(

      ),
      body:Consumer<ContactProvider>(builder: (context, prov, child) {
        return GoogleMap(
            markers: prov.listMarks,
            initialCameraPosition: CameraPosition(
              target: LatLng(-25.5364929,-49.2441089),
              zoom: 5,

            )
        );
      }) ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushNamed(AppRoutes.CreateContact);
          }),
      drawer: DrawerScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  _showAlertHome(String textAlert,{Color color = Colors.redAccent}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(textAlert),
        backgroundColor: color,
      ),
    );
  }
}
