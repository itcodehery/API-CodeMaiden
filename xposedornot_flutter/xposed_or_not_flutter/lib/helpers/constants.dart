import 'package:flutter/material.dart';

final scaffoldColor = Colors.grey[900];

const ButtonStyle appBarButtons = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(Colors.white12),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.white12,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(80)),
    ),
  ),
  minimumSize: WidgetStatePropertyAll(
    Size(60, 60),
  ),
);
