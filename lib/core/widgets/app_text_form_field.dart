import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String labelText ;
  final TextEditingController? controller ;
  const AppTextFormField({super.key, required this.labelText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:  controller,
      decoration: InputDecoration(
          labelText: labelText ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
