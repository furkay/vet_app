import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:vet_app/core/providers/auth_providers.dart';

import 'models/user.dart';

var sl = GetIt.I;

Future setupLocator({bool startFromWidget = false}) async {
  sl.registerSingleton<Logger>(Logger());

  sl.registerSingleton<User>(User());

  //await sl<StartUpService>().startUp(startFromWidget);

  sl.registerLazySingleton<Auth>(() => Auth());
}
