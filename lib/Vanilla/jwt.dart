import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_application/globals/globals.dart' as globals;
import 'package:sample_application/presentation/widgets.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'dart:developer' as dev;

import 'package:x509/x509.dart';

class jwtgeneration extends StatefulWidget {
  const jwtgeneration({super.key});

  @override
  State<jwtgeneration> createState() => _jwtgenerationState();
}

bool isJWTComplete = false;

class _jwtgenerationState extends State<jwtgeneration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          globals.phase,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: globals.primaryColorJWT,
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            generateListtile("JWT Value", globals.JWTValue),
            SizedBox(
                height: 30, width: 50, child: Image.asset('resources/2.png')),
            ElevatedButton.icon(
                onPressed: () {
                  ReadFile();
                },
                icon: Icon(Icons.check),
                label: Text("Check"))
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
                            backgroundColor: globals.primaryColorJWT),
                        onPressed: () async {
                          //ReadFile();
                          globals.phase = "JWT Generation Step 3/4";
                          //// globals.firstJWT =
                          ////     await JWTCreation(globals.jwtInnerPayLoad);
                          globals.JWTValue =
                              await JWTCreation(globals.jwtPayLoad);
                          ////print(globals.JWTValue);
                          //printLongString("Full String : " + globals.JWTValue);
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
                  visible: isJWTComplete,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: globals.SecondaryColorXor),
                          onPressed: () {},
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

  Future<String> JWTCreation(Map<String, String> jsonmap) async {
    try {
      //ReadFile();
      //final privatekey = "PrivateKey";

      //String fileData = await ReadFile();
      final secretkey =
          RSAKeyParser().parse(globals.CertificateString) as RSAPrivateKey;
      //final secretkey = RSAPrivateKey(key);
      final jwtTokenBody = JWT(jsonmap, header: {"x5c": secretkey});
      final jwtTokenGenerated = await jwtTokenBody.sign(
        secretkey,
      );
      //verifyJWT(jwtTokenGenerated, secretkey);
      return jwtTokenGenerated;
    } catch (_) {
      print(_.toString());
      return "Error";
    }
  }

  void verifyJWT(String jwt, SecretKey secretkey) {
    try {
      final jwtIntegrity = JWT.verify(jwt, secretkey);

      print("Success : JWT verified");
    } catch (_) {
      print("Failure : JWT not ok");
    }
  }

  /// Print Long String
  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }

  Future<String> ReadFile() async {
    try {
      //final directory = await getApplicationDocumentsDirectory();
      const FilePath = 'resources/server.pem';
      final CertFilePath = await rootBundle.loadString(FilePath);

      print(CertFilePath);
      return CertFilePath;
    } catch (_) {
      print(_.toString());
      throw Exception();
    }
  }

  // void CertCreate() {
  //   try {
  //     final cert = parsePem(File("resources/server.pem").readAsStringSync())
  //         .first as CertificationRequest;
  //   } catch (_) {}
  // }
}
