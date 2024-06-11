import 'package:flutter/material.dart';
import 'package:guardian_commands_creator/Model/model.dart';
import 'package:guardian_commands_creator/utils/colors.dart';

  ListTextFieldInputs model = ListTextFieldInputs();

/********GENERATE BUTTON WIDGET *******/
class GenerateButton extends StatelessWidget {
  final String description;
  final bool? isRed;
  const GenerateButton({required this.description,this.isRed,super.key});

  Color getColorButton() {
    if(model.isLoading){
      return Colors.grey;
    }
    
    return (isRed == true) ? buttonColorSecond : buttonColorPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: getColorButton(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          textAlign: TextAlign.justify,
          description,
          style: const TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}