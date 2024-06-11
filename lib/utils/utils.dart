import 'package:flutter/cupertino.dart';
import 'package:guardian_commands_creator/utils/GlobalDef.dart';

String getApplication(Application application){
  String result = "Undefined";
  switch (application) {
    case Application.esp:
      result = "ESP";  
    break;

    case Application.pcp:
      result = "PCP";  
    break;

    case Application.hps:
      result = "HPS";  
    break;
  }
  return result;
}

String generateCommand(List<TextEditingController> valueItems, String mainCommand) {
  mainCommand.split('SPD_INFO')[1];
  final StringBuffer result = StringBuffer('DM.myRxData.txt="[SPDI${mainCommand.split('SPD_INFO')[1]}');

  for (var controller in valueItems) {
    result.write(";${controller.text}");
  }

  result.write(';SPD]"');
  return result.toString();
}