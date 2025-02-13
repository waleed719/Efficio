import 'package:flutter/material.dart';

class CustomtxtField extends StatelessWidget {
  final String labeltext;
  final String hintTt;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?) validator;

  const CustomtxtField(
      {super.key,
      required this.labeltext,
      required this.hintTt,
      required this.controller,
      required this.obscureText,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: Text(labeltext),
        hintText: hintTt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
