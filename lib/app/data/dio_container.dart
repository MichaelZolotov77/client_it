import 'package:client_it/app/data/auth_interceptor.dart';
import 'package:client_it/app/domain/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton() // инжектим, чтобы он автоматически внеднялся в наши зависимости
class DioContainer {
  late final Dio dio;

  DioContainer(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
    );
    dio = Dio(options);
    if (kDebugMode) addInterceptor(PrettyDioLogger());
    addInterceptor(AuthInterceptor());
  }

  void addInterceptor(Interceptor interceptor) {
    if (dio.interceptors.contains(interceptor)) {
      dio.interceptors.remove(interceptor);
    }
    deleteInterceptor(interceptor.runtimeType);

    dio.interceptors.add(interceptor);
  }

  void deleteInterceptor(Type type) {
    dio.interceptors.removeWhere((element) => element.runtimeType == type);
  }
}

//5.5 Добавили плагин dio, с помощью которого мы будем реализовывать
// http-клиент. Здесь создан dio-контейнер, который содержит всю
// необходимую информацию для работы с сетью

// Добавление jvt-токенов в запрос. Неудобно держать jvt-токены в 
// памяти, записывать егов каждый запрос итд. Для этого используются
// интерцепторы. Интерцептор автоматически вставляет jvt-токен в 
// запрос, и когда нам нужно мы его можем спокойно удалить или добавить
// заново. Добавление интерцептора. Если массив интерцептово содержит
// интерцептор, который мы хотим добавить, то мы его удалим из этого 
// массива. При удалении мы удаляем элементы, у которых совпадает тип.
// Тоесть добавляем интерцептор только тогда, когда массив его не содержит.