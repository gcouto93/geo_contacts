import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geo_contacts/models/contact_model.dart';
import 'package:geo_contacts/providers/contact_provider.dart';
import 'package:geo_contacts/repository/contact_repository.dart';
import 'package:provider/provider.dart';
import '../../utility/app_routes.dart';
import 'custom_exit.dart';
import 'custom_tile.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<ContactModel> listaContatos = Provider.of<ContactProvider>(context).listContact;

    return Drawer(
      child: Stack(
        children: [
        SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration:
              BoxDecoration(color: Theme.of(context).primaryColor),
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
              height: 100,
              child: Text('Lista de contatos'),
            ),

            Consumer<ContactProvider>(builder: (context, prov, child) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Slidable(
                    actions: [
                      IconSlideAction(
                        color: Colors.redAccent,
                        icon: Icons.flag_outlined,
                        caption: 'Excluir',
                        onTap: () {
                          _deleteItem(prov.listContact[index].nome!);
                        },
                      )
                    ],
                    secondaryActions: [
                      IconSlideAction(
                        color: Colors.blueAccent,
                        icon: Icons.flag_outlined,
                        caption: 'Editar',
                        onTap: () {
                          updateItem(prov.listContact[index]);
                        },
                      )
                    ],
                    actionPane: const SlidableStrechActionPane(),
                    child: ListTile(
                      onTap: () {

                      },
                      title: Text(prov.listContact[index].nome!),
                      // trailing: Text(listResponse[index].uf!),
                      subtitle: Text('TEste'),
                    ),
                  );
                },
                itemCount: prov.listContact.length,

              );
            }),
            const SizedBox(height: 50,),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Versão 1',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomExit(),
              ],
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }
  void _deleteItem(String nome){
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
                'Tem certeza que deseja EXCLUIR: ${nome}?'),
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
                Navigator.of(context).pop();
                ContactRepository().delete(nome);
                setState(() {

                });
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
  void updateItem(ContactModel contactModel) {
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
              'Deseja Editar: ${contactModel.nome}?'),
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
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppRoutes.CreateContact,arguments: contactModel);
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
