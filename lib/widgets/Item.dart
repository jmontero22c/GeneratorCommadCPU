import 'package:flutter/material.dart';
import 'package:guardian_commands_creator/utils/colors.dart';

class ItemTextField extends StatefulWidget {
  final String hintText;
  const ItemTextField({
    super.key, 
    required this.hintText
  });

  @override
  State<ItemTextField> createState() => _ItemTextFieldState();
}

class _ItemTextFieldState extends State<ItemTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusColor: lineColor,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 69, 69, 69))
      ),
      cursorColor: lineColor,
      style: const TextStyle(
        color: primaryColor
      ),
    );
  }
}