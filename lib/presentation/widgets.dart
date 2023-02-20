import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          subtitle: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: SelectableText(
                  subtitle,
                  textAlign: TextAlign.center,
                )),
          )),
    ),
  );
}
