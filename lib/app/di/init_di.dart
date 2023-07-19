import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'init_di.config.dart';

final locator = GetIt.instance; // инициализация локатора

// сам инициализатор зависимостей
@InjectableInit()
void initDi(String env) {
  locator.init(environment: env);
}

// GetIt нужен, чтобы реализовать Service Locator.
