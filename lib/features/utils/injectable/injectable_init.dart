import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:surf_practice_chat_flutter/features/utils/injectable/injectable_init.config.dart';
import 'package:surf_practice_chat_flutter/features/utils/utils.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<GetIt> configureDependencies() async {
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<NotifyService>(NotifyService());

  return $initGetIt(getIt);
}
