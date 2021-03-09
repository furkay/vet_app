import 'package:flutter/material.dart';
import 'package:vet_app/core/constants/enums.dart';
import 'package:vet_app/core/providers/auth_providers.dart';
import 'package:vet_app/core/service_locator.dart';
import 'package:vet_app/core/view/base/base_state.dart';
import 'package:provider/provider.dart';
import 'package:vet_app/screens/home/test.dart';

class AuthControl extends StatefulWidget {
  @override
  _AuthControlState createState() => _AuthControlState();
}

class _AuthControlState extends BaseState<AuthControl> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sl<Auth>(),
      child: Consumer(
        builder: (BuildContext context, Auth authUser, _) {
          switch (authUser.status) {
            case Status.Uninitialized:
              break;
            case Status.Unauthenticated:
              break;
            case Status.Authenticating:
              break;
            case Status.Authenticated:
              break;
            default:
              break;
          }
          return Test();
        },
      ),
    );
  }
}
