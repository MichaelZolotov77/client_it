import 'package:client_it/app/domain/app_config.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AppConfig) // синглтон инжектим как AppConfig
@prod
class ProdAppConfig implements AppConfig {
  @override
  String get baseUrl => "http://94.250.255.23";

  @override
  String get host => Environment.prod;
}

@Singleton(as: AppConfig)
@dev
class DevAppConfig implements AppConfig {
  @override
  String get baseUrl => "https://localhost:8080";

  @override
  String get host => Environment.dev;
}

@Singleton(as: AppConfig)
@test
class TestAppConfig implements AppConfig {
  @override
  String get baseUrl =>
      "https://localhost:8080"; // будем использовать моковые данные

  @override
  String get host => Environment.test;
}

// три конфигурации приложения: prod, dev, test.
