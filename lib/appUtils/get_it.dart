import 'package:get_it/get_it.dart';

import 'navigator.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
