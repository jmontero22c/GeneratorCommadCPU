import 'package:flutter/material.dart';
import 'package:guardian_commands_creator/utils/colors.dart';

class ItemTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;
  const ItemTextField({
    super.key, 
    required this.hintText,
    required this.textEditingController,
  });

  @override
  State<ItemTextField> createState() => _ItemTextFieldState();
}

class _ItemTextFieldState extends State<ItemTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
          labelText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusColor: primaryColor,
          labelText: widget.hintText,
          labelStyle: TextStyle(color: Color.fromARGB(255, 172, 172, 172))
        ),
        cursorColor: lineColor,
        style: const TextStyle(
          color: primaryColor
        ),
      ),
    );
  }
}