import 'dart:math';
import 'package:flutter/material.dart';

class SizeConfig {
  //Device Size
  static double _width;
  static double _height;
  static double hipo;
  static double get width => _width;
  static double get height => _height;
  //

  //Padding
  static EdgeInsets allPadding(double val) => EdgeInsets.all(hipo * val);
  static EdgeInsets symmetricPadding(
          {double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(
          horizontal: width * horizontal, vertical: height * vertical);
  static EdgeInsets onlyPadding(
          {double left = 0,
          double top = 0,
          double right = 0,
          double bottom = 0}) =>
      EdgeInsets.fromLTRB(
          width * left, height * top, width * right, width * bottom);
  //

  //FontSize
  static double _fontSize8;
  static double _fontSize9;
  static double _fontSize10;
  static double _fontSize11;
  static double _fontSize12;
  static double _fontSize13;
  static double _fontSize14;
  static double _fontSize15;
  static double _fontSize16;
  static double _fontSize17;
  static double _fontSize18;
  static double _fontSize19;
  static double _fontSize20;
  static double _fontSize24;
  static double _fontSize27;
  static double _fontSize29;
  static double _fontSize34;
  static double _fontSize50;
  static double _fontSize80;
  static double get fontSize8 => _fontSize8;
  static double get fontSize9 => _fontSize9;
  static double get fontSize10 => _fontSize10;
  static double get fontSize11 => _fontSize11;
  static double get fontSize12 => _fontSize12;
  static double get fontSize13 => _fontSize13;
  static double get fontSize14 => _fontSize14;
  static double get fontSize15 => _fontSize15;
  static double get fontSize16 => _fontSize16;
  static double get fontSize17 => _fontSize17;
  static double get fontSize18 => _fontSize18;
  static double get fontSize19 => _fontSize19;
  static double get fontSize20 => _fontSize20;
  static double get fontSize24 => _fontSize24;
  static double get fontSize27 => _fontSize27;
  static double get fontSize29 => _fontSize29;
  static double get fontSize34 => _fontSize34;
  static double get fontSize80 => _fontSize80;
  static double get fontSize50 => _fontSize50;
  //
  //Icon size
  static double _iconSizeProfileCard;
  static double _iconSizeWallet;

  static double get iconSizeProfileCard => _iconSizeProfileCard;
  static double get iconSizeWallet => _iconSizeWallet;

  //end
  //kategori bulamadım
  static double _appBarBoxHeight;
  static double _instrumentImageSize;
  static double get appBarBoxHeight => _appBarBoxHeight;
  static double get instrumentImageSize => _instrumentImageSize;

  static bool setSize(double width, double height) {
    //Device Size
    _width = width;
    _height = height;
    hipo = sqrt((height * height) + (width * width));
    //

    //FontSize
    _fontSize8 = (hipo * 0.0096).roundToDouble();
    _fontSize9 = (hipo * 0.0108).roundToDouble();
    _fontSize10 = (hipo * 0.012).roundToDouble();
    _fontSize11 = (hipo * 0.0132).roundToDouble();
    _fontSize12 = (hipo * 0.0144).roundToDouble();
    _fontSize13 = (hipo * 0.0156).roundToDouble();
    _fontSize14 = (hipo * 0.01677).roundToDouble();
    _fontSize15 = (hipo * 0.018).roundToDouble();
    _fontSize16 = (hipo * 0.0192).roundToDouble();
    _fontSize17 = (hipo * 0.0204).roundToDouble();
    _fontSize18 = (hipo * 0.0216).roundToDouble();
    _fontSize19 = (hipo * 0.0228).roundToDouble();
    _fontSize20 = (hipo * 0.024).roundToDouble();
    _fontSize24 = (hipo * 0.0288).roundToDouble();
    _fontSize27 = (hipo * 0.034).roundToDouble();
    _fontSize29 = (hipo * 0.0363).roundToDouble();
    _fontSize34 = (hipo * 0.055).roundToDouble();
    _fontSize50 = (hipo * 0.063).roundToDouble();
    _fontSize80 = (hipo * 0.1).roundToDouble();

    // logger.i(hipo * 0.055);

    //Icon size
    _iconSizeProfileCard = (hipo * 0.025).toDouble();
    _iconSizeWallet = (hipo * 0.05).toDouble();

    //

    _appBarBoxHeight = hipo * 0.06;
    _instrumentImageSize = _width * 0.08;
    return true;
  }
}