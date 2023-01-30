import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geo_contacts/defaults/adaptive_text_field.dart';
import 'package:geo_contacts/models/contact_model.dart';
import 'package:geo_contacts/models/response_consulta_cep.dart';
import 'package:geo_contacts/providers/contact_provider.dart';
import 'package:geo_contacts/repository/contact_repository.dart';
import 'package:geo_contacts/utility/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../providers/auth_provider.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({Key? key}) : super(key: key);

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtCpf = TextEditingController();
  TextEditingController txtTelefone = TextEditingController();
  TextEditingController txtUf = TextEditingController();
  TextEditingController txtCidade = TextEditingController();
  TextEditingController txtNumero = TextEditingController();
  TextEditingController txtRua = TextEditingController();
  TextEditingController txtCep = TextEditingController();


  String _emailUserCreateContact = '';

  ContactModel? contactUpdate;
  bool update = false;


  List<ResponseConsultaCep> listResponse = [];

  consultarEndereco() async {
    try{
      if( txtUf.text.length > 1 && txtCidade.text.length > 3 && txtRua.text.length > 3 ) {
        var ufAux = txtUf.text;
        var cidadeAux = txtCidade.text;
        var ruaAux = txtRua.text;
        String  url = "https://viacep.com.br/ws/$ufAux/$cidadeAux/$ruaAux/json/";

        http.Response response;

        response = await http.get(Uri.parse(url));

        if(response.statusCode == 200){

          var data = jsonDecode(response.body.toString());

          setState(() {
            listResponse = List.from(data).map((e) => ResponseConsultaCep.fromJson(e)).toList() ;
          });
        }else{
          _showAlertCreateContact('Erro status: ${response.statusCode}');
          return;
        }
        if (kDebugMode) {
          print(jsonDecode(response.body));
        }
      }else{
        _showAlertCreateContact('Preencha os campos de endereço corretamente!');
        return;
      }
    }catch (e) {
      _showAlertCreateContact(e.toString());
    }


  }

  consultaCep() async {
    if(txtCep.text.length < 8 && txtCep.text.isEmpty){
      _showAlertCreateContact('Insira 8 dígitos para um CEP válido!');
      return;
    }
    try{
      String cep = txtCep.text;
      String url = "https://viacep.com.br/ws/${cep}/json/";


      http.Response response;

      response = await http.get(Uri.parse(url));

      if(response.statusCode == 200){
        var retornoPesquisaCep = ResponseConsultaCep.fromJson(jsonDecode(response.body));
        setState(() {
          txtRua.text = retornoPesquisaCep.logradouro!;
          txtUf.text = retornoPesquisaCep.uf!;
          txtCidade.text = retornoPesquisaCep.localidade!;
        });
      }else{
        _showAlertCreateContact('Erro ao consultar. '+response.statusCode.toString());
      }
    }catch (e) {
      _showAlertCreateContact(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {

    try{
      final args = ModalRoute.of(context)!.settings.arguments;
      if(args != null){
        contactUpdate = args as ContactModel;
        setState(() {
          txtNome.text = contactUpdate!.nome!;
          txtCpf.text = contactUpdate!.cpf!;
          txtTelefone.text = contactUpdate!.telefone!;
          txtUf.text = contactUpdate!.uf!;
          txtCidade.text = contactUpdate!.cidade!;
          txtRua.text = contactUpdate!.rua!;
          txtNumero.text = contactUpdate!.numero!;
          txtCep.text = contactUpdate!.cep!;
          update = true;
        });
      }
    }catch(e) {
      if (kDebugMode) {
        print(e);
      }
    }

    AuthProvider authProvider = Provider.of(context,listen: false);
    _emailUserCreateContact = authProvider.emailUser!;
    return Scaffold(
      appBar: AppBar(
        title: update ? Text('Editar contato'): Text('Novo contato'),
        actions: [
          TextButton(
              onPressed: createButton,
              child:
              update
                  ?
              const Text('Salvar',style: TextStyle(color: Colors.white))
                  :
              const Text('Criar',style: TextStyle(color: Colors.white),)
          ),
        ],

      ),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              AdaptiveTextField(
                obscureText: false,
                label: 'Nome*',
                controller: txtNome,
              ),
              AdaptiveTextField(
                obscureText: false,
                label: 'CPF*',
                controller: txtCpf,
                keyboardType: TextInputType.number,
              ),
              AdaptiveTextField(
                obscureText: false,
                label: 'Telefone*',
                controller: txtTelefone,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20,),
              Text('Caso não saiba o CEP informe: Estado, Cidade e Rua abaixo:'),
              SizedBox(height: 15,),
              AdaptiveTextField(
                obscureText: false,
                label: 'UF*',
                controller: txtUf,
              ),
              AdaptiveTextField(
                obscureText: false,
                label: 'Cidade* (Min. 3 letras)',
                controller: txtCidade,
              ),
              AdaptiveTextField(
                obscureText: false,
                label: 'Rua* (Min. 3 letras)',
                controller: txtRua,
              ),
               AdaptiveTextField(
                obscureText: false,
                label: 'Nº',
                keyboardType: TextInputType.number,
                controller: txtNumero,
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed:consultarEndereco,
                child: const Text('Consultar por endereço'),
              ),
              AdaptiveTextField(
                keyboardType: TextInputType.number,
                obscureText: false,
                label: 'CEP',
                controller: txtCep,
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed:consultaCep,
                child: const Text('Consultar CEP'),
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        selectItem(listResponse[index]);
                      },
                      title: Text(listResponse[index].logradouro!),
                      // trailing: Text(listResponse[index].uf!),
                      subtitle: Text("${listResponse[index].localidade!}, ${listResponse[index].bairro!} - ${listResponse[index].uf!}"),
                    );
                  },
                  itemCount: listResponse.length,

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  _showAlertCreateContact(String textAlert,{Color color = Colors.redAccent}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(textAlert),
        backgroundColor: color,
      ),
    );
  }
  selectItem(ResponseConsultaCep item) {
    setState(() {
      txtCep.text = item.cep!;
      txtCidade.text = item.localidade!;
      txtRua.text = item.logradouro!;
      txtUf.text = item.uf!;
      listResponse = [];
    });
  }
  createButton() async {
    if(txtNome.text.isEmpty){//valida campos
      _showAlertCreateContact('Preencher nome');
    }else if (txtCpf.text.isEmpty || txtCpf.text.length < 11){
      _showAlertCreateContact('CPF deve conter 11 dígitos!');
    }else if(txtCpf.text.length > 11){
      _showAlertCreateContact('CPF não pode conter mais de 11 dígitos!');
    }else if (txtTelefone.text.isEmpty){
      _showAlertCreateContact('Preencher Telefone');
    }else if (txtUf.text.isEmpty) {
      _showAlertCreateContact('Preencher Estado(UF)');
    }else if (txtCidade.text.isEmpty) {
      _showAlertCreateContact('Preencher Cidade!');
    }else if (txtRua.text.isEmpty) {
      _showAlertCreateContact('Preencher Rua');
    }else if (txtNumero.text.isEmpty) {
      _showAlertCreateContact('Preencher numero do local');
    }else if (txtCep.text.isEmpty) {
      _showAlertCreateContact('Preencher CEP');
    }else{//todos preenchidos
      ContactModel contactModel = ContactModel(
        nome: txtNome.text,
        cpf: txtCpf.text,
        telefone: txtTelefone.text,
        uf: txtUf.text,
        cidade: txtCidade.text,
        rua: txtRua.text,
        numero: txtNumero.text,
        cep: txtCep.text,
        usuarioCriador: _emailUserCreateContact,
        latitude: '0',
        longitude: '0'
      );
      if(update){
        await ContactRepository().updateContact(contactModel);
        Navigator.of(context).pushNamed(AppRoutes.Home);
        return;
      }
      var listaContatosExistentes = await ContactRepository().readAllContactsFromUserCreator(contactModel);
      if(listaContatosExistentes.isEmpty){
        ContactRepository().createContact(contactModel);
        Navigator.of(context).pushNamed(AppRoutes.Home);
      }
      for(var itemAuxContact in listaContatosExistentes) {
        if(itemAuxContact.nome == txtNome.text){
          _showAlertCreateContact('Esse nome já está cadastrado!');
          return;
        }else if (itemAuxContact.cpf == txtCpf.text) {
          _showAlertCreateContact('Esse CPF já está cadastrado');
          return;
        }
      }
      await ContactRepository().createContact(contactModel);
      Navigator.of(context).pushNamed(AppRoutes.Home);
    }

  }
}
