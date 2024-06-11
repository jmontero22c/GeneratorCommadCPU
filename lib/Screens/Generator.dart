import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guardian_commands_creator/Controllers/firebase_controller.dart';
import 'package:guardian_commands_creator/Model/model.dart';
import 'package:guardian_commands_creator/utils/GlobalDef.dart';
import 'package:guardian_commands_creator/utils/colors.dart';
import 'package:guardian_commands_creator/utils/utils.dart';
import 'package:guardian_commands_creator/widgets/Item.dart';
import 'package:guardian_commands_creator/widgets/button_left_dide.dart';
import 'package:guardian_commands_creator/widgets/copy_right.dart';
import 'package:provider_base_tools/provider_base_tools.dart';
import 'package:provider_base_tools/tools.dart';

class Generator extends StatefulWidget {
  final Application applicationUse;
  const Generator({super.key, required this.applicationUse});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  String? selectedCommand;
  List<String> tittleItems = [];
  List<TextEditingController> textControllers = [];
  int numberOfItems = 0;
  String commandShowing = "";

  void clearValues(BuildContext context) {
    for (var element in textControllers) {
      element.text = '';
    }
    Provider.of<ListTextFieldInputs>(context, listen: false).clearValues();
  }

  void setCommandShowing(String newCommand) {
    if (Provider.of<ListTextFieldInputs>(context, listen: false).isLoading) {
      return;
    }

    setState(() {
      commandShowing = newCommand;
    });
  }

  void saveValues() {
    if(selectedCommand == null){return;}
    
    if (Provider.of<ListTextFieldInputs>(context, listen: false).isLoading) {
      log('You cannot save new values while is loading');
      return;
    }

    Provider.of<ListTextFieldInputs>(context, listen: false).setIsLoading(true);

    final double horizontalMargin = MediaQuery.of(context).size.width * 0.4;
    final double verticalMargin = MediaQuery.of(context).size.height * 0.4;

    FirestoreCloud()
        .saveValuesDatabase(selectedCommand, tittleItems, textControllers)
        .then((value) {
          Provider.of<ListTextFieldInputs>(context, listen: false).setIsLoading(false);
          showDialog(
              context: context,
              builder: (context) => ShowDialogSaved(verticalMargin: verticalMargin, horizontalMargin: horizontalMargin));
        });
  }

  void setSelectCommand(BuildContext context, newValue) {
    if (Provider.of<ListTextFieldInputs>(context, listen: false).isLoading) {
      log('You cannot change the command while is loading another');
      return;
    }

    Provider.of<ListTextFieldInputs>(context, listen: false).setIsLoading(true);
    FirestoreCloud().getLength("[$newValue]").then((value) {
      numberOfItems = value;

      tittleItems.clear();
      textControllers.clear();

      for (var i = 0; i < numberOfItems; i++) {
        tittleItems.add('');
        textControllers.add(TextEditingController());
      }

      FirestoreCloud().readDatabase("[$newValue]").then((value) {
        value.forEach((key, value) {
          var index = int.parse(key.split("_")[0]) - 1;
          tittleItems[index] = key.split("_")[1];
          textControllers[index].text = value;
        });

        setState(() {
          selectedCommand = newValue;
          numberOfItems = numberOfItems;
        });

        Provider.of<ListTextFieldInputs>(context, listen: false)
            .setIsLoading(false);
      });
    });
  }

  List<DropdownMenuEntry<String>> getValuesDropDown() {
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
        gradient: LinearGradient(
          colors: [
            Color(0xFF00121C),
            Color(0xFF00070B),
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
        borderRadius: BorderRadius.all(Radius.circular(10)));

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: leftContainerDecoration,
                child: Column(
                  children: [
                    Text(
                      getApplication(widget.applicationUse),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownMenu(
                      dropdownMenuEntries: getValuesDropDown(),
                      textStyle: const TextStyle(color: primaryColor),
                      expandedInsets: const EdgeInsets.all(30),
                      onSelected: (command) {
                        setSelectCommand(context, command.toString());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Selected Command: [$selectedCommand]",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ListTextFieldInputs>(
                        builder: (context, myModel, child) {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(numberOfItems, (index) {
                              return ItemTextField(
                                hintText: tittleItems[index],
                                textEditingController: textControllers[index],
                              );
                            }),
                          ),
                        ),
                      );
                    }),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                              onTap: () => setCommandShowing(generateCommand(
                                  textControllers, selectedCommand)),
                              child: const GenerateButton(
                                description: 'Generate',
                              )),
                        ),
                        Flexible(
                          child: GestureDetector(
                              onTap: () => saveValues(),
                              child: const GenerateButton(
                                description: 'Save',
                              )),
                        ),
                        Flexible(
                          child: GestureDetector(
                              onTap: () => clearValues(context),
                              child: const GenerateButton(
                                description: 'Clear',
                                isRed: true,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            //Right Side
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Stack(children: [
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
                            const Text('Result: ',
                                style: TextStyle(color: primaryColor)),
                            const SizedBox(height: 10),
                            Container(
                              height: 100,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Stack(
                                children: [SingleChildScrollView(
                                  child: SelectableText(
                                    commandShowing,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(color: primaryColor),
                                  ),
                                ),
                                ClipboardButton(commandShowing: commandShowing),
                          ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const CopyRights(),
                  ],
                ),
                //Icon positioned at Right Bottom
                const IconYisus(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class ClipboardButton extends StatelessWidget {
  const ClipboardButton({
    super.key,
    required this.commandShowing,
  });

  final String commandShowing;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: commandShowing));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Text copied to clipboard'),
              duration: Duration(seconds: 1),
              width: 300,    
            ),
          );
        },
      ),
    );
  }
}

class ShowDialogSaved extends StatelessWidget {
  const ShowDialogSaved({
    super.key,
    required this.verticalMargin,
    required this.horizontalMargin,
  });

  final double verticalMargin;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 8,
            blurStyle: BlurStyle.solid,
            spreadRadius: 1,
          )
        ], 
        color: backgroundColor
      ),
      // color: lineColor,  
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      child: const Text(
        'Values Saved',
        style: TextStyle(
          color: primaryColor, 
          fontSize: 30,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none
        ),
      ),
    );
  }
}

class IconYisus extends StatelessWidget {
  const IconYisus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: SizedBox(
          height: 60,
          child: Opacity(opacity: 0.2, child: Image.asset("iconfav.png"))),
    );
  }
}
