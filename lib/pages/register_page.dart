import 'package:flutter/material.dart';
import 'package:geo_contacts/defaults/adaptive_text_field.dart';
import 'package:geo_contacts/models/register_model.dart';
import 'package:geo_contacts/repository/register_repository.dart';

import '../utility/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _nomeRegisterController = TextEditingController();
  final _emailRegisterController = TextEditingController();
  final _passworRegisterdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.Login,
                );
              },
            );
          },
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AdaptiveTextField(
              obscureText: false,
              controller: _nomeRegisterController,
              label: 'Nome',
            ),
            AdaptiveTextField(
              obscureText: false,
              controller: _emailRegisterController,
              label: 'E-mail',
            ),
            AdaptiveTextField(
              obscureText: true,
              controller: _passworRegisterdController,
              label: 'Senha',
            ),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: buttonCadastrar,
                child: Text('Cadastrar')
            )
          ],
        ),
      ),
    );
  }

  buttonCadastrar() async {
    if(_nomeRegisterController.text.isEmpty){
      _showAlertRegister('Necessário Preencher nome');
    }else if (_emailRegisterController.text.isEmpty ) {
      _showAlertRegister('Necessário preencher email!');
    } else if (_passworRegisterdController.text.isEmpty) {
      _showAlertRegister('Necessário preencher senha!');
    } else if(!_emailRegisterController.text.contains('@')|| !_emailRegisterController.text.contains('.')) {
      _showAlertRegister('E-mail inválido!');
    }else {
      List<RegisterModel> listUsersRegistered = await RegisterRepository().readAllRegister();

      if(listUsersRegistered.isNotEmpty){
        for(var auxItemList in listUsersRegistered) {
          if(auxItemList.email ==  _emailRegisterController.text) {
            _showAlertRegister('Este e-mail já está cadastrado!');
            return;
          }
        }
      }

      RegisterModel userRegisterData = RegisterModel(
        email: _emailRegisterController.text,
        nome: _nomeRegisterController.text,
        senha: _passworRegisterdController.text
      );
      await RegisterRepository().createOrUpdate(userRegisterData);
      String emailUser =  _emailRegisterController.text;

      Navigator.popAndPushNamed(context,AppRoutes.Login,arguments: emailUser);
    }
  }
  _showAlertRegister(String textAlert) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(textAlert),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
