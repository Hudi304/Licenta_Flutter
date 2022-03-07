import 'dart:ui';

import 'package:esp_socket/shared/helpers/pallet.dart';
import 'package:flutter/material.dart';

import 'dimentions.dart';


class Styles {
  static TextStyle black14 = TextStyle(
      color: Colors.black,
      fontSize: Dimensions.textSize14,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500);

  static TextStyle black16 = TextStyle(
      color: Colors.black,
      fontSize: Dimensions.textSize16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500);

  static TextStyle black16Bold = TextStyle(
      color: Colors.black,
      fontSize: Dimensions.textSize16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w700);

  static TextStyle white16 = TextStyle(
      color: Colors.white,
      fontSize: Dimensions.textSize16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500);

  static TextStyle white16Bold = TextStyle(
      color: Colors.white,
      fontSize: Dimensions.textSize16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w700);

  static TextStyle blue16Bold = TextStyle(
      color: Palette.accentBlue,
      fontSize: Dimensions.textSize16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w700);

  static TextStyle red16Bold = TextStyle(
      color: Palette.errorRed,
      fontSize: Dimensions.textSize16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w700);
}
