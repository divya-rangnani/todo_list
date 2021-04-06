import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration circularBorder() {
  return BoxDecoration(
    color: Color.fromRGBO(232, 239, 245, 1.0),
    border: Border.all(width: 2, color: Color.fromRGBO(232, 239, 245, 1.0)),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
