import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kHintTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(40.0),
);

const kDarkHintTextStyle =  TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w100,
  fontSize: 20.0,
  fontFamily: 'OpenSans',
);

const kDarkLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w100,
  fontFamily: 'OpenSans',
);

InputDecoration kInputStyle(String label,String errortext, IconData preficon) {
  return InputDecoration(
    suffixIcon: (errortext!=null)?const Icon(
      Icons.error,
      color: Colors.red,
    ):null,
    fillColor: Colors.white,
    focusColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
    labelText: label,
    errorText: errortext,
    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
    prefixIcon: Icon(
      preficon,
    ),
  );
}