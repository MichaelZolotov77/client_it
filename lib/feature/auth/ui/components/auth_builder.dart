import 'package:client_it/app/domain/error_entity/error_entity.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    Key? key,
    required this.isNotAuthorized,
    required this.isWaiting,
    required this.isAuthorized,
  }) : super(key: key);

  final WidgetBuilder isNotAuthorized;
  final WidgetBuilder isWaiting;
  final ValueWidgetBuilder isAuthorized;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.when(
          notAuthorized: () => isNotAuthorized(context),
          authorized: (userEntity) => isAuthorized(context, userEntity, this),
          waiting: () => isWaiting(context),
          error: (error) => isNotAuthorized(context),
        );
      },
      listenWhen: (previous, current) =>
          previous.mapOrNull(
            error: (value) => value,
          ) !=
          current.mapOrNull(error: (value) => value),
      listener: (context, state) {
        state.whenOrNull(
          error: (error) =>
              _showSnackBar(context, ErrorEntity.fromException(error)),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, ErrorEntity error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(
              maxLines: 5,
              "Error: ${error.errorMessage}, Message: ${error.message}"),
        ),
      ),
    );
  }
}


/* 
5.10 AuthBuilder автоматически перестраивает интерфейс в зависимости от того,
авторизован пользователь или не авторизован. В билдере используем BlocConsumer,
потому что нам нужен и listener и builder. В builder надо описать все наши
состояния. В listener указываем, если ошибка. Показываем при этом нижний
снекбар c задержкой 5 сек и 5ю максимальными линиями.
Еще добавим условие, что будет слушать только тогда, когда предыдущее значение
ошибки и текущее значение ошибки поменялось, чтобы не было постоянных ненужных
перестроек. Используем listenWhen. Предыдуще значение ошибки должно быть другим.
Если они разные, показываем этот снекбар, если повторяется, но снекбар
больше не показываем.
 */
