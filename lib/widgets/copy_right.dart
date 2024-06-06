import 'package:flutter/material.dart';

class CopyRights extends StatelessWidget {
  const CopyRights({super.key});

  @override
  Widget build(BuildContext context) {
    return const Flexible(
      flex: 0,
      child: Text(
        'Made by ElYisus1001 - Todos los derechos reservados ©',
        style: TextStyle(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}