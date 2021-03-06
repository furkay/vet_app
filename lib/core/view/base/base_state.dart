import 'package:flutter/material.dart';
import 'package:vet_app/core/constants/size_config.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  
   final width = SizeConfig.width;
  final height = SizeConfig.height;
  
  EdgeInsets allPadding(double value) => SizeConfig.allPadding(value);
  EdgeInsets symmetricPadding({double horizontal = 0, double vertical = 0}) =>
      SizeConfig.symmetricPadding(horizontal: horizontal, vertical: vertical);
  EdgeInsets onlyPadding(
          {double left = 0,
          double top = 0,
          double right = 0,
          double bottom = 0}) =>
      SizeConfig.onlyPadding(
          left: left, top: top, right: right, bottom: bottom);
}