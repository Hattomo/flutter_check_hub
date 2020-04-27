import 'package:flutter/material.dart';

const InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintText: 'Detail 🍀',
  hintStyle: TextStyle(color: Colors.grey),
  errorStyle: TextStyle(color: Colors.pink),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.pink),
  ),
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);
