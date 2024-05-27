import 'package:flutter/material.dart';

class Generator extends StatefulWidget {
  const Generator({super.key});

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
            Container(
              color: Colors.red,
              child: const Column(
                children: [
                  Text('Application Name'),
                  Text('Screen Name')
                ],
              ),
            ),

            //Right Side
            Container(
              color: Colors.amber,
              child: const Column(
                children: [
                  Text('Result Data')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}