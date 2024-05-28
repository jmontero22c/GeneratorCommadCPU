import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guardian_commands_creator/utils/GlobalDef.dart';
import 'package:guardian_commands_creator/utils/utils.dart';

class Generator extends StatefulWidget {
  final Application applicationUse;
  const Generator({super.key, required this.applicationUse});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
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
                    const Text('Screen Name')
                  ],
                ),
              ),
            ),
        
            //Right Side
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                child: const Column(
                  children: [
                    Text('Result Data')
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