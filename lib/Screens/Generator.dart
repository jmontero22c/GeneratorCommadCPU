import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guardian_commands_creator/utils/GlobalDef.dart';
import 'package:guardian_commands_creator/utils/colors.dart';
import 'package:guardian_commands_creator/utils/utils.dart';

class Generator extends StatefulWidget {
  final Application applicationUse;
  const Generator({super.key, required this.applicationUse});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  TextEditingController _controller = TextEditingController();

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