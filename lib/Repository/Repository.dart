import 'package:flutter/foundation.dart';
import 'package:sample_application/Model/xorData.dart';

class repository {
  List<xorInput> fetchInput() {
    List<xorInput> inputList = <xorInput>[];

    xorInput input = xorInput("2023-02-02T14:16:37.611Z", "8116431079");
    inputList.add(input);
    return inputList;
  }
}
