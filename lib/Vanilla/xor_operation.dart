import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sample_application/Vanilla/aes_gcm.dart';
import 'package:sample_application/globals/globals.dart';
import 'package:sample_application/presentation/xor.dart';

class xor extends StatefulWidget {
  const xor({super.key});

  @override
  State<xor> createState() => _xorState();
}

bool isXorComplete = false;

class _xorState extends State<xor> {
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
                                "2023-02-07T08:17:23.697Z", "4560504288");
                            // "2023-02-02T14:16:37.611Z", "8116431079"
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
                              phase = "AES Encryption Step 2/4";
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error on Convertion')));
                          }
                        },
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
                  visible: isXorComplete,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: SecondaryColorXor),
                          onLongPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const aesEncrypt()));
                          },
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(seconds: 5),
                                    backgroundColor:
                                        Color.fromARGB(255, 176, 53, 12),
                                    content: Text(
                                      'On Progress. Please wait',
                                      style: TextStyle(color: Colors.white),
                                    )));
                          },
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

  Widget generateListtile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Material(
        elevation: 6,
        child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              color: primaryColorXor,
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
