import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/Vanilla/jwt.dart';
import 'package:sample_application/globals/globals.dart' as globals;
import 'package:cryptography/cryptography.dart';
import 'package:sample_application/presentation/widgets.dart';

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
          globals.phase,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: globals.primaryColorAEs,
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            generateListtile("AES Value", globals.AESValue),
            generateListtile("AES HEX", globals.aesHEX)
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
                            backgroundColor: globals.primaryColorAEs),
                        onPressed: () async {
                          //AESDecrypt();
                          globals.AESValue =
                              await aesEncryption(globals.XORBytes);
                          isAEScomplete = true;
                          globals.phase = "JWT Generation Step 3/4";
                          setState(() {});
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
                  visible: isAEScomplete,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: globals.SecondaryColorXor),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => jwtgeneration()));
                          },
                          icon: const Icon(Icons.arrow_right_alt),
                          label: Container(
                              height: MediaQuery.of(context).size.height / 15,
                              alignment: Alignment.center,
                              child: const Text(
                                "JWT",
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

  Future<String> aesEncryption(List<int> plainText) async {
    try {
      String keyString = "dxMZZ0CjvFJ/yQfk2uH8nm8/kAhEWfT/7iVBd5F7Bfc=";
      //Remove below line after Testing
      //String keyEncoded = "[B@442d9b6e";

      //Remove below line after Testing
      String TestValue = "HELLO WORLD";
      final algo = AesGcm.with256bits();

      //Generate byte values
      final keybase64 = base64Url.decode(keyString);
      final secretkey = SecretKey(keybase64);
      //final extractedBytes = await secretkey.extractBytes();
      //print("Secret key :" + extractedBytes.toString());

      final value = await utf8.encode(TestValue);
      final valueList = Uint8List.fromList(value);

      //SecretKey secret = await algo.newSecretKey();

      final CipherText = await algo.encrypt(value,
          secretKey: secretkey, nonce: globals.IV, aad: globals.AAD);

      final base64EncryptResult =
          base64Url.encode(utf8.encode(CipherText.toString()));

      globals.aesHEX = utf8.encode(CipherText.toString()).toString();
      print(CipherText.toString());

      return base64EncryptResult;
      //final cipherTextBase64 = base64.encode(CipherText);
    } catch (_) {
      print("Encryption Error : " + _.toString());
      return "Error Please check console";
    }
  }

  Future<void> AESDecrypt() async {
    try {
      final ListValue = base64Url.decode(globals.AESsample);
      //print(utf8.decode(ListValue));
      String keyString = "dxMZZ0CjvFJ/yQfk2uH8nm8/kAhEWfT/7iVBd5F7Bfc=";
      final algo = AesGcm.with256bits();

      final keybase64 = base64Url.decode(keyString);
      final secretkey = SecretKey(keybase64);

      // final secretbox = SecretBox.fromConcatenation(ListValue,
      //     nonceLength: 12, macLength: 16);

      final secretbox = SecretBox.fromConcatenation(ListValue,
          nonceLength: 12, macLength: 32);

      final cipherDecrypt =
          await algo.decrypt(secretbox, secretKey: secretkey, aad: globals.AAD);
      print("Decrypted : " + utf8.decode(cipherDecrypt).toString());
    } catch (_) {
      print(_.toString());
    }
  }
}
