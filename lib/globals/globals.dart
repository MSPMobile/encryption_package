import 'package:flutter/material.dart';

String phase = "XOR Operation Step 1/4";
String operationResult = "- -";
String AADString = "- -";
String IVString = "- -";
List<int> XORBytes = <int>[];
List<int> AAD = <int>[];
List<int> IV = <int>[];

Color primaryColorXor = Color.fromARGB(255, 239, 121, 4);
Color SecondaryColorXor = Color.fromARGB(255, 38, 113, 0);

class Colorspallette {
  MaterialColor customPallette = MaterialColor(0xffe55f48, <int, Color>{});
}
