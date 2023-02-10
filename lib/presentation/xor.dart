import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_application/cubit/cubit/xor_cubit.dart';
import 'package:sample_application/globals/globals.dart';

class logicalOperation extends StatefulWidget {
  const logicalOperation({super.key});

  @override
  State<logicalOperation> createState() => _logicalOperationState();
}

bool isXorComplete = false;

class _logicalOperationState extends State<logicalOperation> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<XorCubit>(context).fetchInput();

    return BlocProvider(
      create: (context) => XorCubit(),
      child: Scaffold(
        backgroundColor: primaryColorXor,
        appBar: AppBar(
          title: Text(
            phase,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryColorXor,
        ),
        body: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              generateListtile("XOR Value ", operationResult),
              generateListtile("AAD Value ", AADString),
              generateListtile("IV Value ", IVString),
            ],
          ),
        )),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 15,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColorXor),
                          onPressed: () {
                            try {
                              xorOperation(
                                  "2023-02-02T14:16:37.611Z", "8116431079");
                              AAD = getRangeOfArr(XORBytes, 16, "AAD");
                              IV = getRangeOfArr(XORBytes, 12, "IV");
                              print(IV.toList().toString());
                              // Remove the below two lines if UI is not necessary
                              AADString = AAD.toList().toString();
                              IVString = IV.toList().toString();

                              setState(() {
                                AADString;
                                IVString;
                                isXorComplete = true;
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Error on Convertion')));
                            }
                          },
                          icon: const Icon(Icons.enhanced_encryption),
                          label: Container(
                              color: primaryColorXor,
                              height: MediaQuery.of(context).size.height / 15,
                              alignment: Alignment.center,
                              child: const Text(
                                "Start",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ))),
                    ),
                  ),
                  Visibility(
                    visible: isXorComplete,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: SecondaryColorXor),
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_right_alt),
                            label: Container(
                                height: MediaQuery.of(context).size.height / 15,
                                alignment: Alignment.center,
                                child: const Text(
                                  "AES",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ))),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget generateListtile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Material(
        elevation: 6,
        child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              color: Colors.deepOrange,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            subtitle: Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                ))),
      ),
    );
  }
}

void xorOperation(String timestampString, String transtIdString) {
  try {
    var timestamp = utf8.encode(timestampString);
    var transactionId = utf8.encode(transtIdString);
    int timestampLength = timestamp.length;
    int transactionIdLength = transactionId.length;

    if (timestampLength > transactionIdLength) {
      transactionId =
          FillRange(transactionId, timestampLength - transactionIdLength);
    } else if (timestampLength > transactionIdLength) {
      timestamp = FillRange(timestamp, transactionIdLength - timestampLength);
    }

    int MaxLen = max(timestampLength, transactionIdLength);
    List<int> list = [];

    for (int i = 0; i < MaxLen; i++) {
      list.add(timestamp[i] ^ transactionId[i]);
    }

    var operationResults = list;
    XORBytes = operationResults;

    //Remove below line if UI is not necessary
    operationResult = operationResults.toString();
  } catch (exp) {
    print("XOR operation failed : $exp");
    throw Exception();
  }
}

List<int> FillRange(List<int> bytearrData, int len) {
  try {
    List<int> newList = <int>[];
    int totalLen = bytearrData.length + len;
    int IterateLen = 0;
    for (; IterateLen < len; IterateLen++) {
      newList.add(0);
    }

    for (int j = 0; IterateLen < totalLen; IterateLen++, j++) {
      newList.add(bytearrData[j]);
    }

    return newList;
  } catch (exp) {
    print("Zero Add Error :$exp");
    rethrow;
  }
}

List<int> getRangeOfArr(List<int> bytearr, int len, String type) {
  try {
    List<int> byteArrrev = List.from(bytearr.reversed);
    var rangeValues = byteArrrev.getRange(0, len);
    List<int> rearrangeValues = List.from(rangeValues.toList().reversed);
    return rearrangeValues.toList();
  } catch (e) {
    print("Range Fetch Error  : $e");
    throw Exception();
  }
}
