// ignore_for_file: unnecessary_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Button(size, text) {
  return Container(
    width: size.width * 0.45,
    height: size.height * 0.06,
    decoration: ShapeDecoration(
      color: const Color(0xFF65D893),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(27),
      ),
      shadows: const [
        BoxShadow(
          color: Color(0x5965D893),
          blurRadius: 17,
          offset: Offset(0, 13),
          spreadRadius: 0,
        )
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w600,
          letterSpacing: -0.56,
        ),
      ),
    ),
  );
}
