import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guardian_commands_creator/Model/model.dart';
import 'package:provider_base_tools/provider_base_tools.dart';
import 'firebase_options.dart';
import 'package:guardian_commands_creator/Screens/Generator.dart';
import 'package:guardian_commands_creator/utils/GlobalDef.dart';
import 'package:guardian_commands_creator/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ListTextFieldInputs(),
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, 
          background: backgroundColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:const Generator(applicationUse: Application.esp),
    );
  }
}
