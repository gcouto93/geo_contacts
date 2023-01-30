import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geo_contacts/defaults/adaptive_text_field.dart';
import 'package:geo_contacts/models/register_model.dart';
import 'package:geo_contacts/pages/home_page.dart';
import 'package:geo_contacts/pages/register_page.dart';
import 'package:geo_contacts/providers/auth_provider.dart';
import 'package:geo_contacts/repository/register_repository.dart';
import 'package:provider/provider.dart';

import '../utility/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _firebaseAuth = FirebaseAuth.instance;

  @override
  Scaffold build(BuildContext context)  {
    RegisterRepository registerRepo = RegisterRepository();
    registerRepo.readAllRegister();

    try{
      final args = ModalRoute.of(context)!.settings.arguments;
      if(args != null){
        _emailController.text = args as String;
      }
    }catch(e) {
      if (kDebugMode) {
        print(e);
      }
    }


    return Scaffold(
      body: SizedBox(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                      AdaptiveTextField(
                          keyboardType: TextInputType.emailAddress,
                          label: "E-mail",
                          controller: _emailController,
                          obscureText: false),
                      AdaptiveTextField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          label: 'Senha',
                          obscureText: true),
                      SizedBox(height: 10,),
                      ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: Text('Entrar')),
                      TextButton(
                          onPressed: () {Navigator.of(context).pushReplacementNamed(
                            AppRoutes.Register,
                          );},
                          child: Text('Cadastrar') ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if(_emailController.text.isEmpty){
      _showAlert('Preencha o e-mail');
    }else if(_passwordController.text.isEmpty) {
      _showAlert('preencha a senha');
    }else {
      //verificar se existem: email e senha
      List<RegisterModel> listAllRegisters = await RegisterRepository().readAllRegister();
      if(listAllRegisters.isEmpty){
        _showAlert('Usuário não cadastrado');
        return;
      }
      for( var itemListAux in listAllRegisters) {
        if(itemListAux.email == _emailController.text){
          if(itemListAux.senha == _passwordController.text){
            //logar
            _showAlert('Usuario encontrado. *LOGAR*',color: Colors.greenAccent);
            AuthProvider authProvider = Provider.of(context,listen: false);
            authProvider.loginAuthProvider(_emailController.text);
            Navigator.of(context).popAndPushNamed(AppRoutes.Home,arguments: _emailController.text);
            return;
          }else{
            _showAlert('Senha incorreta!');
            return;
          }
        }
        _showAlert('E-mail não cadastrado!');
        return;

      }
    }
  }

  _showAlert(String textAlert,{Color color = Colors.redAccent}) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(textAlert),
        backgroundColor: color,
      ),
    );
  }
}
