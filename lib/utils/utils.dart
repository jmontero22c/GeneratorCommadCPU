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

String generateCommand(List<String> ValueItems){
  String result = "[SPD";
  
  ValueItems.forEach((element) { 
    result += ";${element}";
  });

  result += ";SPD]";
  return result;
}