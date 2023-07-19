import 'package:client_it/app/di/init_di.dart';
import 'package:client_it/app/domain/app_builder.dart';
import 'package:client_it/feature/auth/domain/auth_repository.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return const _GlobalProviders(
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text("Hello"),
          ),
        ),
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({Key? key, required this.child}) : super(key: key);
  final Widget child; // транзитом отправляем дальше вниз по дереву виджетов

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthCubit(locator<AuthRepository>()),
      )
    ], child: child);
  }
}


/* 
5.11 Инициализируем AuthCubit для того, чтобы его можно было использовать
внизу по дереву виджетов, то есть глобально в всем приложении. Мы должны его
инициализировать до того, как мы запускаем MaterialApp. В _GlobalProviders
мы будем инициализировать все наши глобальные кубиты. Вместо контейнера будет
MultiBlocProvider. Оборачиваем MaterialApp в _GlobalProviders. Таким образом, 
всё наше приложение будет иметь доступ к AuthCubit. В  AuthCubit нужно передать
репозиторий, который будем брать из локатора. Локатор нам вернет именно тот
репозиторий, который был инициализирован при сборке.
 */
