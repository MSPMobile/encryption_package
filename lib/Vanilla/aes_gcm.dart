import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:sample_application/globals/globals.dart';

class aesEncrypt extends StatefulWidget {
  const aesEncrypt({super.key});

  @override
  State<aesEncrypt> createState() => _aesEncryptState();
}

bool isAEScomplete = false;

class _aesEncryptState extends State<aesEncrypt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [],
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
                        onPressed: () {},
                        icon: const Icon(Icons.enhanced_encryption),
                        label: Container(
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
                  visible: isAEScomplete,
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
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ))),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void aesEncryption() 
  {
    
  }
}
