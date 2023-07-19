import 'package:client_it/app/ui/main_app_builder.dart';
import 'package:client_it/app/ui/main_app_runner.dart';

void main() {
  const env = String.fromEnvironment("env", defaultValue: "dev");
  const runner = MainAppRunner(env);
  final builder = MainAppBuilder();
  runner.run(builder);
}

// env это Environment значение, с помощью него мы можем инициализировать
// наше приложение как dev или prod. Эти значения мы будем получать
// при сборке извне.
