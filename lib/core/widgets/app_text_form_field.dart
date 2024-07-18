import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String labelText ;
  const AppTextFormField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
