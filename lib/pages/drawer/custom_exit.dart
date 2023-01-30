

import 'package:flutter/material.dart';

import '../../utility/app_routes.dart';

class CustomExit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        Navigator.of(context).pop();
        Navigator.pushNamed(context, AppRoutes.Login);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Container(
          height: 55,
          child: Row(
            children: [
              Icon(
                Icons.logout,
                size: 32,
                color: Theme.of(context).primaryColor, //pageController.page?.round() == page ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
              const SizedBox(width: 32,),
              Text(
                "Sair",
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
