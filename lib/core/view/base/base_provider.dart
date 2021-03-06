
import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool isMounted;
  BaseProvider() {
    isMounted = true;
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }
}