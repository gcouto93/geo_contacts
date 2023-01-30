// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String appRoutes;

  const CustomTile(this.icon, this.title, this.appRoutes);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (kDebugMode) {
          print("Mudando para pagina ${title}");
        }
        Navigator.of(context).pushReplacementNamed(
          appRoutes,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).primaryColor, //pageController.page?.round() == page ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
              const SizedBox(width: 32,),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
