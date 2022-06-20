import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool obscureText;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.labelText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide.none),

        // focusedBorder: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        // contentPadding: EdgeInsets.all(10),
        labelText: labelText,
      ),
    );
  }
}
