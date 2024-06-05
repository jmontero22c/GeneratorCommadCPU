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
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: BorderRadius.circular(5)
    );
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusColor: primaryColor,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 135, 135, 135)),
          // focusedBorder: inputBorder,
          // enabledBorder: inputBorder,
        ),
        cursorColor: lineColor,
        style: const TextStyle(
          color: primaryColor
        ),
      ),
    );
  }
}