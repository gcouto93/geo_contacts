// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geo_contacts/repository/contact_repository.dart';
import 'package:geo_contacts/repository/register_repository.dart';
import 'package:geo_contacts/utility/app_routes.dart';

class CustomTileDeleteUser extends StatelessWidget {
  final String title;

  const CustomTileDeleteUser(this.title);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        if (kDebugMode) {
          print("Mudando para pagina ${title}");
        }
        _deleteUser(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.delete,
                size: 32,
                color: Colors.redAccent, //pageController.page?.round() == page ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
              const SizedBox(width: 32,),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _deleteUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //backgroundColor: Colors.red.shade600,
          title: Center(
              child: Text(
                'ATENÇÃO!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              )),
          content: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
                'Tem certeza que deseja deletar sua conta?'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () {
                ContactRepository().deleteAllContacts();
                RegisterRepository().deleteAllRegister();
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.Login,
                );
              },
              child: Text(
                'Sim',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
