import 'package:flutter/material.dart';
import 'package:flutter_application/utility/my_constant.dart';

class MyStyle {
  ButtonStyle myButtonStyleV2() => ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 227, 81, 28),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ));

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
      backgroundColor: MyConstant.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ));

  TextStyle h1Style() => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 9, 9, 15),
      );

  TextStyle h2Style() => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        // color: MyConstant.light,
        color: MyConstant.statndard,
      );

  TextStyle h3Style() => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Color.fromARGB(255, 25, 25, 25),
      );

  MyStyle();
}
