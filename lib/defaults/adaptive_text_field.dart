import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const AdaptiveTextField({
    this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    required this.obscureText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: CupertinoTextField(
        maxLines: 1,
        minLines: 1,
        // expands: true,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        placeholder: label,
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12,
        ),
      ),
    )
        : TextFormField(
      maxLines: 1,
      minLines: 1,
      // expands: true,
      cursorColor: Colors.transparent,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        //labelText: label,
        hintText: label,
        contentPadding: const EdgeInsets.only(bottom: 10),
      ),
    );
  }
}
