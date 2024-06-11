import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guardian_commands_creator/Controllers/firebase_controller.dart';
import 'package:guardian_commands_creator/utils/GlobalDef.dart';
import 'package:guardian_commands_creator/utils/colors.dart';
import 'package:guardian_commands_creator/utils/utils.dart';
import 'package:guardian_commands_creator/widgets/Item.dart';
import 'package:guardian_commands_creator/widgets/copy_right.dart';

class Generator extends StatefulWidget {
  final Application applicationUse;
  const Generator({super.key, required this.applicationUse});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  String? selectedCommand;
  List<String> tittleItems = [];
  List<String> valueItems = [];
  List<TextEditingController> textControllers= [];
  int NumberOfItems = 0;
  String commandShowing = "";

  void setCommandShowing(String newCommand){
    setState(() {
      commandShowing = newCommand;
    });
  }

  void setSelectCommand(newValue){
    FirestoreCloud().getLength("[$newValue]").then((value){
        NumberOfItems = value;

        for (var i = 0; i < NumberOfItems; i++) {
          tittleItems.add(''); 
          textControllers.add(TextEditingController());
        }
      
        FirestoreCloud().readDatabase("[$newValue]").then((value){
          value.forEach((key, value) {
            var index = int.parse(key.split(".")[0])-1;
            tittleItems[index] = key.split(".")[1];
            tittleItems[index] = key.split(".")[1];
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
    const BoxDecoration leftContainerDecoration = BoxDecoration(
      gradient: LinearGradient(colors: [
          Color(0xFF00121C),
          Color(0xFF000000),
          Color(0xFF00121C),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.blue, 
          blurRadius: 8,
          blurStyle: BlurStyle.solid,
          spreadRadius: 1,
        )
      ],
      borderRadius: BorderRadius.all(Radius.circular(10))

    ); 
    
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
                margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: leftContainerDecoration,
                child: Column(
                  children: [
                    Text(
                      getApplication(widget.applicationUse),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10,),
                    DropdownMenu(
                      dropdownMenuEntries: funFunction(),
                      textStyle: const TextStyle(color: primaryColor),
                      onSelected: (Command){
                        setSelectCommand(Command.toString());
                      },
                    
                    ),  
                    const SizedBox(height: 10,),
                    Text(
                      "Selected Command: [$selectedCommand]", 
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(NumberOfItems, (index) {
                            return ItemTextField(hintText: tittleItems[index], textEditingController: textControllers[index],);
                          }),
                        ),
                      ),
                    ),

                    //Button Generate
                    // ElevatedButton(
                    //   onPressed: () {
                          
                    //   },
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.resolveWith((states) {
                    //       // If the button is pressed, return green, otherwise blue
                    //       if (states.contains(MaterialState.pressed)) {
                    //         return Color.fromARGB(255, 10, 0, 87);
                    //       }
                    //       return Colors.blue;
                    //     }),
                    //     shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
                    //   ),
                    //   child:const Text(
                    //     'Generate', 
                    //       style: TextStyle(
                    //         color: primaryColor,
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold
                    //       ),
                    //     ),
                    // )
                    GestureDetector(
                      onTap: () => setCommandShowing(generateCommand(textControllers, selectedCommand!)),
                      child: const GenerateButton()
                    )
                  ],
                ),
              ),
            ),
        
            //Right Side
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Flexible(
                        flex: 10,
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
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: SingleChildScrollView(                  
                                  child: SelectableText(
                                    commandShowing,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: primaryColor
                                    ),
                                    
                                  ),
                                ), 
                              ),
                            
                            ],
                          ),
                        ),
                      ),

                      const CopyRights(),         
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                      height: 60,
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.asset("iconfav.png")
                      )
                    ),
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}


// ignore: slash_for_doc_comments
/********GENERATE BUTTON WIDGET *******/
class GenerateButton extends StatelessWidget {
  const GenerateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text(
        'Generate', 
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}