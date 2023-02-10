import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_application/Repository/Repository.dart';
import 'package:sample_application/Vanilla/xor_operation.dart';
import 'package:sample_application/cubit/cubit/xor_cubit.dart';
import 'package:sample_application/globals/globals.dart';
import 'package:sample_application/presentation/xor.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           primarySwatch: Colors.deepOrange,
//           shadowColor: Color.fromARGB(255, 187, 129, 100)),
//       home: BlocProvider(
//         create: (context) => XorCubit(),
//         child: logicalOperation(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(shadowColor: Color.fromARGB(255, 187, 129, 100)),
      home: xor(),
    );
  }
}
