import 'package:client_it/app/ui/app_loader.dart';
import 'package:client_it/feature/auth/ui/components/auth_builder.dart';
import 'package:client_it/feature/auth/ui/login_screen.dart';
import 'package:client_it/feature/main/ui/main_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
      isNotAutorized: (context) => LoginScreen(),
      isWaiting: (context) => const AppLoader(),
      isAuthorized: (context, value, child) => MainScreen(userEntity: value),
    );
  }
}

// 5.12 отсюда стартует приложение. Необходимо реализовать каждое из трех
// состояний. AppLoader общий на всё приложение. Обычно он стилизован под
// продукт или компанию, но тут будет проще. Из AuthBuilder при авторизации
// мы возвращаем value, это как раз и есть userEntity. Если мы в приложении
// мы выйдем из логина, то автоматически перейдем на LoginScreen.
