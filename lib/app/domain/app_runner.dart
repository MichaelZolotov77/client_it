import 'app_builder.dart';

abstract class AppRunner {
  Future<void> preloadData(); //подготовка к пуску

  Future<void> run(AppBuilder appBuilder);
}
