import 'package:flutter/material.dart';

InputDecoration TextFormStyle(label){
  return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      hintText: label
  );
}