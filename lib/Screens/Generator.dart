import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guardian_commands_creator/Controllers/firebase_controller.dart';
import 'package:guardian_commands_creator/utils/GlobalDef.dart';
import 'package:guardian_commands_creator/utils/colors.dart';
import 'package:guardian_commands_creator/utils/utils.dart';
import 'package:guardian_commands_creator/widgets/Item.dart';

class Generator extends StatefulWidget {
  final Application applicationUse;
  const Generator({super.key, required this.applicationUse});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  TextEditingController _controller = TextEditingController();

  String? selectedCommand;
  List<String> TittleItems = [];
  List<String> ValueItems = [];
  int NumberOfItems = 0;

  void setSelectCommand(newValue){
    FirestoreCloud().getLength("[$newValue]").then((value){
        NumberOfItems = value;

        for (var i = 0; i < NumberOfItems; i++) {
          TittleItems.add(''); 
        }
      
        FirestoreCloud().readDatabase("[$newValue]").then((value){
          // value.
          value.forEach((key, value) {
            var index = int.parse(key.split(".")[0])-1;
            TittleItems[index] = key.split(".")[1];
            TittleItems[index] = key.split(".")[1];
          });

          setState(() {
            selectedCommand = newValue; 
            NumberOfItems = NumberOfItems;  
          });

        });
      } 
    );   
  }

  List<DropdownMenuEntry<String>> funFunction(){
    return Datos_Motor.entries.map((entry) {
      return DropdownMenuEntry<String>(
        value: entry.value,
        label: entry.key,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: [
            //Left Side
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                 
                  border: Border(
                    right: BorderSide(
                    width: 0.5  ,
                    color: Colors.blue,
                    style: BorderStyle.solid,
                  )
                  )
                ),
                child: Column(
                  children: [
                    Text(
                      getApplication(widget.applicationUse),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10,),
                    DropdownMenu(
                      dropdownMenuEntries: funFunction(),
                      onSelected: (Command){
                        setSelectCommand(Command.toString());
                        log('Jirwigou');
                      },
                    ),  
                    const SizedBox(height: 10,),
                    Text(
                      "Selected Command: [$selectedCommand]", 
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                    
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(NumberOfItems, (index) {
                            return ItemTextField(hintText: TittleItems[index]);
                          }),
                        ),
                      ),
                    ),
             
                  ],
                ),
              ),
            ),
        
            //Right Side
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Result: ', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const SingleChildScrollView(                  
                        child: SelectableText(
                          'DM.myRxData.txt="[D;9600;222;192.168.255.124;255.255.255.255;192.168.168.168;;3;;5;;3;127;1;0;10;;1;500;1;400;;;;;;;;;5;D]"',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                      
                            color: primaryColor
                          ),
                        ),
                      ),                ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}