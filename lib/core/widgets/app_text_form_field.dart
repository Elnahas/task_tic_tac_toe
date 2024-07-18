import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String labelText ;
  final TextInputType? keyboardType ;
  final TextEditingController? controller ;
  const AppTextFormField({super.key, required this.labelText, this.controller, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:  controller,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        
          labelText: labelText ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
