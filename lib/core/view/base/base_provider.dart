import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../service_locator.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool isMounted;
  var logger = sl<Logger>();
  BaseProvider() {
    isMounted = true;
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }
}
